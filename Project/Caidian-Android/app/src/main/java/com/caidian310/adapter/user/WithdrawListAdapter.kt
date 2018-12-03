package com.caidian310.adapter.user

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.buy.PayBean
import com.caidian310.bean.enumBean.TradeIdEnum
import com.caidian310.bean.enumBean.WinStatueEnum
import com.caidian310.bean.enumBean.WithdrawEnum
import com.caidian310.bean.user.WithdrawBean
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil
import com.google.gson.Gson


/**
 * 提现列表
 * Created by mac on 2017/11/17.
 */


class WithdrawListAdapter(var context: Context, var withdrawList: ArrayList<WithdrawBean>) : BaseAdapter() {


    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.item_user_withdraw_list, null)
            holder = ViewHolder()
            holder.number = con!!.findViewById(R.id.item_withdraw_num)
            holder.money = con.findViewById(R.id.item_withdraw_money)
            holder.content = con.findViewById(R.id.item_withdraw_content)
            holder.statue = con.findViewById(R.id.item_withdraw_statue)
            holder.time = con.findViewById(R.id.item_withdraw_time)
            con.tag = holder

        } else {
            holder = con.tag as ViewHolder
        }


        val bean = withdrawList[position]

        holder.number?.text = "订单号: "+bean.codeNumber
        holder.time?.text = TimeUtil.getFormatTime(bean.createTime,TimeUtil.timeFormat)
        holder.money?.text = bean.money
        holder.statue?.text = WithdrawEnum.WithdrawIng.getWithdrawEnumFromId(bean.status).message
        holder.content?.text = bean.remark

        holder.statue?.setTextColor(ColorUtil.getColor(if (bean.status== WithdrawEnum.WithdrawSuccess.id) R.color.blue else R.color.colorPrimaryDark ))



        return con
    }



    override fun getItem(position: Int): Int = withdrawList.size

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = withdrawList.size


    /**存放控件*/
    class ViewHolder {
        var number :TextView ?=null
        var time: TextView? = null
        var content: TextView? = null
        var money: TextView? = null
        var statue: TextView? = null
    }

}
