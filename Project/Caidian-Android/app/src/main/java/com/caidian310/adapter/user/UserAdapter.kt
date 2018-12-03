package com.caidian310.adapter.user

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import java.util.*


/**
 * 用户中心
 * Created by mac on 2017/11/17.
 */


class UserAdapter(var context: Context, var mapList: ArrayList<HashMap<String, Any>>,var boolean: Boolean = false) : BaseAdapter() {


    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.layout_user_list_view, null)
            holder = ViewHolder()
            holder.content = con!!.findViewById(R.id.layout_item_content)
            holder.backLine = con.findViewById(R.id.layout_item_black_line)
            holder.img = con.findViewById(R.id.layout_item_img)
            con.tag = holder

        } else {
            holder = con.tag as ViewHolder
        }

        if (boolean) holder.img?.visibility = View.VISIBLE
        holder.content?.text = mapList[position]["txt"] as String

        holder.backLine?.visibility = if (position == 2) View.VISIBLE else View.GONE


        return con
    }


    override fun getItem(position: Int): Int = mapList.size

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = mapList.size


    /**存放控件*/
    class ViewHolder {
        var content: TextView? = null
        var backLine: TextView? = null
        var state: TextView? = null
        var img: ImageView? = null
    }

}
