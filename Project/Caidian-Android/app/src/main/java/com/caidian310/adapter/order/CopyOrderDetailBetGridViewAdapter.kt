package com.caidian310.adapter.order

import android.content.Context
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.utils.ColorUtil
import com.caidian310.view.callBack.CallBack


/**
 *  复制跟单再次
 * Created by wdb on 2015/9/9.
 */
class CopyOrderDetailBetGridViewAdapter(var context: Context, list: ArrayList<Int>) : BaseAdapter<Int>(context, list) {

    var choseList : ArrayList<Int> = ArrayList()

    var callBack:CallBack ?=null

    fun setCallBetBack(callBack: CallBack){
        this.callBack =callBack
    }
    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_copy_order_bet
    }

    override fun onBindHolder(holder: BaseViewHolder, item: Int, position: Int) {

        val title = holder.getView<TextView>(R.id.item_text)

        title.text =  "$item 倍"


        /**
         * 设置显示的规则
         */
        title.setTextColor(ColorUtil.getColor(if (choseList.contains(item)) R.color.colorPrimaryDark else R.color.graySix))
        title.setBackgroundResource(if (choseList.contains(item)) R.drawable.angle_all_bian_red else R.drawable.angle_all_bian_gray)



        title.setOnClickListener {
            choseList.clear()
            choseList.add(item)
            callBack?.onClickListener()
            notifyDataSetChanged()
        }

    }






}
