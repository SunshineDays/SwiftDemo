package com.caidian310.adapter.football.bet

import android.content.Context
import android.view.LayoutInflater

import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.caidian310.R
import com.caidian310.R.id.textView
import com.caidian310.utils.ColorUtil
import com.caidian310.view.callBack.CallPositionListBack


/**
 * 竞彩足球-> 投注选项显示
 * Created by mac on 2017/11/17.
 */


class BetGridViewAdapter(var context: Context, var list: ArrayList<Int>) : BaseAdapter() {

    var clickPosition = -1        //记录点击得位置(此处是几串1 的几)
    var clickAddOrRemove = true   //移除串关方式还是添加
    var chosePositionList: ArrayList<Int> = ArrayList() //保存已选的选项
    private var callPositionListBack: CallPositionListBack? = null  //回调函数

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.foot_item_bet_grid_view, null)
            holder = ViewHolder()
            holder.content = con!!.findViewById(R.id.item_bet_count)
            con.tag = holder

        } else {
            holder = con.tag as ViewHolder
        }


        holder.content?.text = if (list[position] == 1) "单关" else "${list[position]}串1"
        holder.content?.setBackgroundResource(R.drawable.angle_all_bian_gray)
        holder.content?.setTextColor(ColorUtil.getColor(R.color.graySix))
        holder.content?.setOnClickListener { setOnClick(position = position, textView = holder.content!!) }


        if (chosePositionList.contains(list[position])){

            holder.content?.setBackgroundResource(R.drawable.angle_all_bian_red)
            holder.content?.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))

        }else{
            holder.content?.setBackgroundResource(R.drawable.angle_all_bian_gray)
            holder.content?.setTextColor(ColorUtil.getColor(R.color.graySix))
        }

        return con
    }

    fun setCallBack(callBack: CallPositionListBack) {
        this.callPositionListBack = callBack
    }

    override fun getItem(position: Int): Int = list[position]

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = list.size


    /**
     * 点击事件
     * @param position 当前的点击位置
     * @param textView 点击得控件
     */
    private fun setOnClick(position: Int, textView: TextView) {

        clickPosition = list[position]    //记录串

        if (chosePositionList.contains(list[position])) {
            chosePositionList.remove(list[position])

            textView.setBackgroundResource(R.drawable.angle_all_bian_gray)
            textView.setTextColor(ColorUtil.getColor(R.color.graySix))

            // 回调当前所有的选中项
            clickAddOrRemove = false
            callPositionListBack?.onClickListener(chosePositionList)
            return
        }

        //记录插入的位置
        var number = chosePositionList.size
        chosePositionList.forEachIndexed { index, i ->
            if (position < i) number = index
        }

        chosePositionList.add(number, list[position])
        textView.setBackgroundResource(R.drawable.angle_all_bian_red)
        textView.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))

        // 回调当前所有的选中项
        clickAddOrRemove = true
        callPositionListBack?.onClickListener(chosePositionList)
        return
    }


    /**存放控件*/
    class ViewHolder {
        var content: TextView? = null
    }


}
