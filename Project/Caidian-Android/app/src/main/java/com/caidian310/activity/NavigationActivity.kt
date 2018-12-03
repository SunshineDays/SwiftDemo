package com.caidian310.activity

import android.content.Intent
import android.os.Bundle
import com.caidian310.activity.base.BaseActivity
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.AppVersion


class NavigationActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        updateCheck()

    }

    private fun updateCheck() {
        val intent = Intent(baseContext, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT


        UserPresenter.requestUpdateCheckData(

                context = this,
                onSuccess = {
                    if (it.build > AppVersion.versionCode) {
                        intent.putExtra("message", it.message)
                        intent.putExtra("version", it.version)
                        intent.putExtra("downLoadUrl", it.downLoadUrl)
                    }
                    startActivity(intent)
                    finish()
                },
                onFailure = {
                    startActivity(intent)
                    finish()

                })
    }


}
