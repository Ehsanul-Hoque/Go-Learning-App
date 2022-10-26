package com.golearningbd.app.web_module.views

import android.Manifest
import android.app.DownloadManager
import android.content.Context
import android.content.pm.ActivityInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.text.TextUtils
import android.view.View
import android.webkit.CookieManager
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.golearningbd.app.R
import com.golearningbd.app.commons.MyWebViewCallback
import com.golearningbd.app.commons.data.Constants
import com.golearningbd.app.commons.utils.MyLogger
import com.golearningbd.app.commons.utils.Tools
import com.golearningbd.app.commons.views.MyWebView
import java.util.Locale
import java.util.Random


class WebViewActivity : AppCompatActivity()
{

    companion object {
        private const val TAG = "[WebViewActivity]"
    }

    // Field(s)
    private var webView: MyWebView? = null
    private var frameLayoutProgress: FrameLayout? = null
    private var progressWheelWebsiteLoading: ProgressBar? = null
    private var textViewProgressPercentage: TextView? = null
    private var frameLayoutFullScreen: FrameLayout? = null

    private var httpUrl = ""
    private var downloadUrl: String? = null
    private var userAgent: String? = null

    private var mOriginalOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT

    private lateinit var onBackPressedCallback: OnBackPressedCallback


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web_view)

        httpUrl = Constants.DEFAULT_URL

        initViewFields()
        initListeners()
        setUpWebView()
        goToSite(httpUrl)
    }

    override fun onResume() {
        super.onResume()
        webView?.onResume()
    }

    override fun onPause() {
        super.onPause()
        webView?.onPause()
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>,
                                            grantResults: IntArray) {
        if (requestCode.toString().startsWith(Constants.DOWNLOAD_REQUEST_CODE_PREFIX)) {
            var grantedAll = false
            var i = 0
            val len = permissions.size
            while (i < len) {
                val permission = permissions[i]
                val grantResult = grantResults[i]
                if ((permission == Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    && (grantResult == PackageManager.PERMISSION_GRANTED)) {
                    grantedAll = true
                }
                ++i
            }

            if (grantedAll && !TextUtils.isEmpty(downloadUrl))
                showDownloadConfirmationDialog(downloadUrl!!, userAgent!!)

            else
                Toast.makeText(
                    this,
                    R.string.error_could_not_download,
                    Toast.LENGTH_LONG
                ).show()

        } else
            super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    private fun initViewFields() {
        webView = findViewById(R.id.webView)
        frameLayoutProgress = findViewById(R.id.frameLayout_progress)
        progressWheelWebsiteLoading = findViewById(R.id.progressWheel_websiteLoading)
        textViewProgressPercentage = findViewById(R.id.textView_progressPercentage)

        frameLayoutFullScreen = findViewById(R.id.frameLayout_fullScreen)
    }

    private fun initListeners() {
        onBackPressedCallback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                // Notify the MyWebChromeClient, and handle it ourselves if it doesn't handle it
                if (webView?.mWebChromeClient?.onBackPressed() != true) {
                    if (webView?.canGoBack() == true)
                        webView?.goBack()
                    else
                        // Close app (presumably)
                        finish()
                }
            }
        }

        onBackPressedDispatcher.addCallback(this, onBackPressedCallback)
    }

    private fun goToSite(url: String) {
        val subTag = "$TAG [goToSite()]"
        MyLogger.d("$subTag url = $url")
        httpUrl = url
        webView?.loadUrl(httpUrl)
        frameLayoutProgress?.visibility = View.VISIBLE
    }

    private fun setUpWebView() {
        webView?.init(
            this,
            webView,
            frameLayoutFullScreen,
            frameLayoutProgress,
            object : MyWebViewCallback {
                override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                    frameLayoutProgress?.visibility = View.VISIBLE
                }

                override fun onProgressChanged(view: WebView?, newProgress: Int) {
                    textViewProgressPercentage?.text = String.format(
                        Locale.getDefault(),
                        "%02d",
                        newProgress
                    )
                    progressWheelWebsiteLoading?.progress = (newProgress / 100.0f).toInt()
                }

                override fun onPageFinished(view: WebView?, url: String?) {
                    frameLayoutProgress?.visibility = View.GONE
                }

                override fun onShowCustomView(view: View?,
                                              callback: WebChromeClient.CustomViewCallback?) {
                    mOriginalOrientation = resources.configuration.orientation
                    requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
                }

                override fun onHideCustomView() {
                    requestedOrientation = mOriginalOrientation
                }
            }
        ) { url: String, userAgent: String, _, _, _ ->
            val subTag = "$TAG [in the DownloadListener.onDownloadStart()]"
            if (!TextUtils.isEmpty(url)) {
                MyLogger.d("$subTag url to download = $url")
                checkForDownloadPermission(url, userAgent)

            } else {
                Toast.makeText(
                    this,
                    R.string.error_could_not_download,
                    Toast.LENGTH_LONG
                ).show()
                MyLogger.e("$subTag url = \"$url\" in downloadListener")
            }
        }
    }

    private fun checkForDownloadPermission(url: String, userAgent: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_GRANTED) {
                // Do this, if permission granted
                showDownloadConfirmationDialog(url, userAgent)

            } else {
                // Do this, if there is no permission
                this.downloadUrl = url
                this.userAgent = userAgent
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    (Constants.DOWNLOAD_REQUEST_CODE_PREFIX + Random().nextInt(100)).toInt()
                )
            }

        } else {
            // Code for devices below API 23 or Marshmallow
            showDownloadConfirmationDialog(url, userAgent)
        }
    }

    private fun showDownloadConfirmationDialog(originalUrl: String, userAgent: String) {
        val subTag = "$TAG [showDownloadConfirmationDialog()]"
        var url = originalUrl
        url = Tools.superTrimAndHandleNullHardcodedText(url, true)!!

        if (url.isNotEmpty() && url.endsWith("/"))
            url = url.substring(0, url.length - 1)

        val urlParts = url.split("/".toRegex()).toTypedArray()
        var fileName: String
        fileName = if (urlParts.isNotEmpty()) urlParts[urlParts.size - 1] else url

        if (TextUtils.isEmpty(fileName)) fileName =
            System.currentTimeMillis().toString() + ""

        AlertDialog.Builder(this)
            .setTitle(R.string.title_download)
            .setMessage(R.string.message_download)
            .setPositiveButton(R.string.yes_download) { _, _ ->
                val subSubTag = "$subTag [in the setPositiveButton.OnClickListener.onClick()]"
                Toast.makeText(this, R.string.download_starting, Toast.LENGTH_LONG).show()

                val request = DownloadManager.Request(Uri.parse(url))
                val cookie = CookieManager.getInstance().getCookie(url)

                request.addRequestHeader("Cookie", cookie)
                request.addRequestHeader("User-Agent", userAgent)
                @Suppress("DEPRECATION")
                request.allowScanningByMediaScanner()
                // Download is visible and its progress, after completion too.
                request.setNotificationVisibility(
                    DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED
                )

                try {
                    request.setDestinationInExternalPublicDir(
                        Environment.DIRECTORY_DOWNLOADS,
                        fileName
                    )

                    (getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager)
                        .enqueue(request)

                } catch (e: Exception) {
                    MyLogger.e("$subSubTag e.message = \"${e.message}\"", e)
                }
            }
            .setNegativeButton(R.string.no_cancel, null)
            .show()

        frameLayoutProgress?.visibility = View.GONE
    }

}
