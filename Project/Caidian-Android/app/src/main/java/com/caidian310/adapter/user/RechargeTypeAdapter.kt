package com.caidain310.activity.sport.football

import android.content.Context
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.bean.user.RechargeBean
import com.caidian310.utils.ImageLoaderUtil


/**
 * 充值方式
 * Created by mac on 2017/11/17.
 */


class RechargeTypeAdapter(var context: Context, var payList: ArrayList<RechargeBean>) : BaseAdapter<RechargeBean>(context,payList) {
    override fun onBindHolder(holder: BaseViewHolder?, item: RechargeBean?, position: Int) {

        val statueImg = holder?.getView<ImageView>(R.id.item_recharge_statue)
        val logoImg = holder?.getView<ImageView>(R.id.item_recharge_logo)

        if (item!!.isRecommend ==1){
            statueImg?.setBackgroundResource(R.mipmap.icon_select_press)
        }else{
            statueImg?.setBackgroundResource(R.mipmap.icon_select_normal)
        }


        holder?.getView<TextView>(R.id.item_recharge_title)?.text = item.name?:""
        holder?.getView<TextView>(R.id.item_recharge_comment)?.text = item.description?:""

        ImageLoaderUtil.displayHeadImg(item.logo,logoImg!!)

        holder.getView<RelativeLayout>(R.id.item_recharge_root)?.setOnClickListener {
            payList.forEach { it.isRecommend=0 }
            item.isRecommend = 1
            notifyDataSetChanged()
        }

    }

    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_recharge_layout
    }




}
