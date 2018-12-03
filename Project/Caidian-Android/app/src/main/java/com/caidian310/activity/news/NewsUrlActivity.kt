package com.caidian310.activity.news

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.webkit.WebView
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.github.lzyzsd.jsbridge.BridgeWebViewClient
import kotlinx.android.synthetic.main.activity_new_url.*

class NewsUrlActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_new_url)
        initActionBar(leftTitle = "返回",centerTitle = "")
        initEvent()
    }

    override fun initEvent() {
        super.initEvent()
        val url = intent.getStringExtra("url")
        base_web_view.loadUrl(url)
        base_web_view.webViewClient = object : BridgeWebViewClient(base_web_view){
            override fun onPageFinished(view: WebView?, url: String?) {
                initActionBar(leftTitle = "返回",centerTitle = view?.title ?: "")
                super.onPageFinished(view, url)
                base_web_view.visibility= View.VISIBLE
                base_web_view_progress_bar.visibility = View.GONE
            }

        }
    }
}
