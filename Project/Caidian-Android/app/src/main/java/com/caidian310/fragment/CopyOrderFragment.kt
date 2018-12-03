package com.caidian310.fragment


import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.support.v4.widget.SwipeRefreshLayout
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.caidian310.R
import com.caidian310.activity.sport.order.CopyOrderDetailActivity
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.order.CopyOrderListAdapter
import com.caidian310.bean.sport.order.CopyOrderBean
import com.caidian310.fragment.base.BaseFragment
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.order.OrderPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.view.custom.RefreshLayout
import kotlinx.android.synthetic.main.fragment_copy_order.*


/**
 * 复制跟单
 *
 */
class CopyOrderFragment : BaseFragment() {

    var mPage = 1
    var mPageSize = 20
    var mList: ArrayList<CopyOrderBean> = ArrayList()
    var mAdapter: BaseAdapter<CopyOrderBean>? = null

    var isLoadingOrRefreshBoolean = false

    private val mHandler = Handler()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_copy_order, container, false)
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        initView()

        initEvent()
    }




    override fun initView() {
        super.initView()
        fragment_copy_order_chose.setColorFilter(ColorUtil.getColor(R.color.white))
    }

    override fun initEvent() {
        super.initEvent()

        fragment_copy_order_refresh.isRefreshing = true

        fragment_copy_order_refresh.setOnLoadListener(onLoadingListener)
        fragment_copy_order_refresh.setOnRefreshListener(onRefreshListener)

        mAdapter = CopyOrderListAdapter(context = context!!, list = mList)
        fragment_copy_order_list_view.adapter = mAdapter


        fragment_copy_order_chose.setOnClickListener {
            startActivity(Intent(activity!!, CopyOrderDetailActivity::class.java))
        }

        requestCopyOrderLists()

        fragment_copy_order_no_data.setOnClickListener {
            mPage = 1
            mList.clear()
            fragment_copy_order_no_data.visibility = View.GONE
            fragment_copy_order_refresh.visibility = View.VISIBLE
            fragment_copy_order_refresh.isRefreshing = true
            requestCopyOrderLists()
        }
    }


    /**
     * fragment 可见性判断
     */
    override fun onHiddenChanged(hidden: Boolean) {
        super.onHiddenChanged(hidden)
        if (!hidden){
            requestCopyOrderLists()
        }
    }


    /**
     * 复制跟单网络请求
     */

    private fun requestCopyOrderLists() {
        isLoadingOrRefreshBoolean = true

        OrderPresenter.requestCopyOrderLists(
                context = context!!,
                page = mPage,
                pageSize = mPageSize,
                onSuccess = { copyOrderBeanLists, pageInfo ->
                    mList.addAll(FormatPresenter.removeRepeat(
                            oldArrayList = mList,
                            newsArrayList = copyOrderBeanLists,
                            currentPage = mPage,
                            pageCount = pageInfo.pageCount
                    ))
                    mAdapter?.notifyDataSetChanged()
                    closeRefresh()


                },
                onFailure = {
                    closeRefresh()
                }
        )
    }


    //刷新结束
    private fun closeRefresh() {
        isLoadingOrRefreshBoolean = false
        fragment_copy_order_refresh.isRefreshing = false
        fragment_copy_order_refresh.setLoading(false)
        fragment_copy_order_no_data.visibility = if (mList.size == 0) View.VISIBLE else View.GONE
        fragment_copy_order_refresh.visibility = if (mList.size != 0) View.VISIBLE else View.GONE

    }

    //上啦加载
    private val onLoadingListener: RefreshLayout.OnLoadListener = RefreshLayout.OnLoadListener {
        if (!isLoadingOrRefreshBoolean) {
            mHandler.postDelayed({
                mPage++
                requestCopyOrderLists()
            }, 1500)

        }

    }


    // 下拉刷新
    private val onRefreshListener: SwipeRefreshLayout.OnRefreshListener = SwipeRefreshLayout.OnRefreshListener {
        if (!isLoadingOrRefreshBoolean)
            mHandler.postDelayed({
                mList.clear()
                mPage = 1
                requestCopyOrderLists()
            }, 1500)

    }
}
