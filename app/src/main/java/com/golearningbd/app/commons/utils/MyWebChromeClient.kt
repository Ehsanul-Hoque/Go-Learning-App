package com.golearningbd.app.commons.utils

import android.media.MediaPlayer
import android.os.Message
import android.view.SurfaceView
import android.view.View
import android.view.ViewGroup
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.widget.FrameLayout
import android.widget.VideoView
import com.golearningbd.app.commons.MyWebViewCallback
import com.golearningbd.app.commons.views.MyWebView


class MyWebChromeClient: WebChromeClient, MediaPlayer.OnPreparedListener, MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener
{

    companion object {
        private const val TAG = "[MyWebChromeClient]"
    }

    private var activityNonVideoView: View? = null
    private var activityVideoView: ViewGroup? = null
    private var loadingView: View? = null
    private var myWebView: MyWebView? = null

    private var isVideoFullscreen = false // Indicates if the video is being displayed using a custom view (typically full-screen)
    private var videoViewContainer: FrameLayout? = null
    private var videoViewCallback: CustomViewCallback? = null

    private var toggledFullscreenCallback: ToggledFullscreenCallback? =
        null

    private var myWebViewCallback: MyWebViewCallback? = null

    /**
     * Never use this constructor alone.
     * This constructor allows this class to be defined as an inline inner class
     * in which the user can override methods
     */
    @Suppress("unused")
    constructor(): super()

    /**
     * Builds a video enabled WebChromeClient.
     *
     * @param activityNonVideoView A View in the activity's layout that contains every other view
     * that should be hidden when the video goes full-screen.
     * @param activityVideoView A ViewGroup in the activity's layout that will display the video.
     * Typically you would like this to fill the whole layout
     * @param loadingView A View to be shown while the video is loading
     * (typically only used in API level <11). Must be already inflated and without a parent view.
     * @param webView The owner MyWebView. Passing it will enable the MyWebChromeClient
     * to detect the HTML5 video ended event and exit full-screen.
     * @param myWebViewCallback MyWebViewCallback to do something
     * when page loading starts, ends, progress changes etc.
     *
     * Note: The web page must only contain one video tag in order for the
     * HTML5 video ended event to work. This could be improved if needed (see Javascript code).
     */
    constructor(activityNonVideoView: View?, activityVideoView: ViewGroup?, loadingView: View?,
                webView: MyWebView, myWebViewCallback: MyWebViewCallback?) {
        this.activityNonVideoView = activityNonVideoView
        this.activityVideoView = activityVideoView
        this.loadingView = loadingView
        this.myWebView = webView
        this.myWebViewCallback = myWebViewCallback
        isVideoFullscreen = false
    }


    override fun onCreateWindow(view: WebView?, isDialog: Boolean, isUserGesture: Boolean,
                                resultMsg: Message?): Boolean {
        val subTag = "$TAG [onCreateWindow()]"
        val result = view?.hitTestResult
        val data = result?.extra
        MyLogger.d("$subTag view?.hitTestResult?.extra = $data")

        val transport = resultMsg?.obj as WebView.WebViewTransport?
        transport?.webView = view
        resultMsg?.sendToTarget()
        MyLogger.d(
            "$subTag [url = ${view?.url}] [original url = ${view?.originalUrl}]" +
                    " new window created"
        )
        return true
    }

    override fun onProgressChanged(view: WebView?, newProgress: Int) {
        val subTag = "$TAG [onProgressChanged()]"

        super.onProgressChanged(view, newProgress)

        myWebViewCallback?.onProgressChanged(view, newProgress)
        MyLogger.d(
            "$subTag [url = ${view?.url}] [original url = ${view?.originalUrl}]" +
                    " progress = $newProgress"
        )
    }

    // Available in API level 14+, deprecated in API level 18+
    @Deprecated("Deprecated in Java", ReplaceWith("onShowCustomView(view, callback)"))
    override fun onShowCustomView(view: View?, requestedOrientation: Int,
                                  callback: CustomViewCallback?) {
        onShowCustomView(view, callback)
    }

