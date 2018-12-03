package com.caidian310.activity.user

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.support.v4.widget.SwipeRefreshLayout
import android.view.Gravity
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.user.PayLogAdapter
import com.caidian310.bean.buy.PayBean
import com.caidian310.bean.enumBean.TradeIdEnum
import com.caidian310.presenter.FormatPresenter.removeRepeat
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.custom.RefreshLayout
import com.caidian310.view.popupWindow.SelectPayLogWindow
import kotlinx.android.synthetic.main.activity_user_pay_log.*

// 账户明细
class PayLogActivity : BaseActivity() {
    private val mHandler = Handler()


    private var page = 1
    private var pageSize = 20
    private var sinceTime: Long? = null

    private var payList: ArrayList<PayBean> = ArrayList()
    var adapter: PayLogAdapter? = null


    private var titles = arrayListOf("近一周", "近一个月", "近三个月")
    var initPosition: Int = 0                                         // 时间选择当前的位置


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_pay_log)

        initActionBar()
        initEvent()
        initListener()
    }

    override fun initEvent() {
        super.initEvent()

        adapter = PayLogAdapter(context = this, payList = payList)
        account_record_list_view.adapter = adapter

        //打开就加载数据
        account_record_refresh.isRefreshing = true
        requestPayLogList(page, pageSize, sinceTime)

    }

    override fun initListener() {
        super.initListener()
        account_record_refresh.setOnLoadListener(onLoadingListener)
        account_record_refresh.setOnRefreshListener(onRefreshListener)

        account_record_bg_img.setOnClickListener {
            account_record_refresh.isRefreshing = true
            account_record_bg_img.visibility = View.GONE
            requestPayLogList(
                    page = page,
                    pageSize = pageSize,
                    sinceTime = sinceTime
            )
        }
    }


    private fun initActionBar() {

        initActionBar(centerTitle = "账户明细")
        rightImg?.visibility = View.VISIBLE

        rightImg?.setOnClickListener {
            val seasonSelectWindow = SelectPayLogWindow(this, titles, initPosition)
            seasonSelectWindow.setCallBack(callBack)
            seasonSelectWindow.showAtLocation(this.findViewById(R.id.account_record_list_view), Gravity.BOTTOM, 0, 0)
        }



    }


    //账户明细时间刷西选
    var callBack: CallPositionBack = object : CallPositionBack {
        override fun callPositionBack(position: Int, describe: String) {
            initPosition = position

            sinceTime = when (position) {
                0 -> {
                    System.currentTimeMillis() / 1000 - 7 * 24 * 60 * 60
                }
                1 -> {
                    System.currentTimeMillis() / 1000 - 30 * 24 * 60 * 60
                }
                else -> {
                    null
                }
            }
            account_record_refresh.isRefreshing = true
            requestPayLogList(page, pageSize, sinceTime)

        }
    }


    /**
     * 购买记录请求
     */

    private fun requestPayLogList(page: Int, pageSize: Int, sinceTime: Long?) {
        UserPresenter.requestPayLogList(context = this,
                pageSize = pageSize,
                page = page,
                sinceTime = sinceTime,
                onSuccess = {
                    payList.addAll(removeRepeat(payList, it.list, page, it.pageInfo.pageCount))
                    adapter?.notifyDataSetChanged()
                    closeRefresh()
                },
                onFailure = {
                    closeRefresh()
                }
        )
    }

    //刷新结束
    private fun closeRefresh() {
        account_record_refresh.isRefreshing = false
        account_record_refresh.setLoading(false)

        if (payList.size == 0) {
            account_record_bg_img.visibility = View.VISIBLE
            account_record_refresh.visibility = View.GONE
        } else {
            account_record_bg_img.visibility = View.GONE
            account_record_refresh.visibility = View.VISIBLE
        }

    }


    // 下拉刷新
    private val onRefreshListener: SwipeRefreshLayout.OnRefreshListener = SwipeRefreshLayout.OnRefreshListener {
        mHandler.postDelayed({
            page = 1
            requestPayLogList(page, pageSize, sinceTime)
        }, 1500)

    }


    //上啦加载
    private val onLoadingListener: RefreshLayout.OnLoadListener = RefreshLayout.OnLoadListener {
        mHandler.postDelayed({
            page++
            requestPayLogList(page, pageSize, sinceTime)
            showToast("上啦加载")
        }, 1500)

    }
}

