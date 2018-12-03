package com.caidian310.adapter

import android.content.Context
import android.content.Intent
import android.support.v4.content.ContextCompat.startActivity
import android.view.Gravity
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.news.NewsDetailActivity
import com.caidian310.adapter.base.BaseAdapter

import com.caidian310.presenter.LotteryPresenter
import com.caidian310.view.callBack.CallBack
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.bean.new.LotteryDetailBean
import com.caidian310.bean.new.NewsItem
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.ImageUtil
import com.caidian310.utils.TimeUtil


/**
 * 首页 listView
 * Created by wdb on 2015/9/9.
 */
class HomeListViewAdapter(var context: Context, var list: ArrayList<NewsItem>) : BaseAdapter<NewsItem>(context, list) {

    private var callBack: CallBack? = null

    fun setCallBack(callBack: CallBack) {
        this.callBack = callBack
    }

    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_news_list_view
    }

    override fun onBindHolder(holder: BaseViewHolder, item: NewsItem, position: Int) {

        val img = holder.getView<ImageView>(R.id.fragment_home_list_view_img)
        val name = holder.getView<TextView>(R.id.fragment_home_list_view_name)
        val content = holder.getView<TextView>(R.id.fragment_home_list_view_content)
//        val time = holder.getView<TextView>(R.id.fragment_home_list_view_time)

        val root = holder.getView<LinearLayout>(R.id.fragment_home_root)

        name.text = item.title
        content.text = item.adminName
        if (item.createTime != 0L) content.text = TimeUtil.getIntelligenceTime(item.createTime, TimeUtil.timeFormat)
        ImageLoaderUtil.displayItemSmall(ImageUtil.imageTailor(item.img, 150, 200), img)


        root.setOnClickListener {
            val intent = Intent(context, NewsDetailActivity::class.java)
            intent.putExtra("newId", item.id)
            context.startActivity(intent)
        }

    }


}
