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
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil

/**
 * 竞彩足球-> 混合/胜平负
 * Created by mac on 2017/11/17.
 */
class FootballSpfAdapter(context: Activity, map: LinkedHashMap<String, ArrayList<FootballBean>>) : BaseFootballAdapter(context, map) {


    init {
        betType = BetTypeEnum.spf.key
        playEnum = PlayIdEnum.spf
    }

    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_row, null)
            holder.win = convertView.findViewById(R.id.row_win)
            holder.draw = convertView.findViewById(R.id.row_draw)
            holder.lost = convertView.findViewById(R.id.row_lost)
            holder.letWin = convertView.findViewById(R.id.row_let_win)
            holder.letDraw = convertView.findViewById(R.id.row_let_draw)
            holder.letLost = convertView.findViewById(R.id.row_let_lost)
            holder.homeName = convertView.findViewById(R.id.foot_item_row_home)
            holder.awayName = convertView.findViewById(R.id.foot_item_row_away)
            holder.single = convertView.findViewById(R.id.row_single)
            holder.letText = convertView.findViewById(R.id.row_let_txt)
            holder.noLetText = convertView.findViewById(R.id.no_let_txt)
            holder.linear = convertView.findViewById(R.id.row_let_linear)
            holder.letLinear = convertView.findViewById(R.id.row_no_let_linear)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            holder.spfFixed = convertView.findViewById(R.id.row_spf_fixed)
            holder.rqSpfFixed = convertView.findViewById(R.id.row_rqspf_fixed)

            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }


        //单关
        holder.single?.visibility = View.GONE
        val bean = map[list[groupPosition]]?.get(childPosition)

        //胜平负单关未开
        if (bean!!.spfFixed == 0) {
            holder.spfFixed?.visibility = View.VISIBLE
            holder.win!!.visibility = View.GONE
            holder.draw!!.visibility = View.GONE
            holder.lost!!.visibility = View.GONE

        } else {
            holder.spfFixed?.visibility = View.GONE
            holder.win!!.visibility = View.VISIBLE
            holder.draw!!.visibility = View.VISIBLE
            holder.lost!!.visibility = View.VISIBLE
        }

        //让球胜平负单关未开
        if (bean.rqspfFixed == 0) {
            holder.rqSpfFixed?.visibility = View.VISIBLE
            holder.letWin!!.visibility = View.GONE
            holder.letDraw!!.visibility = View.GONE
            holder.letLost!!.visibility = View.GONE
        } else {
            holder.rqSpfFixed?.visibility = View.GONE
            holder.letWin!!.visibility = View.VISIBLE
            holder.letDraw!!.visibility = View.VISIBLE
            holder.letLost!!.visibility = View.VISIBLE
        }


        val spf_sp3 = bean.jczqBeanList[BetTypeEnum.spf_sp3.listIndex]
        val spf_sp1 = bean.jczqBeanList[BetTypeEnum.spf_sp1.listIndex]
        val spf_sp0 = bean.jczqBeanList[BetTypeEnum.spf_sp0.listIndex]
        val rqspf_sp3 = bean.jczqBeanList[BetTypeEnum.rqspf_sp3.listIndex]
        val rqspf_sp1 = bean.jczqBeanList[BetTypeEnum.rqspf_sp1.listIndex]
        val rqspf_sp0 = bean.jczqBeanList[BetTypeEnum.rqspf_sp0.listIndex]


        /**
         * 显示样式
         */
        run {
            setOpenTextViewBg(textView = holder.win!!, betBean = spf_sp3, edgeBoolean = true)
            setOpenTextViewBg(textView = holder.draw!!, betBean = spf_sp1, edgeBoolean = true)
            setOpenTextViewBg(textView = holder.lost!!, betBean = spf_sp0, edgeBoolean = true)
            setOpenTextViewBg(textView = holder.letWin!!, betBean = rqspf_sp3)
            setOpenTextViewBg(textView = holder.letDraw!!, betBean = rqspf_sp1)
            setOpenTextViewBg(textView = holder.letLost!!, betBean = rqspf_sp0)
        }


        /**
         * 点击事件
         */
        run {
            holder.win?.setOnClickListener { setOnItemClick(textView = holder.win!!, betBean = spf_sp3, footballBean = bean, edgeBoolean = true) }
            holder.draw?.setOnClickListener { setOnItemClick(textView = holder.draw!!, betBean = spf_sp1, footballBean = bean, edgeBoolean = true) }
            holder.lost?.setOnClickListener { setOnItemClick(textView = holder.lost!!, betBean = spf_sp0, footballBean = bean, edgeBoolean = true) }
            holder.letWin?.setOnClickListener { setOnItemClick(textView = holder.letWin!!, betBean = rqspf_sp3, footballBean = bean) }
            holder.letDraw?.setOnClickListener { setOnItemClick(textView = holder.letDraw!!, betBean = rqspf_sp1, footballBean = bean) }
            holder.letLost?.setOnClickListener { setOnItemClick(textView = holder.letLost!!, betBean = rqspf_sp0, footballBean = bean) }
        }


        run {
            // 是否显示单关框
            showSingleStyle(bean.spfSingle, holder.linear!!)
            showSingleStyle(bean.rqspfSingle, holder.letLinear!!)

            //让球非让球样式
            holder.noLetText?.setBackgroundColor(if (bean.letBall > 0) ColorUtil.getColor(R.color.homeWin) else ColorUtil.getColor(R.color.blue62AFFE))

            //单关图标
            if (bean.spfSingle == 1 || bean.rqspfSingle == 1) holder.single?.visibility = View.VISIBLE

        }


        run {

            holder.noLetText?.text = if (bean.letBall > 0) "+${bean.letBall.toInt()}" else "${bean.letBall.toInt()}"
            holder.time?.text = TimeUtil.getFormatTime(bean.saleEndTime, "HH:mm") + """ 截止"""
            holder.leagueName?.text = bean.leagueName
            holder.leagueName?.setTextColor(Color.parseColor(bean.color))
            holder.week?.text = bean.serial
            holder.win?.text = spf_sp3.jianChen + spf_sp3.sp
            holder.draw?.text = spf_sp1.jianChen + spf_sp1.sp
            holder.lost?.text = spf_sp0.jianChen + spf_sp0.sp

            holder.letWin?.text = rqspf_sp3.jianChen + rqspf_sp3.sp
            holder.letDraw?.text = rqspf_sp1.jianChen + rqspf_sp1.sp
            holder.letLost?.text = rqspf_sp0.jianChen + rqspf_sp0.sp

            holder.homeName?.text = bean.home3
            holder.awayName?.text = bean.away3
        }

        return convertView!!
    }



    /**
     * 点击事件处理
     * @param textView 点击的选项
     * @param betBean 场次里面的某项
     * @param footballBean 本场次标记
     * @param edgeBoolean 边框样式
     */

    private fun setOnItemClick(textView: TextView, betBean: BetBean, footballBean: FootballBean, edgeBoolean: Boolean = false) {
        setClickTextViewBackGround(textView = textView, betBean = betBean, edgeBoolean = edgeBoolean)
        betUtil.addBetBean(match = footballBean.getMatchBean(), betBean = betBean, choseMap = choseMap)
        callFootballBeanBack?.callObjectBack(type = BetTypeEnum.spf.key, footballBean = footballBean, map = choseMap)
    }


    class ViewHolder {
        var win: TextView? = null
        var draw: TextView? = null
        var lost: TextView? = null
        var letWin: TextView? = null
        var letDraw: TextView? = null
        var letLost: TextView? = null
        var homeName: TextView? = null
        var awayName: TextView? = null
        var spfFixed: TextView? = null
        var rqSpfFixed: TextView? = null
        var noLetText: TextView? = null
        var letText: TextView? = null
        var single: ImageView? = null
        var linear: LinearLayout? = null
        var letLinear: LinearLayout? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null

    }


}


