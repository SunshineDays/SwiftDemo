package com.caidian310.activity.news

import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import com.caidian310.R
import com.caidian310.activity.base.BaseWebViewActivity
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.HtmlStringUtil
import kotlinx.android.synthetic.main.activity_user_news_detail.*

class NewsDetailActivity : BaseWebViewActivity() {

    private var id = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_news_detail)

        initActionBar(centerTitle = "资讯")

        id = intent.getIntExtra("newId", 0)
        setBridgeWebView(bridgeWebView = news_detail_web_view)
        requestNewsDetail()

    }

    /**
     */

    private fun webViewClient() {

        //设置本地调用对象及其接口
        news_detail_web_view!!.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView?, url: String?) {

                news_detail_refresh.isRefreshing = false
                news_detail_refresh.isEnabled = false
                super.onPageFinished(view, url)
            }
        }

    }


    private fun requestNewsDetail() {
        news_detail_refresh.isRefreshing = true
        UserPresenter.requestNewsDetail(
                context = this,
                id = id,
                onSuccess = {
                    /**
                     * 将网络请求的数据回调到Js
                     */
                    news_detail_web_view.loadDataWithBaseURL("file:///android_asset/", HtmlStringUtil.spliceImageHtml(newsItem = it), "text/html", "UTF-8", null)
                    webViewClient()
                },
                onFailure = {
                    news_detail_refresh.isRefreshing= false
                    news_detail_refresh.isEnabled= false
                }
        )
    }

}
