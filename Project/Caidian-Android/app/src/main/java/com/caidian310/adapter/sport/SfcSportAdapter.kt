package com.caidian310.adapter.sport

import android.content.Context
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.bean.sport.MatchBean
import com.caidian310.presenter.TextPresenter
import com.caidian310.utils.TimeUtil


/**
 *
 * Created by mac on 2018/3/6.
 */
class SfcSportAdapter(context: Context, list: ArrayList<MatchBean>) : BaseAdapter<MatchBean>(context, list) {
    override fun getItemLayoutId(position: Int) = R.layout.item_sport_sfc

    override fun onBindHolder(holder: BaseViewHolder?, item: MatchBean?, position: Int) {
        holder!!.getView<TextView>(R.id.row_week).text = item?.xid.toString()
        val leagueName = holder.getView<TextView>(R.id.row_lname)
        leagueName.text = item?.leagueName
        holder.getView<TextView>(R.id.row_time).text = TimeUtil.getFormatTime(item!!.matchTime, "MM-dd HH:mm")
        leagueName.setTextColor(TextPresenter.parseColor(item.color))
        holder.getView<TextView>(R.id.foot_item_row_home).text = item.away3
        holder.getView<TextView>(R.id.foot_item_row_away).text = item.home3


    }
}