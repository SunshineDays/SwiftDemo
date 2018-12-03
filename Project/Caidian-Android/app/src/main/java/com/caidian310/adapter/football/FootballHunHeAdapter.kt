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
import com.caidian310.utils.BetUtil
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.callBack.CallChoseListBack
import com.caidian310.view.popupWindow.footBall.FootBallBfWindow
import com.caidian310.view.popupWindow.footBall.FootBallHunHeWindow


/**
 * 竞彩足球-> 比分
 * Created by mac on 2017/11/17.
 */
class FootballHunHeAdapter(context: Activity, map: LinkedHashMap<String, ArrayList<FootballBean>>) : BaseFootballAdapter(context, map) {

    var popWindow: FootBallHunHeWindow? = null

    init {
        betType = BetTypeEnum.hunhe.key
        playEnum = PlayIdEnum.hunhe
        popWindow = FootBallHunHeWindow(context = context, choseMap = choseMap)

    }

    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_hun, null)
            holder.chose = convertView!!.findViewById(R.id.row_chose)
            holder.home = convertView.findViewById(R.id.foot_item_row_home)
            holder.away = convertView.findViewById(R.id.foot_item_row_away)

            holder.win = convertView.findViewById(R.id.row_win)
            holder.draw = convertView.findViewById(R.id.row_draw)
            holder.lost = convertView.findViewById(R.id.row_lost)
            holder.letWin = convertView.findViewById(R.id.row_let_win)
            holder.letDraw = convertView.findViewById(R.id.row_let_draw)
            holder.letLost = convertView.findViewById(R.id.row_let_lost)
            holder.letText = convertView.findViewById(R.id.row_let_txt)
            holder.noLetText = convertView.findViewById(R.id.row_no_let_txt)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            holder.rowSingle = convertView.findViewById(R.id.row_single)
            holder.spfFixed = convertView.findViewById(R.id.row_spf_fixed)
            holder.rqSpfFixed = convertView.findViewById(R.id.row_rqspf_fixed)
            holder.linear = convertView.findViewById(R.id.row_let_linear)

            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)

        holder.rowSingle?.visibility = View.GONE

        val spf_sp3 = bean!!.jczqBeanList[BetTypeEnum.spf_sp3.listIndex]
        val spf_sp1 = bean.jczqBeanList[BetTypeEnum.spf_sp1.listIndex]
        val spf_sp0 = bean.jczqBeanList[BetTypeEnum.spf_sp0.listIndex]
        val rqspf_sp3 = bean.jczqBeanList[BetTypeEnum.rqspf_sp3.listIndex]
        val rqspf_sp1 = bean.jczqBeanList[BetTypeEnum.rqspf_sp1.listIndex]
        val rqspf_sp0 = bean.jczqBeanList[BetTypeEnum.rqspf_sp0.listIndex]


        //胜平负单关未开
        if (bean.spfFixed == 0) {
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

        //单关图标
        if (bean.spfSingle == 1) holder.rowSingle?.visibility = View.VISIBLE else View.GONE
        // 是否显示单关框
        showSingleStyle(bean.spfSingle, holder.linear!!)


        /**
         * 初始化参数
         */


        holder.home?.text = bean.home3
        holder.away?.text = bean.away3

        when {
            bean.letBall > 0 -> {
                holder.letText?.text = "+${bean.letBall.toInt()}"
                holder.letText?.setBackgroundColor(ColorUtil.getColor(R.color.homeWin))
            }
            else -> {
                holder.letText?.text = "${bean.letBall.toInt()}"
                holder.letText?.setBackgroundColor(ColorUtil.getColor(R.color.blue62AFFE))
            }
        }

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




        /**
         * 初始化背景
         */
        fun setTextBg() {

            setOpenViewBg(textView = holder.win!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp3.listIndex], edgeBoolean = true)
            setOpenViewBg(textView = holder.draw!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp1.listIndex], edgeBoolean = true)
            setOpenViewBg(textView = holder.lost!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp0.listIndex], edgeBoolean = true)
            setOpenViewBg(textView = holder.letWin!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp3.listIndex], edgeBoolean = false)
            setOpenViewBg(textView = holder.letDraw!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp1.listIndex], edgeBoolean = false)
            setOpenViewBg(textView = holder.letLost!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp0.listIndex], edgeBoolean = false)
        }

        setTextBg()
        setChoseText(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size ?: 0)



        /**
         * 点击事件处理
         * @param textView 点击的选项
         * @param betBean 场次里面的某项
         * @param edgeBoolean 边框样式
         */

        fun setOnClick(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {

            setClickTextViewBackGround(textView = textView, betBean = betBean, edgeBoolean = edgeBoolean)
            setOneLineTextColorString(view = textView, betBean = betBean)
            betUtil.addBetBean(match = bean.getMatchBean(), betBean = betBean, choseMap = choseMap)
            setChoseText(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                    ?: 0)
            callFootballBeanBack?.callObjectBack(type = betType, footballBean = bean, map = choseMap)
        }

        holder.win?.setOnClickListener { setOnClick(textView = holder.win!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp3.listIndex], edgeBoolean = true) }
        holder.draw?.setOnClickListener { setOnClick(textView = holder.draw!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp1.listIndex], edgeBoolean = true) }
        holder.lost?.setOnClickListener { setOnClick(textView = holder.lost!!, betBean = bean.jczqBeanList[BetTypeEnum.spf_sp0.listIndex], edgeBoolean = true) }
        holder.letWin?.setOnClickListener { setOnClick(textView = holder.letWin!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp3.listIndex]) }
        holder.letDraw?.setOnClickListener { setOnClick(textView = holder.letDraw!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp1.listIndex]) }
        holder.letLost?.setOnClickListener { setOnClick(textView = holder.letLost!!, betBean = bean.jczqBeanList[BetTypeEnum.rqspf_sp0.listIndex]) }

        holder.chose?.setOnClickListener {
            /**
             * 防止多点触控
             */
            if (popWindow?.clickTxt != holder.chose) {
                popWindow?.dismiss()
            }
            popWindow?.showPopupWindow(
                    match = bean.getMatchBean(),
                    textView = holder.chose!!,
                    list = bean.jczqBeanList
            )
            popWindow?.setCallBack(object : CallChoseListBack {
                override fun onClickListener(list: ArrayList<BetBean>, choseList: ArrayList<BetBean>) {

                    bean.jczqBeanList.clear()
                    var count = 0
                    // 获取已选择的个数和保存
                    list.forEach {
                        if (it.status) count++
                        bean.jczqBeanList.add(BetUtil().copyJczq(bean = it))
                    }

                    choseList.forEach { betUtil.addBetBean(match = bean.getMatchBean(), betBean = it, choseMap = choseMap) }

                    setChoseText(textView = holder.chose!!, count = count)
                    setTextBg()
                    callFootballBeanBack?.callObjectBack(type = betType, footballBean = bean, map = choseMap)
                }
            })
        }


        return convertView
    }


    fun setOpenViewBg(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {
        setOpenTextViewBg(textView = textView, betBean = betBean, edgeBoolean = edgeBoolean)
        setOneLineTextColorString(view = textView, betBean = betBean)
    }

    /**
     * 显示选择了几项
     * @param textView 控件
     * @param count 已经选择的个数
     */

    fun setChoseText(textView: TextView, count: Int = 0) {
        textView.text = "已\n选\n $count\n项"
        textView.setBackgroundResource(if (count == 0) R.drawable.edge_top_right_bottom else R.drawable.select_item)
        textView.setTextColor(ColorUtil.getColor(if (count == 0) R.color.grayThree else R.color.white))
    }


    class ViewHolder {
        var chose: TextView? = null
        var win: TextView? = null
        var draw: TextView? = null
        var lost: TextView? = null
        var letWin: TextView? = null
        var letDraw: TextView? = null
        var letLost: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var noLetText: TextView? = null
        var letText: TextView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null
        var rowSingle: ImageView? = null
        var spfFixed: TextView? = null
        var rqSpfFixed: TextView? = null
        var linear: LinearLayout? = null

    }


}


