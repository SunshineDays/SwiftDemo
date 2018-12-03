package com.caidian310.activity.user

import android.os.Bundle
import android.text.Html
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.presenter.AgreementStringPresenter
import kotlinx.android.synthetic.main.user_activity_user_agreement.*


class UserAgreementActivity : BaseActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.user_activity_user_agreement)

        val title = intent.getStringExtra("title")
        initActionBar(centerTitle = title ?: "协议")

        val lotteryId = intent.getIntExtra("lotteryId",0)
        agreement_txt.text =when(lotteryId){
            LotteryIdEnum.jczq.id -> AgreementStringPresenter.mJczqdescribe
            LotteryIdEnum.jclq.id -> AgreementStringPresenter.mJclqdescribe
            else -> AgreementStringPresenter.userAgreementString
        }

    }
}
