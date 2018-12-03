package com.caidian310.activity.sport.order

import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.support.design.widget.TabLayout
import android.support.v7.widget.DividerItemDecoration
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.text.Html
import android.view.View
import android.view.WindowManager
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.buy.OrderBuyActivity
import com.caidian310.adapter.order.CopyOrderDetailBetGridViewAdapter
import com.caidian310.adapter.order.CopyOrderFollowAdapter
import com.caidian310.adapter.order.CopyOrderFollowBetAdapter
import com.caidian310.bean.buy.PayMatch
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.user.CopyOrderDetailBean
import com.caidian310.bean.user.CopyOrderPerson
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.TextPresenter
import com.caidian310.presenter.order.OrderPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.callBack.CallBack
import kotlinx.android.synthetic.main.activity_sport_order_copy_order_detail.*
import org.jetbrains.anko.textColor


class CopyOrderDetailActivity : BaseActivity() {

    private var mTabTitles = arrayOf("方案详情", "跟单用户")
    private var id: Int = 1292
    private var copyOrderDetailBean: CopyOrderDetailBean? = null
    private var mAdapter: CopyOrderDetailBetGridViewAdapter? = null
    private var mListViewAdapter: CopyOrderFollowAdapter? = null
    private var mMatchListViewAdapter: CopyOrderFollowBetAdapter? = null
    private var multiple = 0


    private var emptyView: View? = null

    private var mGridViewList: ArrayList<Int> = ArrayList()
    private var mFollowList: ArrayList<CopyOrderPerson> = ArrayList()
    private var mMatchList: ArrayList<PayMatch> = ArrayList()

    private val mHandler = Handler()

    private var oneMoney: Double? = null            //单注金额
        set(value) {
            field = value
            copy_order_detail_min_money.text = Html.fromHtml("<font color='#EB656D'>$value</font>元起投")
        }

    private var page = 1
    private var pageCount: Int = 0                  //及时跟新跟单人数
        set(value) {
            field = value
            if (copy_order_detail_tab_layout == null || copy_order_detail_tab_layout.tabCount == 0) return
            copy_order_detail_tab_layout.getTabAt(1)?.text = Html.fromHtml("${mTabTitles[1]}${"(<font color='#EB656D'>$value</font>)"}")
        }


    private var betTypeString: String = ""
        set(value) {
            field = value
            copy_order_bet_type.text = betTypeString
            copy_order_detail_lottery_serial.text = betTypeString
        }

    private var isOrderSelfBoolean = false       //自己不能跟单
        set(value) {
            field = value

            copy_order_bet_step.textColor = ColorUtil.getColor(if (isOrderSelfBoolean) R.color.f2f2f2 else R.color.white)

        }

    private var isLoadingBoolean: Boolean = false

