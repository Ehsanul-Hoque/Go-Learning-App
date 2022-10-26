package com.golearningbd.app.commons.utils

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import org.jetbrains.annotations.Contract


object Tools
{

    fun openMarketPlace(context: Context, packageName: String) {
        try {
            context.startActivity(
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("market://details?id=$packageName")
                )
            )

        } catch (e: ActivityNotFoundException) {
            context.startActivity(
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("https://play.google.com/store/apps/details?id=$packageName")
                )
            )
        }
    }

    private fun superTrim(text: String): String {
        return text.replace("\u00A0".toRegex(), " ").trim { it <= ' ' }
    }

    @Contract("null, false -> null")
    fun superTrimAndHandleNullHardcodedText(text: String?, replaceNullWithEmptyString: Boolean)
            : String? {
        var textLocal = text
        if (textLocal == null) {
            if (replaceNullWithEmptyString) textLocal = ""
            return textLocal
        }

        textLocal = superTrim(textLocal)
        if (textLocal.equals("null", ignoreCase = true)) {
            textLocal = if (replaceNullWithEmptyString) "" else null
        }

        return textLocal
    }

}
