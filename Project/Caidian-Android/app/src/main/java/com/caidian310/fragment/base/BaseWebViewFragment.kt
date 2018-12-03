package com.caidian310.fragment.base

import android.graphics.Bitmap
import android.webkit.WebView
import com.caidian310.activity.base.BaseWebViewActivity
import com.caidian310.view.popupWindow.LoadingPopupWindow
import com.github.lzyzsd.jsbridge.BridgeWebView
import com.github.lzyzsd.jsbridge.BridgeWebViewClient

open class BaseWebViewFragment: BaseFragment() {

    val loading :LoadingPopupWindow ?=null

    fun initWebView(bridgeWebView: BridgeWebView) {


    }
}