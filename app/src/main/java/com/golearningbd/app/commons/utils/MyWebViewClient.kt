package com.golearningbd.app.commons.utils

import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.text.TextUtils
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.golearningbd.app.R
import com.golearningbd.app.commons.MyWebViewCallback
import com.golearningbd.app.commons.app.App
import java.util.regex.Pattern


class MyWebViewClient(private val myWebViewCallback: MyWebViewCallback): WebViewClient()
{

    companion object {
        private const val TAG = "[MyWebViewClient]"
    }


    override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
        @Suppress("DEPRECATION")
        return if (request?.url != null)
            shouldOverrideUrlLoading(view, request.url.toString())
        else
            super.shouldOverrideUrlLoading(view, request)
    }

    @Deprecated("Deprecated in Java")
    override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
        val subTag = "$TAG [shouldOverrideUrlLoading()]"
        MyLogger.d("$subTag [url = $url]")

        if (url?.startsWith("intent://") == true) {
            // Check if it is Google Play Store intent
            if (url.startsWith("intent://play.app.goo.gl")) {
                val matcher = Pattern.compile("(?<=id=).+?(?=#)")
                    .matcher(Uri.decode(url))

                if (matcher.find()) {
                    val result = matcher.group(0)
                    MyLogger.d("$subTag matcher found for marketplace intent!" +
                            " (url starts with intent) result = " + result)

                    if (!TextUtils.isEmpty(result)) {
                        Tools.openMarketPlace(App.instance, result!!)
                        return true
                    }
                }
            }

            // Check if it is Facebook Messenger intent
            else if (url.contains("scheme=fb-messenger")) {
                val matcher = Pattern.compile("(?<=intent://user/).+?(?=/)")
                    .matcher(Uri.decode(url))

                if (matcher.find()) {
                    val result = matcher.group(0)
                    MyLogger.d("$subTag matcher found for facebook messenger intent!" +
                            " (url starts with intent) result = " + result)

                    if (!TextUtils.isEmpty(result)) {
                        ActivityStarters.openFacebookMessenger(App.instance, result!!)
                        return true
                    }
                }

            } else {
                Toast.makeText(
                    view?.context,
                    R.string.error_could_not_open_any_app,
                    Toast.LENGTH_LONG
                ).show()
            }
        }

        @Suppress("DEPRECATION")
        return super.shouldOverrideUrlLoading(view, url)
    }

    @Deprecated("Deprecated in Java")
    override fun onReceivedError(view: WebView?, errorCode: Int, description: String?,
                                 failingUrl: String?) {
        val subTag = "$TAG [onReceivedError()]"
        MyLogger.e("$subTag errorCode = $errorCode, description = $description")
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onReceivedError(view: WebView?, request: WebResourceRequest?,
                                 error: WebResourceError?) {
        // Redirect to deprecated method, so you can use it in all SDK versions
        @Suppress("DEPRECATION")
        onReceivedError(
            view,
            error?.errorCode ?: -1,
            error?.description.toString(),
            request?.url.toString()
        )
    }

    override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
        val subTag = "$TAG [onPageStarted()]"

        myWebViewCallback.onPageStarted(view, url, favicon)
        MyLogger.d("$subTag [url = $url]")

        super.onPageStarted(view, url, favicon)
    }

    override fun onPageFinished(view: WebView?, url: String?) {
        val subTag = "$TAG [onPageStarted()]"

        myWebViewCallback.onPageFinished(view, url)
        MyLogger.d("$subTag [url = $url]")

        super.onPageFinished(view, url)
    }



}