    private var content = ""
        set(value) {
            field = value
            copy_order_detail_user_describe.text = Html.fromHtml(value)
            copy_order_detail_action_content.text = Html.fromHtml(copyOrderDetailBean?.copy?.userName + "   " + value)
        }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.statusBarColor = Color.parseColor("#fff2f2f2")
        }

        setContentView(R.layout.activity_sport_order_copy_order_detail)
        initView()
        initEvent()
        initListener()

        // 测试
        val a = 1
        val b =2



        if (a >= b){}else {}

    }

    override fun initView() {
        super.initView()
        copy_order_detail_back.setColorFilter(Color.WHITE)
    }


    override fun initEvent() {
        super.initEvent()
        id = intent.getIntExtra("orderId", 1292)

        mGridViewList.addAll(arrayListOf(10, 20, 50, 100))

        mAdapter = CopyOrderDetailBetGridViewAdapter(context = this, list = mGridViewList)
        copy_order_bet_grid_view.adapter = mAdapter
        mAdapter?.setCallBetBack(CallBack {
            multiple = mAdapter?.choseList?.first() ?: 0
            updateBetMoney()
            copy_order_bet_number_all.setText(multiple.toString())
            copy_order_bet_number_all.setSelection("$multiple".length)
        })
        mAdapter?.notifyDataSetChanged()


        /**
         * 跟单详情
         */
        copy_order_detail_match_list_view.layoutManager = LinearLayoutManager(this) as RecyclerView.LayoutManager?
        copy_order_detail_match_list_view.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))

        mMatchListViewAdapter = CopyOrderFollowBetAdapter(context = this, list = mMatchList)
        copy_order_detail_match_list_view.adapter = mMatchListViewAdapter
        mMatchListViewAdapter?.notifyDataSetChanged()

        copy_order_detail_follow_list_view.layoutManager = LinearLayoutManager(this)
        copy_order_detail_follow_list_view.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))
        /**
         * 跟单人数
         */
        mListViewAdapter = CopyOrderFollowAdapter(context = this, list = mFollowList)
        copy_order_detail_follow_list_view.adapter = mListViewAdapter
        mListViewAdapter?.notifyDataSetChanged()


        requestCopyOrderDetail()


    }


    override fun onStart() {
        super.onStart()
        /**
         * 更新跟单人信息
         */
        isLoadingBoolean = false
        page = 1
        mFollowList.clear()
        requestCopyOrderPerson()

    }


    override fun initListener() {
        super.initListener()

        copy_order_app_bar.addOnOffsetChangedListener { appBarLayout, verticalOffset ->

            val scrollRange = appBarLayout.totalScrollRange
            val alpha = Math.abs((scrollRange + 1.0f * verticalOffset) / scrollRange)
            copy_order_header_relative.alpha = alpha
            copy_order_info_tool_bar.alpha = 1.0f - alpha
        }


        /**
         * 下一步
         */
        copy_order_bet_step.setOnClickListener { requestCopyOrderBuy() }

        copy_order_detail_tab_layout.setOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {
            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {
            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                copy_order_detail_follow_list_view.visibility = if (tab?.position == 1) View.VISIBLE else View.GONE

                if (tab?.position == 1) {
                    mFollowList.clear()
                    page = 1
                    requestCopyOrderPerson()
                } else {
                    showBetView(showIndex = tab?.position ?: 0)
                }
            }
        })


        //倍数 －
        copy_order_bet_number_reduce.setOnClickListener { updateBetNumber(addBoolean = false) }

        //倍数 +
        copy_order_bet_number_add.setOnClickListener { updateBetNumber() }

        /**
         * 倍数
         */
        copy_order_bet_number_all.addTextChangedListener(
                TextPresenter.setEditCount(
                        editText = copy_order_bet_number_all,
                        onChange = {
                            val content = copy_order_bet_number_all.text
                            multiple = if (content.isNullOrEmpty()) 0 else content.toString().toInt()
                            if (!mGridViewList.contains(multiple)) {
                                mAdapter?.choseList?.clear()
                            } else {
                                mAdapter?.choseList?.add(multiple)
                            }
                            mAdapter?.notifyDataSetChanged()
                            updateBetMoney()
                        }
                ))


        /**
         * 跟单列表
         */
        copy_order_detail_follow_list_view.setOnScrollListener(object : RecyclerView.OnScrollListener() {


            override fun onScrollStateChanged(recyclerView: RecyclerView?, newState: Int) {

                val manager = recyclerView!!.layoutManager as LinearLayoutManager
                val lastItemPosition = manager.findLastVisibleItemPosition()
                val itemCount = manager.itemCount


                if (newState == 1 && lastItemPosition == itemCount - 1) {

                    /**
                     * 已加载完毕 或者正在加载中 返回
                     */

                    if (isLoadingBoolean || pageCount <= mFollowList.size) return

                    mFollowList.add(CopyOrderPerson(userId = -1))
                    mListViewAdapter?.notifyDataSetChanged()

                    isLoadingBoolean = true
                    mHandler.postDelayed({
                        page++
                        requestCopyOrderPerson()
                    }, 1500)
                }
                super.onScrollStateChanged(recyclerView, newState)
            }
        })


        /**
         * 返回
         */

        copy_order_detail_back.setOnClickListener { finish() }

    }


    /**
     * 投注倍数点击操作
     * 修改金额和倍数
     */
    private fun updateBetMoney() {


        copy_order_bet_count_and_money.text = Html.fromHtml("<font color='#EB656D'>$multiple</font>注  共<font color='#EB656D'> ${multiple * (oneMoney
                ?: 0.00)}</font>元")

    }


    /**
     * 添加和减少倍数  最少1倍
     * @param addBoolean 是否添加 true 添加 false 减少
     */

    private fun updateBetNumber(addBoolean: Boolean = true) {
        if (addBoolean) multiple++                     //倍数 +
        if (!addBoolean && multiple > 1) multiple--    //倍数 －
        copy_order_bet_number_all.setText(multiple.toString())
        copy_order_bet_number_all.setSelection("$multiple".length)
    }

    /**
     * 复制跟单购买
     */
    private fun requestCopyOrderBuy() {

        if (isOrderSelfBoolean) {
            showToast("自己不能跟自己的单")
            return
        }
        if (multiple == 0) {
            showToast("倍数不能为空")
            return
        }

        if (oneMoney == 0.00) return


        /**
         * 页面跳转
         */
        val intent = Intent(this, OrderBuyActivity::class.java)
        intent.putExtra("lotteryId", copyOrderDetailBean?.order?.lotteryId ?: LotteryIdEnum.jczq.id)
        intent.putExtra("playId", copyOrderDetailBean?.order?.playId ?: 0)
        intent.putExtra("orderTypeId", OrderTypeEnum.CopyOrder.id.toString())
        intent.putExtra("orderId", id)
        intent.putExtra("orderTotalMoney", (oneMoney ?: 0.00) * multiple)
        intent.putExtra("multiple", multiple)
        startActivity(intent)


    }


    /**
     * 复制跟单人
     */
    private fun requestCopyOrderPerson() {
        OrderPresenter.requestCopyOrderPerson(
                context = this,
                orderId = id,
                page = page,
                onSuccess = {
                    isLoadingBoolean = false

                    val count = mFollowList.filter { it.userId == -1 }
                    if (count.isNotEmpty()) mFollowList.remove(count.first())


                    mFollowList.addAll(FormatPresenter.removeRepeat(
                            oldArrayList = mFollowList,
                            newsArrayList = it.list,
                            currentPage = page,
                            pageCount = it.pageInfo.pageCount
                    ))

                    /**
                     * 如果没数据
                     */
                    if (mFollowList.size == 0) mFollowList.add(CopyOrderPerson(userId = -2))
                    mListViewAdapter?.notifyDataSetChanged()

                    pageCount = it.pageInfo.dataCount

                },
                onFailure = {
                    isLoadingBoolean = false
                    if (mFollowList.size == 0) return@requestCopyOrderPerson
                    mFollowList.remove(mFollowList.first { it.userId == -1 })
                    mListViewAdapter?.notifyDataSetChanged()
                    showToast(it.message)

                }
        )

    }

    /**
     * 网络加载结束
     */

    private fun closePressor() {
        copy_order_detail_body.visibility = View.VISIBLE
        copy_order_detail_progress_bar.visibility = View.GONE

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = Color.parseColor("#000000")
        }
    }


    /**
     * 复制跟单网络请求
     */
    private fun requestCopyOrderDetail() {

        OrderPresenter.requestCopyOrderDetail(
                context = this,
                id = id,
                onSuccess = {
                    copyOrderDetailBean = it
                    setViewData()
                    closePressor()
                },
                onFailure = {

                    closePressor()
                    if (copy_order_detail_tab_layout.tabCount == 0) {
                        mTabTitles.forEach { copy_order_detail_tab_layout.addTab(copy_order_detail_tab_layout.newTab().setText(it)) }
                    }
                    showToast(it.message)
                }
        )
    }

    /**
     * 初始化值
     *
     */
    private fun setViewData() {
        copyOrderDetailBean?.run {

            isOrderSelfBoolean = order.userId == DbUtil().getUserBean().id
            oneMoney = copy.oneMoney
            ImageLoaderUtil.displayHeadImg(copy.userAvatar, copy_order_detail_user_header_img)
            ImageLoaderUtil.displayHeadImg(copy.userAvatar, copy_order_detail_action_img)
            copy_order_detail_user_name.text = copy.userName
            copy_order_detail_user_name.text = copy.userName
            copy_order_detail_lottery_name.text = LotteryIdEnum.jczq.getLotteryEnumFromId(code.lotteryId).lotteryName
            var serialListString = ""
            code.serialList.forEach { serialListString += "  $it  " }
            copy_order_detail_lottery_serial.text = serialListString
            copy_order_detail_rate.text = Html.fromHtml("预计回报率: <font color='#EB656D'>${copy.rate}</font>倍")
            copy_order_detail_money.text = Html.fromHtml("自购: <font color='#EB656D'>${copy.totalMoney}</font>元")
            copy_order_detail_copy_money.text = Html.fromHtml("跟单: <font color='#EB656D'>${copy.followMoney}</font>元")
            copy_order_detail_number.text = order.orderNum
            copy_order_detail_send_time.text = "发单时间: " + TimeUtil.getFormatTime(order.createTime)
            val win = if (copy.weekStatisticsBean.winNumber == 0 || copy.weekStatisticsBean.number == 0) "0%"
            else "${FormatPresenter.doubleToString((copy.weekStatisticsBean.winNumber * 100.00 / copy.weekStatisticsBean.number))}%"
            content = "${copy.weekStatisticsBean.number}中${copy.weekStatisticsBean.winNumber} | 10单盈利率:  <font color='#EB656D'>$win</font>"

            copy_order_type.text = "方案内容 ${if (order.isSecret==1) "(截止后公开)" else ""} "

            mTabTitles.forEachIndexed { index, s ->
                copy_order_detail_tab_layout.addTab(copy_order_detail_tab_layout.newTab().setText(Html.fromHtml("$s${if (index == 1) "(<font color='#EB656D'>${copy.follow}</font>)" else ""}")))
            }


            /**
             * 计算串关数
             */
            betTypeString =
                    when (code.serialList.size) {
                        1 -> {
                            when (code.serialList.first().substring(0, 1)) {
                                "1" -> "单关"
                                else -> code.serialList.first()
                            }
                        }
                        else -> "混合过关"
                    }

            mMatchList.add(code.matchList.first())
            mMatchList.addAll(code.matchList)
            mMatchListViewAdapter?.notifyDataSetChanged()

            showBetView()

            multiple = if (copy_order_bet_number_all.text.isNullOrEmpty()) 0 else copy_order_bet_number_all.text.toString().toInt()
            updateBetMoney()

        }

    }


    /**
     * 如果is_select =  0: 公开无佣金 ,1:截止后公开无佣金
     * 检查比赛的随大的时间是否已开赛
     */

    fun showBetView(showIndex: Int = 0) {
        copyOrderDetailBean?.run {

            /**
             * 是否全部开赛
             */
            val maxTimeMatch = code.matchList.maxBy { it.match.matchTime }
            val isStartMatchBoolean = maxTimeMatch!!.match.matchTime * 1000 < System.currentTimeMillis()

            /**
             * 是否可见
             */
            if (isStartMatchBoolean || order.isSecret == 0 || isOrderSelfBoolean) {
                showPublicView(showIndex)
                return
            }
            showPrivateView()
            copy_order_detail_private_time.text = TimeUtil.getFormatTime(maxTimeMatch.match.matchTime, "MM-dd HH:mm") + " 截止后公布"
        }
    }

    /**
     * 公开显示样式
     */
    private fun showPublicView(showIndex: Int) {
        copy_order_detail_private.visibility = View.GONE
        copy_order_detail_match_body.visibility = if (showIndex == 0) View.VISIBLE else View.GONE
        copy_order_detail_linear.visibility = if (showIndex == 0) View.VISIBLE else View.GONE
    }

    /**
     * 截止后公开显示样式(未开赛)
     */
    private fun showPrivateView() {
        copy_order_detail_private.visibility = View.VISIBLE
        copy_order_detail_match_body.visibility = View.GONE
    }


}
