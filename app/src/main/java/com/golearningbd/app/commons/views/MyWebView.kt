package com.golearningbd.app.commons.views

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.AttributeSet
import android.view.View
import android.view.ViewGroup
import android.webkit.CookieManager
import android.webkit.DownloadListener
import android.webkit.WebSettings
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.golearningbd.app.commons.MyWebViewCallback
import com.golearningbd.app.commons.utils.MyWebChromeClient
import com.golearningbd.app.commons.utils.MyWebViewClient
import com.golearningbd.app.commons.utils.ToggledFullscreenCallback


class MyWebView : ObservableWebView
{

    // Fields
    private var mWebViewClient: MyWebViewClient? = null
    var mWebChromeClient: MyWebChromeClient? = null
    private var addedJavascriptInterface = false


    // Constructors
    constructor(context: Context): super(context)
    constructor(context: Context, attrs: AttributeSet?): super(context, attrs)
    constructor(context: Context, attrs: AttributeSet?, defStyle: Int)
            : super(context, attrs, defStyle)


    // Methods
    @SuppressLint("SetJavaScriptEnabled")
    fun init(activity: Activity, activityNonVideoView: View?, activityVideoView: ViewGroup?,
             loadingView: View?, myWebViewCallback: MyWebViewCallback,
             downloadListener: DownloadListener) {
        // Init fields
        mWebViewClient = MyWebViewClient(myWebViewCallback)
        mWebChromeClient = MyWebChromeClient(
            activityNonVideoView,
            activityVideoView,
            loadingView,
            this,
            myWebViewCallback
        ).apply {
            setOnToggledFullscreen(object : ToggledFullscreenCallback {
                override fun toggledFullscreen(fullscreen: Boolean) {
                    // Your code to handle the full-screen change,
                    // for example showing and hiding the title bar. Example:
                    if (fullscreen) {
                        /*val attrs: WindowManager.LayoutParams = activity.window.attributes

                        attrs.flags = attrs.flags or WindowManager.LayoutParams.FLAG_FULLSCREEN
                        attrs.flags = attrs.flags or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON

                        activity.window.attributes = attrs
                        activity.window.decorView.systemUiVisibility =
                            View.SYSTEM_UI_FLAG_LOW_PROFILE*/

                        WindowCompat.setDecorFitsSystemWindows(activity.window, false)
                        WindowInsetsControllerCompat(activity.window, activity.window.decorView).let { controller ->
                            controller.hide(WindowInsetsCompat.Type.systemBars())
                            controller.systemBarsBehavior =
                                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
                        }

                    } else {
                        /*val attrs: WindowManager.LayoutParams = activity.window.attributes

                        attrs.flags =
                            attrs.flags and WindowManager.LayoutParams.FLAG_FULLSCREEN.inv()
                        attrs.flags =
                            attrs.flags and WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON.inv()

                        activity.window.attributes = attrs
                        activity.window.decorView.systemUiVisibility =
                            View.SYSTEM_UI_FLAG_VISIBLE*/
                        WindowCompat.setDecorFitsSystemWindows(activity.window, true)
                        WindowInsetsControllerCompat(activity.window, activity.window.decorView)
                            .show(WindowInsetsCompat.Type.systemBars())
                    }
                }
            })
        }

        // Set up the web view
        setLayerType(View.LAYER_TYPE_HARDWARE, null)

        webViewClient = mWebViewClient as MyWebViewClient
        webChromeClient = mWebChromeClient
        setDownloadListener(downloadListener)
        settings.javaScriptEnabled = true
        // settings.setAppCacheEnabled(true)
        /*getSettings().setAppCachePath(getCacheDir().getAbsolutePath())*/
        settings.cacheMode = WebSettings.LOAD_DEFAULT
        settings.domStorageEnabled = true
        settings.databaseEnabled = true
        settings.javaScriptCanOpenWindowsAutomatically = true
        settings.setSupportMultipleWindows(false)
        settings.setSupportZoom(false)
        settings.builtInZoomControls = true
        settings.displayZoomControls = false
        settings.defaultTextEncodingName = "utf-8"
        settings.loadsImagesAutomatically = true
        CookieManager.getInstance().setAcceptCookie(true)
        settings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        CookieManager.getInstance().setAcceptThirdPartyCookies(this, true)
    }

    override fun loadData(data: String, mimeType: String?, encoding: String?) {
        addJavascriptInterface()
        super.loadData(data, mimeType, encoding)
    }

    override fun loadDataWithBaseURL(baseUrl: String?, data: String, mimeType: String?,
                                     encoding: String?, historyUrl: String?) {
        addJavascriptInterface()
        super.loadDataWithBaseURL(baseUrl, data, mimeType, encoding, historyUrl)
    }

    override fun loadUrl(url: String, additionalHttpHeaders: MutableMap<String, String>) {
        addJavascriptInterface()
        super.loadUrl(url, additionalHttpHeaders)
    }

    override fun loadUrl(url: String) {
        addJavascriptInterface()
        super.loadUrl(url)
    }

    /**
     * Indicates if the video is being displayed using a custom view (typically full-screen)
     * @return true it the video is being displayed using a custom view (typically full-screen)
     */
    fun isVideoFullscreen(): Boolean {
        return (mWebChromeClient != null) && (mWebChromeClient?.isVideoFullscreen() == true)
    }

    private fun addJavascriptInterface() {
        if (!addedJavascriptInterface) {
            // Add javascript interface to be called when the video ends
            // (must be done before page load)
            addJavascriptInterface(
                JavascriptInterface(mWebChromeClient),
                "_MyWebView"
            ) // Must match Javascript interface name of MyWebChromeClient
            addedJavascriptInterface = true
        }
    }



    class JavascriptInterface(private val mWebChromeClient: MyWebChromeClient?)
    {

        // Must match Javascript interface method of MyWebChromeClient
        @android.webkit.JavascriptInterface
        fun notifyVideoEnd() {
            // This code is not executed in the UI thread, so we must force that to happen
            Handler(Looper.getMainLooper()).post { mWebChromeClient?.onHideCustomView() }
        }

    }

}
