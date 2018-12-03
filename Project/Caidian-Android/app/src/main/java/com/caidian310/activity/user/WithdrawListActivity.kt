package com.caidian310.activity.user

import android.os.Bundle
import android.os.Handler
import android.support.v4.widget.SwipeRefreshLayout
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.user.WithdrawListAdapter
import com.caidian310.bean.user.WithdrawBean
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.view.custom.RefreshLayout
import kotlinx.android.synthetic.main.activity_user_withdraw_list.*

class WithdrawListActivity : BaseActivity() {

    var adapter: WithdrawListAdapter? = null
    private var mList: ArrayList<WithdrawBean> = ArrayList()

    private var page: Int = 0
    private var pageSize: Int = 20

    private val mHandler = Handler()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_withdraw_list)
        initActionBar(centerTitle = "提现记录")
        initEvent()


    }


    override fun initEvent() {
        super.initEvent()

        withdraw_refresh.setOnLoadListener(onLoadingListener)
        withdraw_refresh.setOnRefreshListener(onRefreshListener)


        withdraw_refresh.isRefreshing = true


        adapter = WithdrawListAdapter(this, mList)
        withdraw_list_view.adapter = adapter
        requestWithdrawList()

    }

    /**
     * 请提现列表
     */

    private fun requestWithdrawList() {
        UserPresenter.requestApplyWithdrawList(
                context = this,
                page = page,
                pageSize = pageSize,
                onSuccess = { pageInfo, list ->
                    mList.addAll(FormatPresenter.removeRepeat(mList, list, page, pageInfo.pageCount))
                    if (mList.size==0){
                        withdraw_no_data.visibility = View.VISIBLE
                        withdraw_refresh.visibility = View.GONE
                    }
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
        withdraw_refresh.isRefreshing = false
        withdraw_refresh.setLoading(false)
    }

    //上啦加载
    private val onLoadingListener: RefreshLayout.OnLoadListener = RefreshLayout.OnLoadListener {
        mHandler.postDelayed({
            page++
            requestWithdrawList()
        }, 1500)

    }


    // 下拉刷新
    private val onRefreshListener: SwipeRefreshLayout.OnRefreshListener = SwipeRefreshLayout.OnRefreshListener {
        mHandler.postDelayed({
            page = 1
            requestWithdrawList()
        }, 1500)

    }


}
