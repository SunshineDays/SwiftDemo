package com.caidian310.activity.base

import android.os.Build
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView

open class BaseWebViewActivity : BaseActivity() {



    fun setBridgeWebView(bridgeWebView: WebView) {
        bridgeWebView.webChromeClient = WebChromeClient()       //alert()
        val setting = bridgeWebView.settings
        setting.javaScriptCanOpenWindowsAutomatically = true    //允许js弹出窗口
        setting.javaScriptEnabled = true                        //支持 Javascript
        setting.allowFileAccess = true                          // 允许访问文件
        setting.loadWithOverviewMode = true                     // 缩放至屏幕的大小
        setting.setSupportZoom(true)
        setting.setAppCacheEnabled(true)
        setting.pluginState = WebSettings.PluginState.ON
        setting.defaultTextEncodingName = "UTF-8"               //编码方式
        setting.builtInZoomControls = true                      //设置支持缩放
        // 解决android5.0以上 webView默认不能混合访问http和https的问题
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            setting.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
    }
}
