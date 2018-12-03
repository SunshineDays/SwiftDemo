package com.caidian310.activity.buy

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.user.BuyListActivity
import com.caidian310.bean.buy.PaySuccessDetailBean
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum


import kotlinx.android.synthetic.main.activity_user_buy_success.*

/**
 *
 * 购买成功页面
 * 本页面不对数据做任何修改处理 仅限于展示
 *
 */

class BuySuccessActivity : BaseActivity() {

    private var lotteryId = LotteryIdEnum.jczq.id
    private var isChaseBoolean = false            //是否是追号
    private var orderTypeId :String ?=null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_buy_success)
        initActionBar(centerTitle = "购买成功")
        initEvent()
        initListener()
    }

    override fun initEvent() {
        super.initEvent()

        val paySuccessDetailBean = intent.getSerializableExtra("PaySuccessDetailBean") as PaySuccessDetailBean
        orderTypeId = intent.getStringExtra("orderTypeId") ?:null
        lotteryId = if (paySuccessDetailBean.order != null) paySuccessDetailBean.order.lotteryId else paySuccessDetailBean.chase.lotteryId

        showLotteryType(paySuccessDetailBean)
        pay_success_money.text = "${paySuccessDetailBean.account.balance}元"
        pay_success_reward.text = "${paySuccessDetailBean.account.reward}元"
        pay_success_integral.text = "${0}点"
        pay_success_order_number.text = if (paySuccessDetailBean.order != null) paySuccessDetailBean.order.orderNum else "-"
    }

    /**
     * 设置彩种显示
     * 大乐透 双色球 七乐彩等没有playId if(playId ==0)  彩种-期号 else 彩种 - 玩法
     * @param paySuccessDetailBean 订单购买成功回执详情
     * paySuccessDetailBean  :
     *
     */


    @SuppressLint("SetTextI18n")
    private fun showLotteryType(paySuccessDetailBean: PaySuccessDetailBean) {

        val lotteryString = (LotteryIdEnum.jczq.getLotteryEnumFromId(lotteryId)).lotteryName
        isChaseBoolean = paySuccessDetailBean.chase != null

        val playString = if (isChaseBoolean) "追号"
        else if (paySuccessDetailBean.order.playId == 0 &&paySuccessDetailBean.order.issue.isNotEmpty()) paySuccessDetailBean.order.issue+"期"
        else PlayIdEnum.jqs.getPlayEnumFromId(paySuccessDetailBean.order.playId).playName

        pay_success_pay_log.text = if (isChaseBoolean) "追号记录" else "投注记录"
        pay_success_lottery.text = "$lotteryString-$playString"                         //彩种显示

    }

    override fun initListener() {
        super.initListener()
        //继续购买
        pay_success_continue.setOnClickListener { finish() }

        //购彩记录
        pay_success_pay_log.setOnClickListener {
            //购买记录
            val intent = Intent(this, BuyListActivity::class.java)
            intent.putExtra("orderTypeId",orderTypeId)
            startActivity(intent)

            finish()
        }
    }
}
