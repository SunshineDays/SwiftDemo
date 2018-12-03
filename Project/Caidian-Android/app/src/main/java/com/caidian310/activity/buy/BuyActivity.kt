package com.caidian310.activity.buy

import android.content.Intent
import android.os.Bundle
import android.text.Html
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.user.RechargeActivity
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.sport.football.BetMatch
import com.caidian310.bean.user.AccountDetailBean
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.presenter.user.UserPresenter
import kotlinx.android.synthetic.main.activity_user_buy.*
import org.greenrobot.eventbus.EventBus

class BuyActivity : BaseActivity() {

    private var buyBean: BuyBean? = null
    private var leagueNameList: ArrayList<BetMatch> = ArrayList()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_buy)

        initActionBar(centerTitle = "确认提交")
        registerEventBus()
        initView()
        initListener()
        requestAccountDetail()

    }

    override fun initView() {
        super.initView()
        buyBean = intent.getSerializableExtra("buyBean") as BuyBean

        println("----310 = "+buyBean)
        //竞彩足球  || icon_types_jclq
        leagueNameList = intent.getSerializableExtra("leagueNameList") as ArrayList<BetMatch>
        pay_lottery.text =
                LotteryIdEnum.jczq.getLotteryEnumFromId(buyBean!!.lottery_id).lotteryName +
                " - " +
                PlayIdEnum.jqs.getPlayEnumFromId(buyBean!!.play_id).playName

        pay_send_order.visibility = if (buyBean!!.lottery_id==LotteryIdEnum.jczq.id) View.VISIBLE else View.GONE


        pay_money.text = Html.fromHtml("<font color='#FF0000'>${FormatPresenter.getBigDecimalString(buyBean?.total_money
                ?: 0.0)}</font>元")
        pay_type.text = "方案${FormatPresenter.getBigDecimalString(buyBean?.total_money
                ?: 0.0)}元  优惠￥0"
        pay_type_money.text = Html.fromHtml("待支付 : <font color='#FF0000'>${FormatPresenter.getBigDecimalString(buyBean?.total_money
                ?: 0.0)}</font>元")
        pay_integral.text = Html.fromHtml("奖励 : <font color='#FF0000'>0</font>点")


    }


    override fun initListener() {
        super.initListener()

        pay_recharge.setOnClickListener {

            showProgress()
            pay_recharge.isClickable = false
            if (pay_recharge.text.toString() == "提交彩店") {                  // 提交支付请求
                requestPay()
                return@setOnClickListener
            }
            startActivity(Intent(this, RechargeActivity::class.java))
            hintProgress()
            pay_recharge.isClickable = true

        }

        pay_send_order.setOnClickListener {

            val intent = Intent(this, SendOrderActivity::class.java)
            intent.putExtra("leagueNameList", leagueNameList)
            intent.putExtra("buyBean", buyBean)
            startActivity(intent)
        }
    }


    /**
     * 用户详细信息
     */
    private fun requestAccountDetail() {
        UserPresenter.requestUserDetail(context = this,
                onSuccess = {
                    initAccountView(detailBean = it)
                },
                onFailure = {}
        )
    }


    /**
     * 显示账户信息
     */

    private fun initAccountView(detailBean: AccountDetailBean) {
        pay_integral.text = Html.fromHtml("<font color='#FF0000'>${FormatPresenter.getBigDecimalString(detailBean.reward)}</font>元")
        val number = detailBean.balance + detailBean.reward - buyBean!!.total_money

        //余额充足
        pay_user_no_enough.visibility = if (number >= 0) View.GONE else View.VISIBLE


        pay_user_integral.text = "-点"
        pay_user_money.text = Html.fromHtml("<font color='#FF0000'>${FormatPresenter.getBigDecimalString(detailBean.balance + detailBean.reward)}</font>元")


        val noEnoughMoney = FormatPresenter.getBigDecimalString(Math.abs(number))
        pay_user_no_enough_money.text = Html.fromHtml("<font color='#FF0000'>${FormatPresenter.doubleToString(noEnoughMoney.toDouble())}</font>元")

        // 如果金额不足不显示发单
        pay_recharge.text = if (number >= 0) "提交彩店" else "去充值"


    }


    /**
     * 支付成功  关掉该页面
     */
    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)
        if (event.loginMessage == "paySuccess") finish()
    }



    /**
     * 支付网络请求
     */

    private fun requestPay() {
        pay_recharge.isClickable = false
        FootBallPresenter.requestFootBallBuyBean(
                context = this,
                buyBean = buyBean!!,
                onSuccess = {
                    showToast("购买成功")
                    EventBus.getDefault().post(EventBusBean("paySuccess"))
                    EventBus.getDefault().post(EventBusBean("refresh"))
                    val intent = Intent(this, BuySuccessActivity::class.java)
                    intent.putExtra("PaySuccessDetailBean", it)
                    this.startActivity(intent)
                    finish()
                    pay_recharge.isClickable = true
                    hintProgress()
                },
                onFailure = {
                    pay_recharge.isClickable = true
                    hintProgress()
                }
        )
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterEventBus()
    }

    /**
     * 加载中
     * 注 : 不能用pop  低版本手机显示可能卡顿
     *
     */
    fun showProgress(){
        pay_progress.visibility = View.VISIBLE
        pay_root.visibility = View.GONE
    }

    fun hintProgress(){
        pay_progress.visibility = View.GONE
        pay_root.visibility = View.VISIBLE
    }


}
