package com.caidian310.adapter.football

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.adapter.base.BaseFootballAdapter
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.utils.TimeUtil


/**
 * 竞彩足球-> 进球数
 * Created by mac on 2017/11/17.
 */
class FootballJqsAdapter( context: Activity,  map: LinkedHashMap<String, ArrayList<FootballBean>>) : BaseFootballAdapter(context ,map) {


    init {
        betType = BetTypeEnum.jqs.key
        playEnum = PlayIdEnum.jqs
    }


    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_spf_row, null)
            holder.one = convertView!!.findViewById(R.id.row_one)
            holder.two = convertView.findViewById(R.id.row_two)
            holder.three = convertView.findViewById(R.id.row_three)
            holder.four = convertView.findViewById(R.id.row_four)
            holder.single = convertView.findViewById(R.id.row_single)
            holder.letOne = convertView.findViewById(R.id.row_let_one)
            holder.letTwo = convertView.findViewById(R.id.row_let_two)
            holder.letThree = convertView.findViewById(R.id.row_let_three)
            holder.letFour = convertView.findViewById(R.id.row_let_four)
            holder.home = convertView.findViewById(R.id.foot_item_row_home)
            holder.away = convertView.findViewById(R.id.foot_item_row_away)
            holder.draw = convertView.findViewById(R.id.row_draw_draw)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            holder.fixedLinear = convertView.findViewById(R.id.row_bqc_linear)
            holder.fixedLinear = convertView.findViewById(R.id.row_bqc_linear)
            holder.fixed = convertView.findViewById(R.id.row_bqc_fixed)
            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }


        val bean = map[list[groupPosition]]?.get(childPosition)

        //单关
        holder.single?.visibility = View.GONE
        holder.draw?.visibility = View.GONE

        val jqs_sp0 = bean!!.jczqBeanList[BetTypeEnum.jqs_sp0.listIndex]
        val jqs_sp1 = bean.jczqBeanList[BetTypeEnum.jqs_sp1.listIndex]
        val jqs_sp2 = bean.jczqBeanList[BetTypeEnum.jqs_sp2.listIndex]
        val jqs_sp3 = bean.jczqBeanList[BetTypeEnum.jqs_sp3.listIndex]
        val jqs_sp4 = bean.jczqBeanList[BetTypeEnum.jqs_sp4.listIndex]
        val jqs_sp5 = bean.jczqBeanList[BetTypeEnum.jqs_sp5.listIndex]
        val jqs_sp6 = bean.jczqBeanList[BetTypeEnum.jqs_sp6.listIndex]
        val jqs_sp7 = bean.jczqBeanList[BetTypeEnum.jqs_sp7.listIndex]

        // 是否开售
        run {
            holder.fixed?.visibility = if (bean.jqsFixed==0) View.VISIBLE else View.GONE
            holder.fixedLinear?.visibility = if (bean.jqsFixed==0) View.GONE else View.VISIBLE
        }


        /**
         *控件样式
         */
        run {
           setTwoLineTextViewStyle(textView = holder.one!!, betBean = jqs_sp0, edgeBoolean = true)
           setTwoLineTextViewStyle(textView = holder.two!!, betBean = jqs_sp1, edgeBoolean = true)
           setTwoLineTextViewStyle(textView = holder.three!!, betBean = jqs_sp2, edgeBoolean = true)
           setTwoLineTextViewStyle(textView = holder.four!!, betBean = jqs_sp3, edgeBoolean = true)
           setTwoLineTextViewStyle(textView = holder.letOne!!, betBean = jqs_sp4)
           setTwoLineTextViewStyle(textView = holder.letTwo!!, betBean = jqs_sp5)
           setTwoLineTextViewStyle(textView = holder.letThree!!, betBean = jqs_sp6)
           setTwoLineTextViewStyle(textView = holder.letFour!!, betBean = jqs_sp7)
        }


        /**
         * 点击事件
         */
        run {

            holder.one?.setOnClickListener { onClickItem(textView = holder.one!!, footballBean = bean, betBean = jqs_sp0, edgeBoolean = true) }
            holder.two?.setOnClickListener { onClickItem(textView = holder.two!!, footballBean = bean, betBean = jqs_sp1, edgeBoolean = true) }
            holder.three?.setOnClickListener { onClickItem(textView = holder.three!!, footballBean = bean, betBean = jqs_sp2, edgeBoolean = true) }
            holder.four?.setOnClickListener { onClickItem(textView = holder.four!!, footballBean = bean, betBean = jqs_sp3, edgeBoolean = true) }
            holder.letOne?.setOnClickListener { onClickItem(textView = holder.letOne!!, footballBean = bean, betBean = jqs_sp4) }
            holder.letTwo?.setOnClickListener { onClickItem(textView = holder.letTwo!!, footballBean = bean, betBean = jqs_sp5) }
            holder.letThree?.setOnClickListener { onClickItem(textView = holder.letThree!!, footballBean = bean, betBean = jqs_sp6) }
            holder.letFour?.setOnClickListener { onClickItem(textView = holder.letFour!!, footballBean = bean, betBean = jqs_sp7) }
        }


        /**
         * 初始化参数
         */
        run {
            holder.time?.text = TimeUtil.getFormatTime(bean.saleEndTime, "HH:mm") + """ 截止"""
            holder.leagueName?.text = bean.leagueName
            holder.leagueName?.setTextColor(Color.parseColor(bean.color))
            holder.week?.text = bean.serial

            holder.home?.text = bean.home3
            holder.away?.text = bean.away3
        }



        return convertView
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
        var single: ImageView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null
        var fixed: TextView? = null
        var fixedLinear: LinearLayout? = null
    }


}


