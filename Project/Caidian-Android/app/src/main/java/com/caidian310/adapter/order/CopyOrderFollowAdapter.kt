package com.caidian310.adapter.order

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.text.Html
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.user.CopyOrderPerson
import com.caidian310.utils.TimeUtil


/**
 *  复制跟单用户列表
 * Created by wdb on 2015/9/9.
 */
class CopyOrderFollowAdapter(var context: Context, var list: ArrayList<CopyOrderPerson>) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {


    var typeView = 1
    var typeLoading = 2
    var typeEmpty = 3

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            typeLoading -> {
                val loadingView = LayoutInflater.from(parent.context).inflate(R.layout.listview_footer_loading, parent, false)
                FooterViewHolder(loadingView)

            }
            typeView -> {
                val view = LayoutInflater.from(parent.context).inflate(R.layout.item_copy_order_follow, parent, false)
                ViewHolder(view)
            }
            else -> {
                val emptyView = LayoutInflater.from(parent.context).inflate(R.layout.item_empty, parent, false)
                EmptyViewHolder(emptyView)
            }
        }

    }


    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        var name: TextView? = null
        var money: TextView? = null
        var createTime: TextView? = null

        init {

            name = view.findViewById(R.id.follow_name) as TextView
            money = view.findViewById(R.id.follow_money) as TextView
            createTime = view.findViewById(R.id.follow_time) as TextView
        }
    }

    class FooterViewHolder(view: View) : RecyclerView.ViewHolder(view) {}
    class EmptyViewHolder(view: View) : RecyclerView.ViewHolder(view) {}

    override fun getItemCount(): Int {
        return list.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ViewHolder) {
            val bean = list[position]
            holder.name?.text = bean.userName.substring(0, 2) + "******"
            holder.money?.text = Html.fromHtml("<font color='#EB656D'>${bean.totalMoney}</font>元")
            holder.createTime?.text = TimeUtil.getFormatTime(bean.createTime, "MM-dd HH:mm")
        } else {

        }
    }


    override fun getItemViewType(position: Int): Int {
        return when {
            list[position].userId == -1 -> typeLoading
            list[position].userId == -2 -> typeEmpty
            else -> typeView
        }
    }


    var choseList: ArrayList<Int> = ArrayList()


}



