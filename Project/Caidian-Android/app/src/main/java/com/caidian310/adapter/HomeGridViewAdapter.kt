package com.caidian310.adapter

import android.content.Context
import android.view.Gravity
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter

import com.caidian310.presenter.LotteryPresenter
import com.caidian310.view.callBack.CallBack
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.bean.new.LotteryDetailBean
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.utils.ColorUtil


/**
 * 首页 GridView
 * Created by wdb on 2015/9/9.
 */
class HomeGridViewAdapter(var context: Context, var list: ArrayList<LotteryDetailBean>) : BaseAdapter<LotteryDetailBean>(context, list) {

    private var callBack: CallBack? = null

    fun setCallBack(callBack: CallBack) {
        this.callBack = callBack
    }

    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_news_lottery
    }

    override fun onBindHolder(holder: BaseViewHolder, item: LotteryDetailBean, position: Int) {


        val root = holder.getView<LinearLayout>(R.id.fragment_home_grid_view_root)
        val img = holder.getView<ImageView>(R.id.fragment_home_grid_view_img)
        val name = holder.getView<TextView>(R.id.fragment_home_grid_view_name)
        val content = holder.getView<TextView>(R.id.fragment_home_grid_view_content)

        //一上线
        if (item.isSale == 0) {
            root.setBackgroundColor(ColorUtil.getColor(R.color.f2f2f2))
            root.isClickable = false
        } else {
            root.setBackgroundColor(ColorUtil.getColor(R.color.white))
            root.isClickable = true
        }

        content.visibility = View.VISIBLE
        content.text = item.description
        name.text = item.lotteryName
        name.gravity = Gravity.BOTTOM
        img.setImageResource(LotteryPresenter.getPlayLogoFromPosition(position))


        root.setOnClickListener {

            val currentPosition = when(position){
                0-> 1
                3-> 2
                4-> 3
                5-> 4
                else-> 0
            }

            println("------"+currentPosition +" position =   "+position)
            StartActivityPresenter.startActivityFromId(context= context,lotteryId = item.lotteryId,currentPosition = currentPosition)


        }

    }


}
