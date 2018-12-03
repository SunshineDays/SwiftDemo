package com.caidian310.adapter.football.chose

import android.content.Context
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseAdapter
import com.caidian310.adapter.base.BaseViewHolder
import com.caidian310.utils.ColorUtil


/**
 * 竞彩足球  赛事筛选
 * Created by wdb on 2015/9/9.
 */
class FootballChoseAdapter(val context: Context, var list: ArrayList<String>, var leagueChoseList:ArrayList<String>) : BaseAdapter<String>(context, list) {



    override fun onBindHolder(holder: BaseViewHolder?, item: String, position: Int) {
        val nameTextView = holder?.getView<TextView>(R.id.item_foot_ball_chose_league_name)
        nameTextView?.text = item

        kotlin.run {
            if (leagueChoseList.contains(item)){
                nameTextView?.setBackgroundResource(R.drawable.angle_round_logo_6)
                nameTextView?.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))
            }else{
                nameTextView?.setBackgroundResource(R.drawable.angle_round_gray)
                nameTextView?.setTextColor(ColorUtil.getColor(R.color.graySix))
            }
        }

        nameTextView?.setOnClickListener {


            if (!leagueChoseList.contains(item)){
                nameTextView.setBackgroundResource(R.drawable.angle_round_logo_6)
                nameTextView.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))
                leagueChoseList.add(item)
                return@setOnClickListener
            }
            nameTextView.setBackgroundResource(R.drawable.angle_round_gray)
            nameTextView.setTextColor(ColorUtil.getColor(R.color.graySix))
            leagueChoseList.remove(item)
            return@setOnClickListener


        }

    }

    override fun getItemLayoutId(position: Int): Int {
        return R.layout.item_match_chose_grid_view

    }

}

