package com.caidian310.adapter.user

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseExpandableListAdapter
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.user.OrderDetailActivity
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.enumBean.WinStatueEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.bean.user.OrderAndBuyBean
import com.caidian310.utils.ColorUtil
import com.caidian310.view.callBack.CallFootballBeanBack

/**
 *
 * 购买列表
 * Created by mac on 2017/11/17.
 */
class BuyListAdapter(var context: Activity, var map: HashMap<String, ArrayList<OrderAndBuyBean>>) : BaseExpandableListAdapter() {


    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
    private var callfootballBeanBack: CallFootballBeanBack? = null

    var list: ArrayList<String> = ArrayList()

    init {
        list = ArrayList(map.keys)
    }


    fun setCallBack(callFootballBeanBack: CallFootballBeanBack) {
        this.callfootballBeanBack = callFootballBeanBack
    }

    override fun getGroup(groupPosition: Int): java.util.ArrayList<OrderAndBuyBean>? =  map[list[groupPosition]]

    override fun isChildSelectable(groupPosition: Int, childPosition: Int): Boolean = true

    override fun hasStableIds(): Boolean = false

    //  获得父项显示的view
    override fun getGroupView(groupPosition: Int, isExpanded: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        if (convertView == null) {
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_header, null)
        }

        val img = convertView!!.findViewById<ImageView>(R.id.foot_item_header_down)
        val count = convertView.findViewById<TextView>(R.id.foot_item_header_count)
        val issue = ArrayList(map.keys)[groupPosition]

        count.text = issue
        img.rotation = if (isExpanded) 180f else 0f
        return convertView
    }


    override fun getChildrenCount(groupPosition: Int): Int = if(map.isEmpty()) 0 else map[list[groupPosition]]!!.size

    override fun getChild(groupPosition: Int, childPosition: Int): Any =
            map[list[groupPosition]]!![childPosition]

    override fun getGroupId(groupPosition: Int): Long = groupPosition.toLong()

    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.item_buy_list, null)
            holder.name = convertView!!.findViewById(R.id.item_buy_list_name)
            holder.content = convertView.findViewById(R.id.item_buy_list_content)
            holder.money = convertView.findViewById(R.id.item_buy_list_money)
            holder.statue = convertView.findViewById(R.id.item_buy_list_statue)
            holder.root = convertView.findViewById(R.id.item_buy_list_root)

            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)

        if (bean!!.order!=null){
            holder.content!!.text = """${bean.buy.buyMoney}元   ${ OrderTypeEnum.Purchasing.getOrderEnumFormId(bean.order.orderType).orderName}"""
            holder.name!!.text =  LotteryIdEnum.jczq.getLotteryEnumFromId(bean.order.lotteryId).lotteryName

            holder.statue?.text = WinStatueEnum.NoStart.getWinStatueEnumFromId(bean.order.winStatus).nameString

            if (bean.order.winStatus==WinStatueEnum.Win.id){
                holder.money?.visibility = View.VISIBLE
                holder.money?.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))
            }else{
                holder.money?.visibility = View.GONE
                holder.money?.setTextColor(ColorUtil.getColor(R.color.graySix))
            }
        }


        holder.money?.text = bean.order.bonus.toString()

        holder.root!!.setOnClickListener {
            val intent = Intent(context,OrderDetailActivity::class.java)
            intent.putExtra("id",bean.buy.id)
            context.startActivity(intent)
        }




        return convertView
    }

    override fun notifyDataSetChanged() {
        list.clear()
        list = ArrayList(map.keys)
        super.notifyDataSetChanged()


    }



    override fun getChildId(groupPosition: Int, childPosition: Int): Long = childPosition.toLong()

    override fun getGroupCount(): Int = list.size

    class ViewHolder {
        var name: TextView? = null
        var content :TextView?=null

        var money: TextView? = null
        var root :RelativeLayout ?= null
        var statue: TextView? = null


    }


}


