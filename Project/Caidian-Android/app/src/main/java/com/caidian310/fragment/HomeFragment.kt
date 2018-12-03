package com.caidian310.fragment


import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.text.Html
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.news.NewsDetailActivity
import com.caidian310.activity.sport.order.CopyOrderDetailActivity
import com.caidian310.bean.buy.Bet
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.buy.MatchInfo
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.new.NewsDetailBean
import com.caidian310.bean.sport.football.BetMatch
import com.caidian310.bean.sport.football.RequestFootballBean
import com.caidian310.bean.sport.order.CopyOrderBean
import com.caidian310.fragment.base.BaseFragment
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.presenter.order.OrderPresenter
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.custom.RoundImageView
import com.youth.banner.BannerConfig
import kotlinx.android.synthetic.main.fragment_home.*
import org.jetbrains.anko.textColor


/**
 * 首页
 * A simple [Fragment] subclass.
 */
class HomeFragment : BaseFragment() {

    private val bannerPictureList = ArrayList<String>()    //保存轮播图片

    private val page = 1
    private val pageSize = 20
    private var limit = 3                                         //图片轮播显示的个数 默认为3
    private var newsDetailBean: NewsDetailBean? = null

    private var todayHotOrderList: ArrayList<CopyOrderBean> = ArrayList()


    private var requestFootBallList: ArrayList<RequestFootballBean> = ArrayList()
    private var requestFootballBean: RequestFootballBean? = null
    private var isRqSpfBoolean: Boolean = false                          //默认显示非让球信息

    // 今日热单相关参数

    private var orderImg: RoundImageView? = null
    private var orderName: TextView? = null
    private var orderSelfBuy: TextView? = null        //自购
    private var orderFollowPerson: TextView? = null   //更单人数
    private var orderFollowCommit: TextView? = null   //立即跟单
    private var orderEndTime: TextView? = null        //截止时间
    private var orderRote: TextView? = null           //预计回报率
    private var orderHotImg: ImageView? = null        //今日热单
    private var orderWinNumber: TextView? = null      //命中率
    private var orderNumber: TextView? = null         //近n单




    private var winBoolean: Boolean = false
        set(value) {
            field = value
            home_home_linear.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_hot_home_name.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
            home_hot_bf_win.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
        }

