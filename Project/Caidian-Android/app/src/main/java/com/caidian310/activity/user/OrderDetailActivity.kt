package com.caidian310.activity.user

import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.user.OrderJclqDetailAdapter
import com.caidian310.bean.IssueBean
import com.caidian310.bean.buy.PayDetailBean
import com.caidian310.bean.buy.PayMatch
import com.caidian310.bean.enumBean.*
import com.caidian310.dapter.user.OrderJczqDetailAdapter
import com.caidian310.presenter.LotteryPresenter
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.TimeUtil
import kotlinx.android.synthetic.main.activity_user_pay_record.*

class OrderDetailActivity : BaseActivity() {
    private var payMatchInfoList: ArrayList<PayMatch> = ArrayList()

    private var adapter: OrderJczqDetailAdapter? = null
    private var jclqAdapter: OrderJclqDetailAdapter? = null
    private var footView: View? = null
    private var footSeriesLinear: LinearLayout? = null
    private var footSeriesNumber: TextView? = null
    private var footSeriesTime: TextView? = null
    private var footPersonLinear: LinearLayout? = null
    private var footPerson: TextView? = null
    private var footSecretLinear: LinearLayout? = null
    private var footSecret: TextView? = null

    private var headerView: View? = null
    private var headerMultiple: TextView? = null                   //倍数
    private var headerMoney: TextView? = null                      //方案金额
    private var headerBonus: TextView? = null                      //税后奖金
    private var headerStatueImg: ImageView? = null                 //税后奖金
    private var headerWinImg: ImageView? = null                    //税后奖金
    private var headerLotteryImg: ImageView? = null                //彩种图标
    private var headerLotteryName: TextView? = null                //彩种名称
    private var headerLotteryIssue: TextView? = null               //彩种期号

    private var payDetailBean: PayDetailBean? = null


