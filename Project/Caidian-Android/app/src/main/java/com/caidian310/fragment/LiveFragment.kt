package com.caidian310.fragment


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import com.caidian310.R
import com.caidian310.activity.base.BaseWebViewActivity
import com.caidian310.fragment.base.BaseWebViewFragment
import com.caidian310.http.Router
import com.github.lzyzsd.jsbridge.BridgeWebViewClient
import kotlinx.android.synthetic.main.fragment_live.*

class LiveFragment : BaseWebViewFragment() {


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_live, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        BaseWebViewActivity().setBridgeWebView(bridgeWebView = live_web_view)


        live_web_view_refresh.isRefreshing = true
        live_web_view_refresh.setColorSchemeResources(R.color.colorPrimary)


        live_web_view.loadUrl(Router.liveUrl)


        live_no_data.setOnClickListener {
            live_no_data.visibility = View.GONE
            live_web_view.loadUrl(Router.liveUrl)
        }


        live_web_view.webViewClient = object : BridgeWebViewClient(live_web_view) {

            override fun onPageFinished(view: WebView?, url: String?) {
                live_web_view_refresh.isRefreshing = false
                live_web_view_refresh.isEnabled = false
                super.onPageFinished(view, url)
            }

        }

    }


}
