package com.caidian310.activity.base

import android.os.Bundle
import com.caidian310.utils.ActionBarStyleUtil

class BaseWhiteActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        hintActionBar()
        ActionBarStyleUtil.whiteActionBar(window)
    }
}
