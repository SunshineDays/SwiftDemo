package com.caidian310.adapter.order

import android.content.Context
import android.content.Intent
import android.text.Html
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.sport.order.CopyOrderDetailActivity
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.bean.sport.order.CopyOrderBean
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.custom.RoundImageView




// 发单列表
class CopyOrderListAdapter(var context: Context, list: ArrayList<CopyOrderBean>) : BaseAdapter<CopyOrderBean>(context, list) {
    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_copy_order
    }

    override fun onBindHolder(holder: BaseViewHolder?, item: CopyOrderBean?, position: Int) {

        val mHeaderRoot = holder?.getView<LinearLayout>(R.id.item_copy_order_root)
        val mHeaderImg = holder?.getView<RoundImageView>(R.id.item_copy_order_header_img)
        val mUserName = holder?.getView<TextView>(R.id.item_copy_order_name)
        val mTenOrder = holder?.getView<TextView>(R.id.item_copy_order_ten_order)
        val mTenOrderWin = holder?.getView<TextView>(R.id.item_copy_order_ten_order_two)
        val mOrderRate = holder?.getView<TextView>(R.id.item_copy_order_rate)
        val mEndTime = holder?.getView<TextView>(R.id.item_copy_order_end_time)
        val mBuyMoney = holder?.getView<TextView>(R.id.item_copy_order_buy_money)
        val mCopyPersonNumber = holder?.getView<TextView>(R.id.item_copy_order_person)
        val mCopyOrder = holder?.getView<TextView>(R.id.item_copy_order_commit)


        val lp = RelativeLayout.LayoutParams(mHeaderRoot!!.layoutParams)
        lp.setMargins(0, 0, 0, 0)
        mHeaderRoot.layoutParams = lp


        ImageLoaderUtil.displayHeadImg(item!!.userAvatar, mHeaderImg)
        mUserName?.text = item.userName
        mTenOrder?.text = "近${item.weekStatisticsBean.number}单"
        mTenOrderWin?.text = "${item.weekStatisticsBean.number}中${item.weekStatisticsBean.winNumber}"
        mOrderRate?.text = "${item.rate}倍"
        mBuyMoney?.text = Html.fromHtml("自购 <font color='#EB656D'>${item.totalMoney}</font>元")
        mCopyPersonNumber?.text = Html.fromHtml("跟单 <font color='#EB656D'>${item.follow}</font>人")
        mEndTime?.text = "截止: " + TimeUtil.getFormatTime(item.endTime, "MM-dd HH:mm")

        mHeaderRoot?.setOnClickListener {
            val intent = Intent(context,CopyOrderDetailActivity::class.java)
            intent.putExtra("orderId",item.orderId)
            context.startActivity(intent)

        }

    }

}