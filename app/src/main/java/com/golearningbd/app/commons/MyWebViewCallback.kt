package com.golearningbd.app.commons

import android.graphics.Bitmap
import android.view.View
import android.webkit.WebChromeClient
import android.webkit.WebView


interface MyWebViewCallback
{

    fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?)

    fun onProgressChanged(view: WebView?, newProgress: Int)

    fun onPageFinished(view: WebView?, url: String?)

    fun onShowCustomView(view: View?, callback: WebChromeClient.CustomViewCallback?)

    fun onHideCustomView()

}
