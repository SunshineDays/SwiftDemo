package com.caidian310.activity.buy

import android.content.Intent
import android.os.Bundle
import android.text.Html
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.sport.football.BetMatch
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.ColorUtil
import kotlinx.android.synthetic.main.activity_buy_send_order.*

import org.greenrobot.eventbus.EventBus

class SendOrderActivity : BaseActivity() {


    private var buyBean: BuyBean? = null
    private val copyWinString = "允许他人复制(中奖后可以获得复制方案奖金一定比例的佣金)"
    private val copyString = "允许他人复制方案(方案公开无复制佣金)"
    private  var isSecret : Int = 1  //保密设置Order_type ==3 时 0: 公开无佣金 ,1:截止后公开无佣金

    private var leagueNameList :ArrayList<BetMatch> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_buy_send_order)

        initActionBar(centerTitle = "赚提成")

        initEvent()
        initListener()
    }

    override fun initEvent() {
        super.initEvent()

        buyBean = intent.getSerializableExtra("buyBean") as BuyBean
        leagueNameList = intent.getSerializableExtra("leagueNameList") as ArrayList<BetMatch>
        send_order_total_money.text = Html.fromHtml("<font color='#FF0000'>${buyBean?.total_money} </font>元")
        send_order_multiple.text = Html.fromHtml("<font color='#FF0000'>${buyBean!!.total_money/buyBean!!.multiple} </font>元")      //单倍金额
        send_order_reason.hint = LotteryIdEnum.jczq.getLotteryEnumFromId(buyBean!!.lottery_id).lotteryName +"精选方案"
        setLeagueName()

    }

    override fun initListener() {
        super.initListener()
        send_order_public.setOnClickListener {
            isSecret = 0
            send_order_copy_message.text = copyString
            send_order_public.run {

                setBackgroundResource(0)
                setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))
            }
            send_order_win_public.run {
                setBackgroundResource(R.drawable.angle_round_right_top_gray_6)
                setTextColor(ColorUtil.getColor(R.color.graySix))
            }

        }
        send_order_win_public.setOnClickListener {
            isSecret = 1
            send_order_copy_message.text = copyWinString
            send_order_win_public.run {
                setBackgroundResource(0)
                setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))
            }
            send_order_public.run {
                setBackgroundResource(R.drawable.angle_round_left_top_gray_6)
                setTextColor(ColorUtil.getColor(R.color.graySix))
            }

        }

        send_order_commit.setOnClickListener {
            requestPay()
        }

//        send_order_copy_img.setOnClickListener {
//            send_order_copy_img.run {
//                if (tag == null){
//                    tag = ""
//                    setImageResource(R.mipmap.icon_check_select)
//                }else{
//                    tag = null
//                    setImageResource(R.mipmap.icon_check_normal)
//                }
//            }
//
//        }
    }


    /**
     * 设置联赛名显示规则
     */
    private fun setLeagueName() {
        var content = ""
        leagueNameList.forEachIndexed { index, betMatch ->

            content += "<font color='${betMatch.color}'>${betMatch.name}</font>"
            if (index!=leagueNameList.size-1){content+=" , &nbsp"}
        }

        send_order_match.text = Html.fromHtml(content)

    }


    /**
     * 支付网络请求
     */

    private fun  requestPay(){
        send_order_commit.isClickable= false
        buyBean?.order_type = OrderTypeEnum.Order.id
        buyBean?.is_secret = isSecret
        buyBean?.reason = send_order_reason.text.toString()
        FootBallPresenter.requestFootBallBuyBean(
                context = this,
                buyBean = buyBean!!,
                onSuccess = {
                    EventBus.getDefault().post(EventBusBean("paySuccess"))
                    val intent= Intent(this, BuySuccessActivity::class.java)
                    intent.putExtra("PaySuccessDetailBean",it)
                    intent.putExtra("orderTypeId",OrderTypeEnum.Order.id.toString())
                    this.startActivity(intent)
                    finish()
                    send_order_commit.isClickable= true
                },
                onFailure = {
                    send_order_commit.isClickable= true
                }
        )
    }


}
