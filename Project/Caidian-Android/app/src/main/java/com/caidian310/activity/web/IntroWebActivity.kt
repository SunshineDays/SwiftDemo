package com.caidian310.activity.web

import android.os.Bundle
import com.caidian310.R
import com.caidian310.activity.base.BaseWebViewActivity
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ToastUtil
import kotlinx.android.synthetic.main.activity_web.*

class IntroWebActivity : BaseWebViewActivity() {

    private var lotteryId: Int = LotteryIdEnum.jczq.id



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web)

        toastLoading = ToastUtil.toastLoading(context = this)

        setBridgeWebView(web_activity_web)
        initEvent()
    }

    override fun initEvent() {
        super.initEvent()

        lotteryId = intent.getIntExtra("lotteryId", LotteryIdEnum.jczq.id)
        val title = intent.getStringExtra("title")
        initActionBar(centerTitle = title)

        requestIntro()
    }

    /**
     * 协议请求
     */
    private fun requestIntro() {
        toastLoading?.show()
        UserPresenter.requestIntro(
                context = this,
                lotteryId = lotteryId,
                onSuccess = {
                    toastLoading?.cancel()
                    println("------"+it)
                    web_activity_web.loadData(getIntroMessage(it), "text/html", "utf-8")

                },
                onFailure = {
                    toastLoading?.cancel()
                }
        )

    }


    /**
     * 协议头部拼接
     *
     */
    fun  getIntroMessage(introString :String) :String =
            """
                     <!doctype html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>玩法介绍</title>
                <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1" name="viewport">
            </head>
            <body>
            $introString
            </body>
            </html>
            """.trimIndent()
}
