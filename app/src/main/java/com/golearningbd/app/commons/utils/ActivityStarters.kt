package com.golearningbd.app.commons.utils

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.Toast
import androidx.annotation.StringRes


object ActivityStarters
{

    fun openDialingApp(context: Context, contactNo: String, @StringRes errorStringRes: Int)
    {
        val uri: Uri = Uri.parse("tel:$contactNo")
        val openDialApp = Intent(Intent.ACTION_DIAL, uri)

        try {
            context.startActivity(openDialApp)

        } catch (e: ActivityNotFoundException) {
            if (errorStringRes != 0)
                Toast.makeText(context, errorStringRes, Toast.LENGTH_LONG).show()
            MyLogger.e("openDialingApp: " + e.message, e)
        }
    }

    fun openFacebookMessenger(context: Context, userId: String)
    {
        val uri: Uri = Uri.parse("http://m.me/${userId}")
        val openDialApp = Intent(Intent.ACTION_VIEW, uri)

        try {
            context.startActivity(openDialApp)

        } catch (e: ActivityNotFoundException) {
            Tools.openMarketPlace(context, "com.facebook.orca")
        }
    }

}