    private var resourceId = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_pay_record)
        initActionBar(centerTitle = "购买详情")
        initView()

        initEvent()
    }

    override fun initView() {
        super.initView()

        footView = LayoutInflater.from(this).inflate(R.layout.item_pay_record_foot, null)
        footSeriesLinear = footView!!.findViewById(R.id.pay_record_foot_series)
        footSeriesNumber = footView!!.findViewById(R.id.pay_record_foot_bet_number)
        footSeriesTime = footView!!.findViewById(R.id.pay_record_foot_bet_time)
        footPersonLinear = footView!!.findViewById(R.id.pay_record_foot_order_person_linear)
        footSecretLinear = footView!!.findViewById(R.id.pay_record_foot_order_secret_linear)
        footPerson = footView!!.findViewById(R.id.pay_record_foot_order_person)
        footSecret = footView!!.findViewById(R.id.pay_record_foot_order_secret)
        footSeriesTime = footView!!.findViewById(R.id.pay_record_foot_bet_time)

        headerView = LayoutInflater.from(this).inflate(R.layout.item_pay_record_header, null)
        headerMultiple = headerView!!.findViewById(R.id.pay_record_header_multiple)
        headerMoney = headerView!!.findViewById(R.id.pay_record_header_money)
        headerMoney = headerView!!.findViewById(R.id.pay_record_header_money)
        headerBonus = headerView!!.findViewById(R.id.pay_record_header_bonus)
        headerStatueImg = headerView!!.findViewById(R.id.pay_record_header_statue)
        headerWinImg = headerView!!.findViewById(R.id.pay_record_header_win)
        headerLotteryImg = headerView!!.findViewById(R.id.pay_record_lottery_img)
        headerLotteryName = headerView!!.findViewById(R.id.pay_record_name)
        headerLotteryIssue = headerView!!.findViewById(R.id.pay_record_issue)
    }

    override fun initEvent() {
        super.initEvent()

        resourceId = intent.getIntExtra("id", 0)

        pay_record_list_view.addFooterView(footView)
        pay_record_list_view.addHeaderView(headerView)

        requestOrderDetailList()
    }

    private fun requestOrderDetailList() {
        UserPresenter.requestOrderDetailList(context = this,
                orderBuyId = resourceId,
                onSuccess = {
                    pay_record_loading.visibility = View.GONE

                    payDetailBean = it
                    showFromLotteryId(lotteryId = it.code.lotteryId, payDetailBean = it)
                    setHeaderAndFootViewString(bean = it)
                    setOpenCodeLinear(bean = it)
                    isSecret()
                },
                onFailure = {
                    pay_record_loading.visibility = View.GONE
                })

    }


    /**
     * 根据彩种  显示不同的页面
     * @param lotteryId 彩种
     * @param payDetailBean 订单详情
     */

    private fun showFromLotteryId(lotteryId: Int, payDetailBean: PayDetailBean) {

        //重新获取地址值不一样的数据值 防止数据重复修改
        payMatchInfoList.add(payDetailBean.code.matchList.first())
        payMatchInfoList.addAll(payDetailBean.code.matchList)
        when (lotteryId) {
            LotteryIdEnum.jclq.id -> {
                jclqAdapter = OrderJclqDetailAdapter(context = this, payList = payMatchInfoList)
                pay_record_list_view.adapter = jclqAdapter
                jclqAdapter?.notifyDataSetChanged()
            }
            else -> {
                adapter = OrderJczqDetailAdapter(context = this, payList = payMatchInfoList)
                pay_record_list_view.adapter = adapter
                adapter?.notifyDataSetChanged()
            }
        }


    }

    /**
     * footView  headerView  文字显示
     */

    private fun setHeaderAndFootViewString(bean: PayDetailBean) {


        //彩种 -玩法
        val centerTitle: String = LotteryIdEnum.jczq.getLotteryEnumFromId(bean.order.lotteryId).lotteryName +
                if (bean.order.playId != 0) "-" + PlayIdEnum.hunhe.getPlayEnumFromId(bean.order.playId).playName else ""
        footSeriesTime?.text = TimeUtil.getFormatTime(bean.code.createTime)
        footSeriesNumber?.text = bean.order.orderNum

        headerMultiple?.text = bean.code.multiple.toString()
        headerMoney?.text = bean.code.totalMoney.toString()
        headerLotteryImg?.setImageResource(LotteryPresenter.getLotteryLogoFromId(bean.code.lotteryId))        //图标
        headerLotteryName?.text = centerTitle                                                                 //彩种
        headerLotteryIssue?.visibility = View.INVISIBLE

        // 如果接口数据为0.0的全部显示 -  (已中奖状态下接口数据为0.0时  显示0.0)
        headerBonus?.text = if (bean.order.bonus == 0.00) "-" else bean.order.bonus.toString()

        headerStatueImg?.setImageResource(when (bean.order.winStatus) {
            WinStatueEnum.NoStart.id -> {                   //暂未开奖 查找其他的状态
                when (bean.order.ticketStatus) {
                    TicketStatueEnum.NoTicket.id -> R.mipmap.icon_statue_1            //未出票
                    TicketStatueEnum.Ticketing.id -> R.mipmap.icon_statue_2           //出票中
                    TicketStatueEnum.TicketSuccess.id -> R.mipmap.icon_statue_3       //出票成功
                    else -> R.mipmap.icon_statue_0                                    //出票失败
                }
            }

            WinStatueEnum.Lost.id -> R.mipmap.icon_statue_4_lost                            //未中奖
            else -> {                                                           //中奖
                headerWinImg?.visibility = View.VISIBLE
                R.mipmap.icon_statue_4_win
            }
        }

        )

    }

    /**
     * 竞彩足球和竞彩篮球 ->动态添加串关
     */
    private fun setSeriesTextView(series: ArrayList<String>) {
        val oneLinearLayout = LinearLayout(this)
        series.forEachIndexed { _, s ->
            val textView = TextView(this)
            textView.text = if (s.contains("1串1")) "单关" else s
            textView.textSize = 10f
            textView.width = 120
            textView.height = 54
            textView.gravity = Gravity.CENTER
            val linearParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT)

            linearParams.setMargins(0, 10, 10, 10)
            textView.layoutParams = linearParams
            textView.setBackgroundResource(R.drawable.angle_round_logo)
            oneLinearLayout.addView(textView)
        }

        footSeriesLinear?.addView(oneLinearLayout)
    }


    /**
     * 添加串关方式或者添加开奖号码
     */

    private fun setOpenCodeLinear(bean: PayDetailBean) {


        val lotteryId = bean.issue.lotteryId

        //是否不要添加串关方式
        val isFootBallOrBasketball = lotteryId == LotteryIdEnum.jczq.id || lotteryId == LotteryIdEnum.jclq.id

        if (isFootBallOrBasketball) {
            if (bean.code.serialList.isNotEmpty()) setSeriesTextView(series = bean.code.serialList)
            return
        }

        /**
         * 动态添加 title
         */
        val textViewTitle = TextView(this)
        textViewTitle.run {
            textSize = 14f
            setTextColor(ColorUtil.getColor(R.color.grayThree))
            text = "开奖号码"
        }

        //如果未开奖
        if (bean.issue.openCode.isEmpty()) return
        footSeriesLinear?.addView(textViewTitle)

        setOpenCodeTextView(bean.issue)


        /**
         * 下分割线
         */

        val footLine = TextView(this)
        footLine.run {
            setBackgroundColor(ColorUtil.getColor(R.color.grayLow))
            height = 2
        }
        footSeriesLinear?.addView(footLine)


    }


    /**
     * 动态添加开奖号码
     */
    private fun setOpenCodeTextView(issue: IssueBean) {

        val oneLinearLayout = LinearLayout(this)
        val blueIndex = issue.openCode.split("-")
                .first().split(" ").size ?: 5
        val str = issue.openCode.replace("-", " ").split(" ")

        str.forEachIndexed { index, s ->
            oneLinearLayout.addView(createOpenCode(s, index >= blueIndex))
        }

        footSeriesLinear?.addView(oneLinearLayout)

    }


    /**
     * 创建一个开奖号码显示的textView
     * @param isBlueBoolean 是否是篮球
     */

    private fun createOpenCode(content: String, isBlueBoolean: Boolean = false): TextView {
        val textView = TextView(this)
        textView.run {
            text = content
            textSize = 14f
            width = 80
            height = 80
            gravity = Gravity.CENTER
            setTextColor(ColorUtil.getColor(R.color.white))
        }
        val linearParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT)
        linearParams.setMargins(0, 10, 10, 20)
        textView.layoutParams = linearParams
        textView.setBackgroundResource(if (isBlueBoolean) R.drawable.round_all_blue else R.drawable.round_all_red)
        return textView

    }


    /**
     * 是否公开
     */
    private fun isSecret() {

        payDetailBean?.run {

            if (parent == null) return@run

            /**
             * 自己发单自己可见
             */
            if (parent.userId == DbUtil().getUserBean().id){
                return@run
            }

            /**
             * 本单不是发单或者跟单 -> 可见
             */
            if (!arrayListOf(OrderTypeEnum.Order.id,OrderTypeEnum.CopyOrder.id).contains(OrderTypeEnum.Order.getOrderEnumFormId(parent.orderType).id)) {
                return@run
            }

            /**
             * 本单是否可见 0 可以 1不可以
             */
            if (parent.isSecret == 0) {
                return@run
            }


            /**
             * 是否全部开赛
             */
            val maxTimeMatch = code.matchList.maxBy { it.match.matchTime }
            val isStartMatchBoolean = maxTimeMatch!!.match.matchTime * 1000 < System.currentTimeMillis()

            footSecretLinear?.visibility = View.VISIBLE
            footPersonLinear?.visibility = View.VISIBLE

            footSecret?.text = "截止后公开"
            footPerson?.text = parent.nickName

            /**
             * 可全部开赛 || 设置可见
             */
            if (isStartMatchBoolean) {
                return@run
            }

            payMatchInfoList.clear()
            adapter?.notifyDataSetChanged()


        }

    }

}

