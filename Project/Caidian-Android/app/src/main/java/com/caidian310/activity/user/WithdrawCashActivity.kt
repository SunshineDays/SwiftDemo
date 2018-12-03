package com.caidian310.activity.user

import android.content.Intent
import android.os.Bundle
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.presenter.TextPresenter
import com.caidian310.presenter.user.UserPresenter
import kotlinx.android.synthetic.main.activity_user_withdraw_cash.*


class WithdrawCashActivity : BaseActivity() {


    private var message= """1、提款不收取收费,为防止恶意提现,媒体提款次数最多为3次(提款处理中与提款成功次数的总和)
2、为防止套现和洗钱,每次充值后需消费充值金额的30%后才能提现.
3、仅支持借记卡体现,不支持具有透支功能的信用卡,准贷记卡提现.
4、用户提款最快10分钟到账,若1个工作日还未到账,请您及时到网站联系客服.
    """.trimIndent()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_withdraw_cash)
        initActionBar(centerTitle = "提现",rightTitle = "提现记录")
        initListener()
        withdraw_tip.text = message
    }

    override fun initListener() {
        super.initListener()



        /**
         * 提现记录
         */
        rightTxt?.setOnClickListener { startActivity(Intent(this,WithdrawListActivity::class.java)) }

        /**
         * 申请
         */
        withdraw_commit.setOnClickListener { requestWithdraw() }

        /**
         * 提现金额输入限制
         */
        withdraw_money.addTextChangedListener(TextPresenter.setEditViewDecimalNumber(number = 2,editText = withdraw_money))
    }


    private fun requestWithdraw() {

        if (withdraw_money.text.isNullOrEmpty()) {
            showToast("提现金额不能为空")
            return
        }


        if (withdraw_money.text.toString().toDouble() == 0.0) {
            showToast("提现金额不能为0")
            return
        }

        if (withdraw_money.text.toString().toInt() <10) {
            showToast("提现金额不能小于10元")
            return
        }



        UserPresenter.requestApplyWithdraw(
                context = this,
                money = withdraw_money.text.toString(),
                onSuccess = {
                    showToast("申请成功")
                    finish()
                },
                onFailure = {

                })
    }


}
