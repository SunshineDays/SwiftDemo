package com.caidian310.adapter.d11

import android.content.Context
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.utils.ColorUtil
import com.caidian310.view.callBack.CallBack


/**
 * d11 头部玩法切换 显示
 * Created by wdb on 2015/9/9.
 */
class D11PlayGridViewAdapter(var context: Context, list: ArrayList<String>,currentPosition:Int) : BaseAdapter<String>(context, list) {

    private var callBack: CallBack? = null
    private var currentPosition :Int =0

    init {
        this.currentPosition = currentPosition
    }

    fun setCallBack(callBack: CallBack) {
        this.callBack = callBack

    }


    override fun getItemLayoutId(position: Int): Int {
        return R.layout.pop_d11_play_title
    }

    override fun onBindHolder(holder: BaseViewHolder, item: String, position: Int) {

        val title = holder.getView<TextView>(R.id.pop_d11_title)
        title.text = item
        title.setBackgroundResource(R.color.white)

        val root = holder.getView<LinearLayout>(R.id.pop_d11_root)
        root.setBackgroundResource(R.color.white)


        /**
         * 设置显示的规则
         */
        title.setTextColor(ColorUtil.getColor(if (position==currentPosition) R.color.red else R.color.grayThree))
        title.setBackgroundResource(if (position == currentPosition) R.drawable.angle_color_text_view_select else R.drawable.angle_color_text_view_normal)


    }

    fun customNotifyDataSetChanged(currentPosition: Int){
        this.currentPosition =currentPosition
        notifyDataSetChanged()
    }




}
