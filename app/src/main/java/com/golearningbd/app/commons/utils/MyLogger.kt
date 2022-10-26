package com.golearningbd.app.commons.utils

import android.util.Log
import com.golearningbd.app.BuildConfig

@Suppress("unused", "MemberVisibilityCanBePrivate")
object MyLogger
{

    private const val TAG = "MY_LOGGER"
    private var enabled: Boolean = BuildConfig.DEBUG

    fun isEnabled(): Boolean {
        return enabled
    }

    fun setEnabled(enabled: Boolean) {
        MyLogger.enabled = enabled
    }

    fun d(message: String) {
        d(TAG, message)
    }

    fun d(tag: String, message: String) {
        if (enabled) Log.d(tag, message)
    }

    fun e(throwable: Throwable?) {
        e(TAG, "", throwable)
    }

    fun e(message: String) {
        e(TAG, message, null)
    }

    fun e(message: String, throwable: Throwable?) {
        e(TAG, message, throwable)
    }

    @JvmOverloads
    fun e(tag: String, message: String, throwable: Throwable? = null) {
        if (enabled) Log.e(tag, message, throwable)
    }
}
