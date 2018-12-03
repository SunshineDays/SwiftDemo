package com.caidian310.adapter.basketball


import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.sport.football.BaseBasketballAdapter
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.TimeUtil


/**
 * icon_types_jclq-> 让分胜负
 * Created by mac on 2017/11/17.
 */
class BasketballRfsfAdapter( context: Activity,  map: HashMap<String, ArrayList<BasketballBean>>) : BaseBasketballAdapter(context,map) {




    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View? {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.bask_item_sf, null)
            holder.chose = convertView!!.findViewById(R.id.row_chose)
            holder.home = convertView.findViewById(R.id.item_bask_sf_home)
            holder.away = convertView.findViewById(R.id.item_bask_sf_away)

            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)

            holder.homeLast = convertView.findViewById(R.id.item_bask_sf_away_win)
            holder.homeWin = convertView.findViewById(R.id.item_bask_sf_home_win)

            holder.fixedTxt = convertView.findViewById(R.id.item_bask_sf_fixed)

            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)



        //单关
        if (bean!!.rfsfFixed ==0){
            holder.fixedTxt!!.visibility = View.VISIBLE
            holder.homeLast!!.visibility = View.GONE
            holder.homeWin!!.visibility = View.GONE
        }
        else{
            holder.fixedTxt!!.visibility = View.GONE
            holder.homeLast!!.visibility = View.VISIBLE
            holder.homeWin!!.visibility = View.VISIBLE
        }


        /**
         * 初始化控件样式
         */

        fun openTextViewStyle(){
            openBackGround(view = holder.homeLast!!,betBean = bean!!.rfsfSp0,edgeLeftBoolean = true)
            openBackGround(view = holder.homeWin!!,betBean = bean.rfsfSp3)

            setTwoLineTextColorString(view = holder.homeLast!!,betBean = bean.rfsfSp0)
            setTwoLineTextColorString(view = holder.homeWin!!,betBean = bean.rfsfSp3,letBall = bean.letBall)
        }

        openTextViewStyle()

        /**
         * 处理点击事件
         */

        run {
            holder.homeLast!!.setOnClickListener {
                setOnItemClick(view = holder.homeLast!!,match = bean!!.getMatchBean(),betBean = bean.rfsfSp0,edgeBoolean = true)}
            holder.homeWin!!.setOnClickListener {
                setOnItemClick(view = holder.homeWin!!,match = bean!!.getMatchBean(),betBean = bean.rfsfSp3,letBall = bean.letBall)}
        }



        /**
         * 初始化控件参数
         */

        run {

            holder.away!!.text = bean.away3
            holder.home!!.text = bean.home3

            holder.time?.text = TimeUtil.getFormatTime(bean.matchTime, "HH:mm") + """ 截止"""
            holder.leagueName?.text = bean.leagueName
            holder.leagueName?.setTextColor(Color.parseColor(bean.color))
            holder.week?.text = bean.serial
        }
        return convertView
    }


    /**
     * 控件点击事件
     * @param edgeBoolean 是否带左边框
     */
    private fun setOnItemClick(view: TextView, match: Match, betBean: BetBean, edgeBoolean: Boolean = false, letBall: Double? = null) {
        changeViewBackGround(view, betBean, edgeBoolean)
        FootBallPresenter.addJczq(match = match,jczq = betBean,choseMap = choseMap)
        setTwoLineTextColorString(view = view,betBean = betBean,letBall = letBall)
        callAdapterBack?.onClickListener()

    }



    class ViewHolder {
        var chose: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null

        var homeLast :TextView? = null
        var homeWin:TextView ?= null


        var fixedTxt :TextView ?= null


    }


}


