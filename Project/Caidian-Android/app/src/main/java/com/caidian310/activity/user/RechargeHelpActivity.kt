package com.caidian310.activity.user

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity

class RechargeHelpActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_recharge_help)
        initActionBar(centerTitle = "充值帮助")
    }
}