    private var drawBoolean: Boolean = false
        set(value) {
            field = value
            home_hot_bf_draw.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_hot_bf_draw.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.grayThree)

        }

    private var lostBoolean: Boolean = false
        set(value) {
            field = value
            home_away_linear.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_hot_away_name.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
            home_hot_bf_lost.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)

        }

    private var twentyBoolean = false
        set(value) {
            field = value
            home_bet_20.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_bet_20.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
        }

    private var fiftyBoolean = false
        set(value) {
            field = value
            home_bet_50.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_bet_50.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
        }

    private var oneHundredBoolean = false
        set(value) {
            field = value
            home_bet_100.setBackgroundResource(if (value) R.drawable.angle_all_bian_red_radius_3 else R.drawable.angle_round_gray_radius_3)
            home_bet_100.textColor = ColorUtil.getColor(if (value) R.color.red else R.color.gray4D4D4D)
        }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_home, container, false)
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        initView()
        initEvent()

        initListener()

    }


    override fun initView() {
        super.initView()

        orderHotImg = home_today_hot_order.findViewById(R.id.item_copy_order_today_hot)
        orderHotImg?.visibility = View.VISIBLE

        orderImg = home_today_hot_order.findViewById(R.id.item_copy_order_header_img)
        orderRote = home_today_hot_order.findViewById(R.id.item_copy_order_rate)
        orderName = home_today_hot_order.findViewById(R.id.item_copy_order_name)
        orderEndTime = home_today_hot_order.findViewById(R.id.item_copy_order_end_time)
        orderSelfBuy = home_today_hot_order.findViewById(R.id.item_copy_order_buy_money)
        orderFollowPerson = home_today_hot_order.findViewById(R.id.item_copy_order_person)
        orderFollowCommit = home_today_hot_order.findViewById(R.id.item_copy_order_commit)
        orderWinNumber = home_today_hot_order.findViewById(R.id.item_copy_order_ten_order_two)
        orderNumber = home_today_hot_order.findViewById(R.id.item_copy_order_ten_order)


    }

    override fun initEvent() {
        super.initEvent()
        // 轮播控制器自适应屏幕大小(1/2)
        setBannerScreen()
        request()


    }


    /**
     * fragment 可见性判断
     */
    override fun onHiddenChanged(hidden: Boolean) {
        super.onHiddenChanged(hidden)
        if (!hidden) {
            request()
        }
    }


    /**
     * 网络请求
     */
    private fun request() {
        requestMain()
        requestHotOrderList()
        requestSingleMatchList()
    }


    override fun initListener() {
        super.initListener()
        /**
         * 初始化 轮播控件
         */

        fragment_home_banner.setOnBannerListener {
            if (newsDetailBean == null || newsDetailBean!!.topicList.size == 0) return@setOnBannerListener
            val intent = Intent(context, NewsDetailActivity::class.java)
            intent.putExtra("newId", newsDetailBean!!.topicList[it].id)
            startActivity(intent)
        }

        /**
         * 竞彩足球
         */
        home_lottery_jczq_linear.setOnClickListener {
            StartActivityPresenter.startActivityFromId(
                    context = activity!!,
                    lotteryId = LotteryIdEnum.jczq.id
            )
        }

        /**
         * icon_types_jclq
         */
        home_lottery_jclq_linear.setOnClickListener {
            StartActivityPresenter.startActivityFromId(
                    context = activity!!,
                    lotteryId = LotteryIdEnum.jclq.id
            )
        }


        /**
         *  发单详情
         *
         */
        home_today_hot_order?.setOnClickListener {
            if (todayHotOrderList.size == 0) return@setOnClickListener
            val intent = Intent(context, CopyOrderDetailActivity::class.java)
            intent.putExtra("orderId", todayHotOrderList.first()?.orderId)
            activity!!.startActivity(intent)

        }

        /**
         * 胜 || 让胜
         */
        home_home_linear.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            drawBoolean = false
            lostBoolean = false
            winBoolean = !winBoolean
        }

        /**
         * 平 || 让平
         */
        home_hot_bf_draw.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            winBoolean = false
            lostBoolean = false
            drawBoolean = !drawBoolean
        }

        /**
         * 负 || 让负
         */
        home_away_linear.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            lostBoolean = !lostBoolean
            winBoolean = false
            drawBoolean = false
        }

        /**
         * 20元
         */
        home_bet_20.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            twentyBoolean = !twentyBoolean
            fiftyBoolean = false
            oneHundredBoolean = false

        }

        /**
         * 50元
         */
        home_bet_50.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            fiftyBoolean = !fiftyBoolean
            twentyBoolean = false
            oneHundredBoolean = false

        }

        /**
         * 100元
         */
        home_bet_100.setOnClickListener {
            if (requestFootballBean == null) return@setOnClickListener
            oneHundredBoolean = !oneHundredBoolean
            twentyBoolean = false
            fiftyBoolean = false

        }


        /**
         * 立即投注
         */

        home_bet_commit.setOnClickListener {

            if (!winBoolean && !drawBoolean && !lostBoolean) {
                showToast("至少选择一种投注项")
                return@setOnClickListener
            }

            if (!twentyBoolean && !fiftyBoolean && !oneHundredBoolean) {
                showToast("至少选择一项金额")
                return@setOnClickListener
            }



            StartActivityPresenter.startBuyActivity(
                    context = activity!!,
                    buyBean = getBuyBean(),
                    leagueNameList =
                    arrayListOf(
                            BetMatch(
                                    name = requestFootballBean!!.leagueName,
                                    color = requestFootballBean!!.color)
                    )
            )


        }



    }


    /**
     * 获取购买的参数
    */

    private fun getBuyBean(): BuyBean {

        val bet = when {
            winBoolean -> Bet(bet_key = if (isRqSpfBoolean) "rqspf_sp3" else "spf_sp3", sp = if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp3 else requestFootballBean!!.spf_sp3)
            drawBoolean -> Bet(bet_key = if (isRqSpfBoolean) "rqspf_sp1" else "spf_sp1", sp = if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp1 else requestFootballBean!!.spf_sp1)
            else -> Bet(bet_key = if (isRqSpfBoolean) "rqspf_sp0" else "spf_sp0", sp = if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp0 else requestFootballBean!!.spf_sp0)
        }


        val matchInfo = MatchInfo(
                id = requestFootballBean!!.id,
                let_ball = requestFootballBean!!.letBall,
                is_must_bet = false,
                bet_list = arrayListOf(bet)
        )



        val totalMoney =  if (twentyBoolean) 20.0 else if (fiftyBoolean) 50.0 else if (oneHundredBoolean) 100.0 else 0.0

        return BuyBean(
                lottery_id = LotteryIdEnum.jczq.id,
                play_id = 7,
                bet_count = 1,
                total_money = totalMoney,
                order_type = OrderTypeEnum.Purchasing.id,
                multiple = (totalMoney / 2).toInt(),
                issue = requestFootballBean!!.issue,
                is_secret = 0,
                serial_list = arrayListOf("1串1"),
                match_list = arrayListOf(matchInfo))


    }


    //控件适配屏幕大小
    private fun setBannerScreen() {
        val dm = resources.displayMetrics
        val wScreen = dm.widthPixels
        val lp = LinearLayout.LayoutParams(wScreen, wScreen * 9 / 20)   //宽高
        fragment_home_banner.layoutParams = lp
    }


    /**
     * 网络请求
     */
    private fun requestMain() {

        UserPresenter.requestMain(
                context = context!!,
                onSuccess = {

                    newsDetailBean = it
                    showTopListAndNotice()

                },

                onFailure = {
                }
        )

    }

    /**
     * 竞彩单关赛事列表
     */

    private fun requestSingleMatchList() {
        UserPresenter.requestSingleMatchList(
                context = activity!!,
                onSuccess = {
                    requestFootBallList = it
                    showSingleMatch()
                },
                onFailure = {
                    home_no_single_match_linear.visibility = View.GONE
                    home_single_match_linear.visibility = View.GONE
                }
        )
    }


    /**
     * 今日热单 网络请求
     */
    private fun  requestHotOrderList(){
        OrderPresenter.requestHotOrderList(
                context = activity!!,
                page = page,
                pageSize = pageSize,
                onSuccess = {
                    hotOrderList, _ ->
                    todayHotOrderList = hotOrderList
                    showTodayHotOrder()

                },
                onFailure = {}
        )
    }



    /**
     *  竞彩单关赛事 显示规则
     *  优先让球胜平负
     */
    private fun showSingleMatch() {

        if (requestFootBallList.size == 0) {
            home_no_single_match_linear.visibility = View.VISIBLE
            home_single_match_linear.visibility = View.GONE
            return
        }

        home_no_single_match_linear.visibility = View.GONE
        home_single_match_linear.visibility = View.VISIBLE

        requestFootballBean = requestFootBallList.first { it.spfSingle == 1 || it.rqspfFixed == 1 }

        isRqSpfBoolean = requestFootballBean!!.spfSingle != 1

        if (requestFootballBean == null) return
        val letBall = if ((requestFootballBean?.letBall
                        ?: 0.0).toInt() > 0) "-${requestFootballBean?.letBall?.toInt()}" else "${requestFootballBean?.letBall?.toInt()}"
        home_hot_league_name.text = requestFootballBean?.leagueName
        home_hot_home_name.text = requestFootballBean?.home3
        home_hot_away_name.text = requestFootballBean!!.away3
        home_hot_league_end_time.text = "${TimeUtil.getFormatTime(requestFootballBean!!.saleEndTime, "MM-dd HH:mm")} 截止"
        ImageLoaderUtil.displayHeadImg(requestFootballBean!!.homeLogo, home_hot_home_img)
        ImageLoaderUtil.displayHeadImg(requestFootballBean!!.awayLogo, home_hot_away_img)

        var draw = "${if (isRqSpfBoolean) letBall else ""} 平 "
        var win = "${if (isRqSpfBoolean) letBall else ""} 胜 "
        var lost = "${if (isRqSpfBoolean) letBall else ""} 负 "

        if (isRqSpfBoolean) {
            win += requestFootballBean!!.rqspf_sp3
            draw += requestFootballBean!!.rqspf_sp1
            lost += requestFootballBean!!.rqspf_sp0

        } else {
            win += requestFootballBean!!.spf_sp3
            draw += requestFootballBean!!.spf_sp1
            lost += requestFootballBean!!.spf_sp0
        }

        home_hot_bf_draw.text = draw
        home_hot_bf_win.text = win
        home_hot_bf_lost.text = lost

        showMinBetLinear()


    }


    /**
     * 默认显示赔率最低的选项
     */
    private fun showMinBetLinear() {

        winBoolean = false
        drawBoolean = false
        lostBoolean = false
        twentyBoolean = true
        fiftyBoolean = false
        oneHundredBoolean = false

        val arrayList =
                if (isRqSpfBoolean) arrayListOf(requestFootballBean!!.rqspf_sp3, requestFootballBean!!.rqspf_sp1, requestFootballBean!!.rqspf_sp0)
                else arrayListOf(requestFootballBean!!.spf_sp3, requestFootballBean!!.spf_sp1, requestFootballBean!!.spf_sp0)
        when (arrayList.min()) {
            if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp3 else requestFootballBean!!.spf_sp3 -> winBoolean = true
            if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp1 else requestFootballBean!!.spf_sp1 -> drawBoolean = true
            if (isRqSpfBoolean) requestFootballBean!!.rqspf_sp0 else requestFootballBean!!.spf_sp0 -> lostBoolean = true
        }


    }

    /**
     * 今日热单显示详情
     */

    private fun showTodayHotOrder() {

        if (todayHotOrderList.isEmpty()) {
            home_today_hot_order.visibility = View.GONE
            return
        }

        home_today_hot_order.visibility = View.VISIBLE

        todayHotOrderList.first()?.let {

            ImageLoaderUtil.displayHeadImg(it.userAvatar, orderImg)
            orderName?.text = it.userName
            orderNumber?.text = "近${it.weekStatisticsBean.number}单"
            orderWinNumber?.text = "${it.weekStatisticsBean.number}中${it.weekStatisticsBean.winNumber}"
            orderRote?.text = "${it.rate} 倍"
            orderSelfBuy?.text = Html.fromHtml("自购 <font color='#EB656D'>${FormatPresenter.getNumberString(it.totalMoney)}</font> 元")
            orderFollowPerson?.text = Html.fromHtml("跟单 <font color='#EB656D'>${it.follow}</font> 人")
            orderEndTime?.text = "截止: " + TimeUtil.getFormatTime(it.endTime, "MM-dd HH:mm")
        }

    }


    /**
     * 首页详情请求完毕 操作
     */
    private fun showTopListAndNotice() {
        bannerPictureList.clear()
        newsDetailBean?.let {




            //更新图片和标题
            it.topicList.take(limit).forEach {
                bannerPictureList.add(it.img)
            }

            //设置图片轮播器参数
            fragment_home_banner.setImages(bannerPictureList)
                    .setOffscreenPageLimit(limit)
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setBannerStyle(BannerConfig.CIRCLE_INDICATOR)
                    .setImageLoader(ImageLoaderUtil())
                    .start()

            /**
             * 喜报
             *
             */
            val noticeList: ArrayList<String> = ArrayList()
            it.newBonusList.forEach { noticeList.add("${it.nickName.substring(0, 1)}****的${it.lotteryName}方案中奖 <font color='#FF0000'>${it.bonus}</font> 元") }
            fragment_home_looper_text_view.setTipList(noticeList)

            //防止后台更改数据位置  自己遍历

            /**
             * 竞彩足球
             */
            it.lotterySale.home.first { it.lotteryId == LotteryIdEnum.jczq.id }.run {
                home_lottery_jczq_name.text = this.lotteryName
                home_lottery_jczq_describe.text = this.description
            }


            /**
             * 竞彩篮球
             */
            it.lotterySale.home.first { it.lotteryId == LotteryIdEnum.jclq.id }.run {
                home_lottery_jclq_name.text = this.lotteryName
                home_lottery_jclq_describe.text = this.description
            }




        }

    }


    override fun onResume() {
        super.onResume()
        //开始自动翻页
        fragment_home_banner.startAutoPlay()
    }


    override fun onPause() {
        super.onPause()
        // 停止自动翻页
        fragment_home_banner.stopAutoPlay()
    }


}