    override fun onShowCustomView(view: View?, callback: CustomViewCallback?) {
        if (view is FrameLayout) {
            // A video wants to be shown
            val focusedChild = view.focusedChild

            // Save video related variables
            isVideoFullscreen = true
            videoViewContainer = view
            videoViewCallback = callback

            // Hide the non-video view, add the video view, and show it
            activityNonVideoView?.visibility = View.INVISIBLE
            activityVideoView?.addView(
                videoViewContainer,
                ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
            )
            activityVideoView?.visibility = View.VISIBLE
            if (focusedChild is VideoView) {
                // android.widget.VideoView (typically API level <11)
                // Handle all the required events
                focusedChild.setOnPreparedListener(this)
                focusedChild.setOnCompletionListener(this)
                focusedChild.setOnErrorListener(this)

            } else {
                // Other classes, including:
                //
                // - android.webkit.HTML5VideoFullScreen$VideoSurfaceView,
                // which inherits from android.view.SurfaceView (typically API level 11-18)
                //
                // - android.webkit.HTML5VideoFullScreen$VideoTextureView,
                // which inherits from android.view.TextureView (typically API level 11-18)
                //
                // - com.android.org.chromium.content.browser.ContentVideoView$VideoSurfaceView,
                // which inherits from android.view.SurfaceView (typically API level 19+)
                //
                // Handle HTML5 video ended event only if the class is a SurfaceView
                // Test case: TextureView of Sony Xperia T API level 16 doesn't work fullscreen
                // when loading the javascript below
                if ((myWebView?.settings?.javaScriptEnabled == true)
                    && (focusedChild is SurfaceView)) {
                    // Run javascript code that detects the video end
                    // and notifies the Javascript interface
                    var js = "javascript:"
                    js += "var _ytrp_html5_video_last;"
                    js += "var _ytrp_html5_video = document.getElementsByTagName('video')[0];"
                    js += "if (_ytrp_html5_video != undefined && _ytrp_html5_video != _ytrp_html5_video_last) {"
                    run {
                        js += "_ytrp_html5_video_last = _ytrp_html5_video;"
                        js += "function _ytrp_html5_video_ended() {"
                        run {
                            js += "_MyWebView.notifyVideoEnd();"
                            // Must match Javascript interface name and method of MyWebView
                        }
                        js += "}"
                        js += "_ytrp_html5_video.addEventListener('ended', _ytrp_html5_video_ended);"
                    }
                    js += "}"
                    myWebView?.loadUrl(js)
                }
            }

            // Notify full-screen change
            if (toggledFullscreenCallback != null) {
                toggledFullscreenCallback!!.toggledFullscreen(true)
            }
        }

        myWebViewCallback?.onShowCustomView(view, callback)
    }

    override fun onHideCustomView() {
        // This method should be manually called on video end in all cases because it's not always called automatically.
        // This method must be manually called on back key press (from this class' onBackPressed() method).
        if (isVideoFullscreen) {
            // Hide the video view, remove it, and show the non-video view
            activityVideoView?.visibility = View.INVISIBLE
            activityVideoView?.removeView(videoViewContainer)
            activityNonVideoView?.visibility = View.VISIBLE

            // Call back (only in API level <19, because in API level 19+ with chromium webview it crashes)
            if (videoViewCallback != null &&
                !videoViewCallback!!::class.java.name.contains(".chromium.")) {
                videoViewCallback!!.onCustomViewHidden()
            }

            // Reset video related variables
            isVideoFullscreen = false
            videoViewContainer = null
            videoViewCallback = null

            // Notify full-screen change
            if (toggledFullscreenCallback != null) {
                toggledFullscreenCallback!!.toggledFullscreen(false)
            }
        }

        myWebViewCallback?.onHideCustomView()
    }

    // Video will start loading
    override fun getVideoLoadingProgressView(): View? {
        loadingView?.visibility = View.VISIBLE
        return loadingView ?: super.getVideoLoadingProgressView()
    }

    // Video will start playing, only called in the case of android.widget.VideoView
    // (typically API level < 11)
    override fun onPrepared(mp: MediaPlayer?) {
        loadingView?.visibility = View.GONE
    }

    // Video finished playing, only called in the case of android.widget.VideoView
    // (typically API level < 11)
    override fun onCompletion(mp: MediaPlayer?) {
        onHideCustomView()
    }

    // Error while playing video, only called in the case of android.widget.VideoView
    // (typically API level < 11)
    override fun onError(mp: MediaPlayer?, what: Int, extra: Int): Boolean {
        return false // By returning false, onCompletion() will be called
    }


    /**
     * Indicates if the video is being displayed using a custom view (typically full-screen)
     * @return true it the video is being displayed using a custom view (typically full-screen)
     */
    fun isVideoFullscreen(): Boolean {
        return isVideoFullscreen
    }

    /**
     * Set a callback that will be fired when the video starts or finishes
     * displaying using a custom view (typically full-screen)
     *
     * @param callback A MyWebChromeClient.ToggledFullscreenCallback callback
     */
    fun setOnToggledFullscreen(callback: ToggledFullscreenCallback?) {
        toggledFullscreenCallback = callback
    }

    /**
     * Notifies the class that the back key has been pressed by the user.
     * This must be called from the Activity's onBackPressed(), and if it returns false,
     * the activity itself should handle it. Otherwise don't do anything.
     *
     * @return Returns true if the event was handled, and false if was not
     * (video view is not visible)
     */
    fun onBackPressed(): Boolean {
        return if (isVideoFullscreen) {
            onHideCustomView()
            true

        } else
            false
    }

}
