package com.caidian310.adapter.order

import android.content.Context
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder


// 计划胆
class PlanOrderListAdapter(var context: Context, list: ArrayList<Int>) : BaseAdapter<Int>(context, list) {
    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_copy_order
    }

    override fun onBindHolder(holder: BaseViewHolder?, item: Int?, position: Int) {

    }

}