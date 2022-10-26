package com.golearningbd.app

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ProgressBar
import android.widget.TextView
import androidx.annotation.NonNull
import androidx.annotation.StringRes
import androidx.appcompat.app.AppCompatActivity
import com.golearningbd.app.commons.data.Constants
import com.golearningbd.app.commons.utils.ActivityStarters
import com.golearningbd.app.commons.utils.MyLogger
import com.google.android.gms.tasks.Task
import com.google.android.play.core.appupdate.AppUpdateInfo
import com.google.android.play.core.appupdate.AppUpdateManagerFactory
import com.google.android.play.core.install.InstallException
import com.google.android.play.core.install.model.AppUpdateType
import com.google.android.play.core.install.model.UpdateAvailability
import java.lang.Exception

class MainActivity : AppCompatActivity() {
    private var progressWheel: ProgressBar? = null
    private var textViewError: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initViewFields()
        requestAppUpdateIfAvailable()
    }

    @Suppress("DEPRECATION")
    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == Constants.APP_UPDATE_REQUEST_CODE) {
            if (resultCode != RESULT_OK) {
                MyLogger.e("Update flow failed! Result code: $resultCode")

                progressWheel?.visibility = View.GONE
                textViewError?.text = getString(R.string.error_update_app);
            }
        }
    }

    private fun initViewFields() {
        progressWheel = findViewById(R.id.progressWheel)
        textViewError = findViewById(R.id.textView_error)
    }

    private fun requestAppUpdateIfAvailable() {
        val appUpdateManager = AppUpdateManagerFactory.create(baseContext)

        // Returns an intent object that you use to check for an update.
        val appUpdateInfoTask = appUpdateManager.appUpdateInfo

        // Checks that the platform will allow the specified type of update.
        appUpdateInfoTask.addOnCompleteListener { task: Task<AppUpdateInfo> ->
            if (task.isComplete) {
                if (task.isSuccessful && task.result != null) {
                    val appUpdateInfo: AppUpdateInfo = task.result

                    if (appUpdateInfo.updateAvailability() == UpdateAvailability.DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS) {
                        // If an in-app update is already running, resume the update.
                        appUpdateManager.startUpdateFlowForResult(
                            appUpdateInfo,
                            AppUpdateType.IMMEDIATE,
                            this,
                            Constants.APP_UPDATE_REQUEST_CODE
                        )
                    } else if (appUpdateInfo.updateAvailability() == UpdateAvailability.UPDATE_AVAILABLE
                        && appUpdateInfo.isUpdateTypeAllowed(AppUpdateType.IMMEDIATE)) {
                        appUpdateManager.startUpdateFlowForResult(
                            appUpdateInfo,
                            AppUpdateType.IMMEDIATE,
                            this,
                            Constants.APP_UPDATE_REQUEST_CODE
                        )
                    } else {
                        ActivityStarters.startWebViewActivity(
                            context = this,
                            finishGivenActivity = true,
                            clearTask = true,
                        )
                    }
                } else {
                    val exception: Exception? = task.exception
                    MyLogger.e(
                        "App update task is not successful. exception?.message = ${exception?.message}",
                        exception
                    )

                    if (exception != null) {
                        if (exception::class.simpleName == InstallException::class.simpleName) {
                            ActivityStarters.startWebViewActivity(
                                context = this,
                                finishGivenActivity = true,
                                clearTask = true,
                            )
                        }
                    }

                    showError(R.string.error_general)
                }
            }
        }
    }

    private fun showError(@StringRes errorRes:Int) {
        progressWheel?.visibility = View.GONE
        textViewError?.text = getString(errorRes)
    }
}