package com.caidian310.activity.user

import android.os.Bundle
import android.os.Handler
import android.support.design.widget.TabLayout
import android.support.v4.widget.SwipeRefreshLayout
import android.view.Gravity
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.user.BuyListAdapter
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.user.OrderAndBuyBean
import com.caidian310.presenter.FormatPresenter.removeRepeat
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.TimeUtil
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.custom.RefreshLayout
import com.caidian310.view.popupWindow.SelectPayLogWindow
import kotlinx.android.synthetic.main.activity_user_buy_list.*

class BuyListActivity : BaseActivity() {

    private val titles = arrayOf("全部", "自购", "发单", "跟单")
    private val choseTitles = arrayListOf("待开奖", "未中奖", "已中奖", "全部")

    private val pageSize = 20
    private var page = 1
    private val mHandler = Handler()
    private var sinceTime: Long? = null
    private var adapter: BuyListAdapter? = null
    private var orderTypeId: Int? = null      //buyType  无:所有 0:代购自购 1:发单 2:复制跟单
    private var winTypeId: Int = 3            //全部

    private var buyList: ArrayList<OrderAndBuyBean> = ArrayList()
    private var hashMap: LinkedHashMap<String, ArrayList<OrderAndBuyBean>> = LinkedHashMap()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initActionBar()
        setContentView(R.layout.activity_user_buy_list)
        initEvent()
        initListener()
    }

    fun initActionBar() {
        initActionBar(centerTitle = "购彩记录")
        rightImg?.visibility = View.VISIBLE
        rightImg?.setOnClickListener {
            val seasonSelectWindow = SelectPayLogWindow(this, choseTitles, winTypeId)
            seasonSelectWindow.setCallBack(callBack)
            seasonSelectWindow.showAtLocation(buy_list_root_view, Gravity.BOTTOM, 0, 0)
        }
    }

    override fun initEvent() {
        super.initEvent()
        val content = intent.getStringExtra("orderTypeId")
        orderTypeId = if (content.isNullOrEmpty()) null else content.toInt()

        setTabLayout()

        adapter = BuyListAdapter(this, hashMap)
        buy_list_view.setAdapter(adapter)


        buy_list_refresh.isRefreshing = true
        requestBuyList()
    }


    override fun initListener() {
        super.initListener()
        buy_list_refresh.setOnLoadListener(onLoadingListener)
        buy_list_refresh.setOnRefreshListener(onRefreshListener)

        buy_list_bg_img.setOnClickListener {
            buy_list_refresh.isRefreshing = true
            buy_list_refresh.visibility = View.VISIBLE
            buy_list_bg_img.visibility = View.GONE
            requestBuyList()
        }


    }


    // 初始化tabLayout
    private fun setTabLayout() {
        buy_list_tab.tabMode = TabLayout.MODE_FIXED
        titles.forEachIndexed { index, it ->
            buy_list_tab.addTab(buy_list_tab.newTab())
            buy_list_tab.getTabAt(index)!!.text = it
        }
        buy_list_tab.getTabAt(when (orderTypeId) {
            OrderTypeEnum.CopyOrder.id -> 3
            OrderTypeEnum.Order.id -> 2
            OrderTypeEnum.Purchasing.id -> 1
            else -> 0
        })!!.select()
        buy_list_tab.addOnTabSelectedListener(tabListener)

    }

    //刷新结束
    private fun closeRefresh() {
        buy_list_refresh.isRefreshing = false
        buy_list_refresh.setLoading(false)

        if (buyList.size == 0) {
            buy_list_bg_img.visibility = View.VISIBLE
            buy_list_refresh.visibility = View.GONE
        } else {
            buy_list_bg_img.visibility = View.GONE
            buy_list_refresh.visibility = View.VISIBLE
        }
    }


    /**
     * 购买列表 -> 投注记录
     */
    private fun requestBuyList() {
        UserPresenter.requestBuyList(
                this,
                orderTypeId,
                pageSize,
                page,
                sinceTime,
                onSuccess = {

                    buyList.addAll(removeRepeat(buyList, it.list, page, it.pageInfo.pageCount))
                    issueBuyList(buyList, winTypeId, orderTypeId)

                    closeRefresh()

                },
                onFailure = {

                    closeRefresh()
                })


    }


    /**
     * 选择符合条件的数据
     * 数据根据购买日期分期
     * @param list 数据集合
     * @param winTypeId 中奖状态
     */
    private fun issueBuyList(list: ArrayList<OrderAndBuyBean>, winTypeId: Int, orderTypeId: Int? = null) {
        hashMap.clear()

        val issueList: ArrayList<String> = ArrayList()
        list.forEach {
            val issue = TimeUtil.getFormatTime(it.buy.buyTime, "yyyy-MM-dd")
            if (!issueList.contains(issue)) issueList.add(issue)
        }

        issueList.forEach {
            val issueItem = it
            val newList = list.filter {
                issueItem ==
                        TimeUtil.getFormatTime(it.buy.buyTime, "yyyy-MM-dd") &&
                        if (winTypeId != 3) it.order.winStatus == winTypeId else true &&                  //是否值中奖状态
                                if (orderTypeId != null) it.order.orderType == orderTypeId else true      //订单类型

            } as ArrayList<OrderAndBuyBean>
            if (!newList.isEmpty()) hashMap[issueItem] = newList

        }

        adapter?.notifyDataSetChanged()
        if (hashMap.size == 0) return

        //去掉默认箭头和全部展开
        buy_list_view.setGroupIndicator(null)
        for (index in 0 until hashMap.size) {
            buy_list_view.expandGroup(index)
        }


    }


    // 下拉刷新
    private
    val onRefreshListener: SwipeRefreshLayout.OnRefreshListener = SwipeRefreshLayout.OnRefreshListener {
        mHandler.postDelayed({
            page = 1
            requestBuyList()
        }, 1500)

    }


    //上啦加载
    private
    val onLoadingListener: RefreshLayout.OnLoadListener = RefreshLayout.OnLoadListener {
        mHandler.postDelayed({
            page++
            requestBuyList()
        }, 1500)

    }


    //投注记录刷选
    var callBack: CallPositionBack = object : CallPositionBack {
        override fun callPositionBack(position: Int, describe: String) {
            winTypeId = position
            issueBuyList(list = buyList, winTypeId = winTypeId)
            adapter?.notifyDataSetChanged()

        }
    }


    private val tabListener: TabLayout.OnTabSelectedListener = object : TabLayout.OnTabSelectedListener {
        override fun onTabReselected(tab: TabLayout.Tab?) {

        }

        override fun onTabUnselected(tab: TabLayout.Tab?) {
        }

        override fun onTabSelected(tab: TabLayout.Tab?) {
            orderTypeId = getOrderTypeId(tab?.position)
            page = 1
            buyList.clear()
            buy_list_refresh.isRefreshing = true
            requestBuyList()
        }
    }


    /**
     *
     */
    fun getOrderTypeId(position: Int? = null) = when (position) {
        3 -> OrderTypeEnum.CopyOrder.id            //跟单
        2 -> OrderTypeEnum.Order.id                //发单
        1 -> OrderTypeEnum.Purchasing.id           //自购
        else -> null                               //全部
    }

    override fun finish() {
        super.finish()
        orderTypeId = null
        winTypeId = 0
    }
}
