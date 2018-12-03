package com.caidian310.adapter.user

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.caidian310.R
import com.caidian310.activity.user.OrderDetailActivity
import com.caidian310.activity.user.WithdrawListActivity
import com.caidian310.bean.buy.PayBean
import com.caidian310.bean.enumBean.TradeIdEnum
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil


/**
 * 账户明细
 * Created by mac on 2017/11/17.
 */


class PayLogAdapter(var context: Context, var payList: ArrayList<PayBean>) : BaseAdapter() {


    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.item_account_buy, null)
            holder = ViewHolder()
            holder.title = con!!.findViewById(R.id.item_buy_title)
            holder.type = con.findViewById(R.id.item_buy_type)
            holder.money = con.findViewById(R.id.item_buy_money)
            holder.img = con.findViewById(R.id.item_buy_img)
            holder.time = con.findViewById(R.id.item_buy_time)
            holder.linearLayout = con.findViewById(R.id.item_buy_type_root)
            con.tag = holder

        } else {
            holder = con.tag as ViewHolder
        }


        val pay = payList[position]

        holder.title!!.text = "${pay.remark}  ${pay.payCode}"
        holder.type!!.text = pay.tradeName
        holder.time!!.text = TimeUtil.getFormatTime(pay.createTime)

        holder.img!!.visibility = if (TradeIdEnum.addYuFukuan.getCanOpenOrderDetailBoolean(pay.tradeId)) View.VISIBLE else View.INVISIBLE

        when (pay.inOut == 1) {
            true -> {
                holder.money!!.text = "+${pay.payMoney}"
                holder.money!!.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))

            }
            false -> {
                holder.money!!.text = "-${pay.payMoney}"
                holder.money!!.setTextColor(ColorUtil.getColor(R.color.blueHigh))
            }
        }

        //账户明细详情 tradeId = 20||21  用户提款查看 trade_id = 48  27 才可以查看详情
        holder.linearLayout?.setOnClickListener {

            if (!TradeIdEnum.addYuFukuan.getCanOpenOrderDetailBoolean(pay.tradeId)) return@setOnClickListener

            when (pay.tradeId) {
                TradeIdEnum.puTongGouMaiCaipiao.id -> {
                    val intent = Intent(context, OrderDetailActivity::class.java)
                    intent.putExtra("id", pay.resourceId)
                   context.startActivity(intent)
                }
                TradeIdEnum.tikuanFailureMoney.id, TradeIdEnum.yongHuTiKuanZhiChu.id -> {
                    context.startActivity(Intent(context, WithdrawListActivity::class.java))
                }
                else -> {
                }


            }
        }


        return con
    }



    override fun getItem(position: Int): Int = payList.size

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = payList.size


    /**存放控件*/
    class ViewHolder {
        var title: TextView? = null
        var time: TextView? = null
        var type: TextView? = null
        var img: ImageView? = null
        var linearLayout :LinearLayout ?=null
        var money: TextView? = null
    }

}
