package com.caidian310.adapter.football

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseFootballAdapter
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.utils.TimeUtil


/**
 * 竞彩足球-> 半全场
 * Created by mac on 2017/11/17.
 */
class FootballBqcAdapter( context: Activity, map: LinkedHashMap<String, ArrayList<FootballBean>>) : BaseFootballAdapter(context,map) {


    init {
        betType = BetTypeEnum.bqc.key
        playEnum = PlayIdEnum.bqc
    }


    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_spf_row, null)

            holder.one = convertView.findViewById(R.id.row_one)
            holder.two = convertView.findViewById(R.id.row_two)
            holder.three = convertView.findViewById(R.id.row_three)
            holder.four = convertView.findViewById(R.id.row_four)

            holder.draw = convertView.findViewById(R.id.row_draw_draw)

            holder.letOne = convertView.findViewById(R.id.row_let_one)
            holder.letTwo = convertView.findViewById(R.id.row_let_two)
            holder.letThree = convertView.findViewById(R.id.row_let_three)
            holder.letFour = convertView.findViewById(R.id.row_let_four)

            holder.home = convertView.findViewById(R.id.foot_item_row_home)
            holder.away = convertView.findViewById(R.id.foot_item_row_away)

            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)

            holder.bqcLinear = convertView.findViewById(R.id.row_bqc_linear)
            holder.bqcFixed = convertView.findViewById(R.id.row_bqc_fixed)

            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }


        val bean = map[list[groupPosition]]?.get(childPosition)
        run {
            holder.bqcFixed?.visibility = if (bean!!.bqcFixed==0) View.VISIBLE else View.GONE
            holder.bqcLinear?.visibility = if (bean.bqcFixed==0) View.GONE else View.VISIBLE

        }

        bean?.let {


            run {
                setTwoLineTextViewStyle(textView = holder.one!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp33.listIndex], edgeBoolean = true)
                setTwoLineTextViewStyle(textView = holder.two!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp31.listIndex], edgeBoolean = true)
                setTwoLineTextViewStyle(textView = holder.three!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp30.listIndex], edgeBoolean = true)
                setTwoLineTextViewStyle(textView = holder.four!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp13.listIndex], edgeBoolean = true)
                setTwoLineTextViewStyle(textView = holder.letOne!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp10.listIndex])
                setTwoLineTextViewStyle(textView = holder.letTwo!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp03.listIndex])
                setTwoLineTextViewStyle(textView = holder.letThree!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp01.listIndex])
                setTwoLineTextViewStyle(textView = holder.letFour!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp00.listIndex])
                setTwoLineTextViewStyle(textView = holder.draw!!, betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp11.listIndex], edgeBoolean = true)
            }


            /**
             * 控件监听
             */
            run {
                holder.draw?.setOnClickListener { onClickItem(textView =  holder.draw!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp11.listIndex],edgeBoolean = true) }
                holder.one?.setOnClickListener { onClickItem(textView =  holder.one!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp33.listIndex],edgeBoolean = true) }
                holder.two?.setOnClickListener { onClickItem(textView =  holder.two!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp31.listIndex],edgeBoolean = true) }
                holder.three?.setOnClickListener { onClickItem(textView =  holder.three!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp30.listIndex],edgeBoolean = true) }
                holder.four?.setOnClickListener { onClickItem(textView =  holder.four!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp13.listIndex],edgeBoolean = true) }
                holder.letOne?.setOnClickListener { onClickItem(textView =  holder.letOne!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp10.listIndex]) }
                holder.letTwo?.setOnClickListener { onClickItem(textView =  holder.letTwo!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp03.listIndex]) }
                holder.letThree?.setOnClickListener { onClickItem(textView =  holder.letThree!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp01.listIndex]) }
                holder.letFour?.setOnClickListener { onClickItem(textView =  holder.letFour!!,footballBean = bean,betBean = bean.jczqBeanList[BetTypeEnum.bqc_sp00.listIndex]) }

            }


            run {
                holder.home?.text = bean.home3
                holder.away?.text = bean.away3
                holder.time?.text = TimeUtil.getFormatTime(bean.saleEndTime.toLong(), "HH:mm") + """ 截止"""
                holder.leagueName?.text = bean.leagueName
                holder.leagueName?.setTextColor(Color.parseColor(bean.color))
                holder.week?.text = bean.serial
            }
        }


        return convertView!!
    }



    class ViewHolder {
        var one: TextView? = null
        var two: TextView? = null
        var three: TextView? = null
        var four: TextView? = null
        var letOne: TextView? = null
        var letTwo: TextView? = null
        var letThree: TextView? = null
        var letFour: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var draw: TextView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null
        var bqcFixed: TextView? = null
        var bqcLinear: LinearLayout? = null

    }


}


