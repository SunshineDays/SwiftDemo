package com.caidian310.adapter.football

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseFootballAdapter
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.utils.BetUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.callBack.CallChoseListBack
import com.caidian310.view.popupWindow.footBall.FootBallBfWindow
import com.umeng.analytics.pro.be


/**
 * 竞彩足球-> 比分
 * Created by mac on 2017/11/17.
 */
class FootballBfAdapter(context: Activity, map: LinkedHashMap<String, ArrayList<FootballBean>>) : BaseFootballAdapter(context, map) {


    var popWindow :FootBallBfWindow ?=null

    init {
        betType = BetTypeEnum.bf.key
        playEnum = PlayIdEnum.bf
         popWindow = FootBallBfWindow(context = context, choseMap = choseMap)

    }


    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        val holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_bf_row, null)
            holder.chose = convertView!!.findViewById(R.id.foot_item_row_chose)
            holder.home = convertView.findViewById(R.id.foot_item_row_home)
            holder.away = convertView.findViewById(R.id.foot_item_row_away)
            holder.single = convertView.findViewById(R.id.row_single)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)
        setChoseTextString(textView = holder.chose!!, list = bean!!.jczqBeanList)


        holder.single!!.visibility = View.GONE
        holder.home!!.text = bean.home3
        holder.away!!.text = bean.away3
        holder.time?.text = TimeUtil.getFormatTime(bean.saleEndTime.toLong(), "HH:mm") + """ 截止"""
        holder.leagueName?.text = bean.leagueName
        holder.leagueName?.setTextColor(Color.parseColor(bean.color))
        holder.week?.text = bean.serial


        val  callWindowBack :CallChoseListBack = object :CallChoseListBack{
            override fun onClickListener(list: ArrayList<BetBean>, choseList: ArrayList<BetBean>) {

                bean.jczqBeanList.clear()

                /**
                 * 深复制  防止误删除
                 */
                list.forEach {
                    bean.jczqBeanList.add(BetUtil().copyJczq(it))
                }

                //添加筛选项
                choseList.forEach {
                    betUtil.addBetBean(
                            match = bean.getMatchBean(),
                            betBean = it,
                            choseMap = choseMap)
                }

                callFootballBeanBack?.callObjectBack(
                        type = betType,
                        footballBean = bean,
                        map = choseMap
                )

                setChoseTextString(
                        textView = holder.chose!!,
                        list = bean.jczqBeanList
                )

            }
        }


        holder.chose!!.setOnClickListener {
            if (popWindow?.clickText != holder.chose){
                popWindow?.dismiss()
            }

            popWindow?.showPopupWindow(
                    match = bean.getMatchBean(),
                    textView = holder.chose!!,
                    betBeanList = bean.jczqBeanList)

            popWindow?.setCallBack(callWindowBack)
        }




        return convertView
    }


    /**
     * 显示已经选择的文字
     * @param textView 控件
     * @param list 所有选中的项的集合
     */

    fun setChoseTextString(textView: TextView, list: ArrayList<BetBean>) {
        var choseString = ""
        var count = 0
        list.forEach {
            if (it.status) {
                choseString += it.jianChen + " "
                count++
            }
        }
        textView.text = if (count == 0) "点击选择比分投注" else choseString
    }


    class ViewHolder {
        var chose: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var single: ImageView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null


    }


}


