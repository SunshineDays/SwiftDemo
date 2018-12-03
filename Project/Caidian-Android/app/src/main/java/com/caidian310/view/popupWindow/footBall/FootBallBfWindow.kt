package com.caidian310.view.popupWindow.footBall

import android.annotation.SuppressLint
import android.app.Activity
import android.graphics.drawable.ColorDrawable
import android.text.Html
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.utils.BetUtil
import com.caidian310.utils.DensityUtil
import com.caidian310.view.callBack.CallChoseListBack
import com.caidian310.view.popupWindow.BasePopupWindow
import android.view.WindowManager
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.ToastUtil.showToast


/**
 * 竞彩足球 比分选择弹出框
 * Created by mac on 2017/11/16.
 */
class FootBallBfWindow() : BasePopupWindow() {

    var view: View? = null
    private var viewShow: View? = null
    var mActivity: Activity? = null
    var match: Match? = null
    var oldList: ArrayList<BetBean> = ArrayList()
    var updatelist: ArrayList<BetBean> = ArrayList()
    var choselist: ArrayList<BetBean> = ArrayList()
    var callBeanBack: CallChoseListBack? = null

    var homeName: TextView? = null
    var awayName: TextView? = null


    var bf_1_0: TextView? = null
    var bf_2_0: TextView? = null
    var bf_2_1: TextView? = null
    var bf_3_0: TextView? = null
    var bf_3_1: TextView? = null
    var bf_3_2: TextView? = null
    var bf_4_0: TextView? = null
    var bf_4_1: TextView? = null
    var bf_4_2: TextView? = null
    var bf_5_0: TextView? = null
    var bf_5_1: TextView? = null
    var bf_5_2: TextView? = null
    var bf_3_other: TextView? = null

    var bf_0_0: TextView? = null
    var bf_1_1: TextView? = null
    var bf_2_2: TextView? = null
    var bf_3_3: TextView? = null
    var bf_1_other: TextView? = null

    var bf_0_1: TextView? = null
    var bf_0_2: TextView? = null
    var bf_1_2: TextView? = null
    var bf_0_3: TextView? = null
    var bf_1_3: TextView? = null
    var bf_2_3: TextView? = null
    var bf_0_4: TextView? = null
    var bf_1_4: TextView? = null
    var bf_2_4: TextView? = null
    var bf_0_5: TextView? = null
    var bf_1_5: TextView? = null
    var bf_2_5: TextView? = null
    var bf_0_other: TextView? = null

    var bf_3_fixed: TextView? = null
    var bf_1_fixed: TextView? = null
    var bf_0_fixed: TextView? = null
    var bf_3_linear: LinearLayout? = null
    var bf_1_linear: LinearLayout? = null
    var bf_0_linear: LinearLayout? = null

    var sure: TextView? = null
    var cancel: TextView? = null
    var clickText: TextView? = null


    // 选中的比比赛
    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()

    constructor(context: Activity, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) : this() {
        view = LayoutInflater.from(context).inflate(R.layout.pop_foot_ball_bf, null)

        this.mActivity = context
        this.choseMap = choseMap

        initView()

        this.viewShow = context.window.decorView
        this.contentView = view // 设置视图
        this.isFocusable = true
        this.height = LinearLayout.LayoutParams.WRAP_CONTENT
        this.width = DensityUtil.getDisplayWidth(context) - 100


        val dw = ColorDrawable(0x00000000)
        this.setBackgroundDrawable(dw)


        this.setOnDismissListener {
            val lp = context.window.attributes
            lp.alpha = 1f
            context.window.attributes = lp
            this.clickText?.isClickable = true

        }


    }

    override fun initView() {
        super.initView()

        homeName = view?.findViewById(R.id.pop_bf_home)
        awayName = view?.findViewById(R.id.pop_bf_away)

        //胜
        bf_1_0 = view?.findViewById(R.id.pop_bf_1_0)
        bf_2_0 = view?.findViewById(R.id.pop_bf_2_0)
        bf_2_1 = view?.findViewById(R.id.pop_bf_2_1)
        bf_3_0 = view?.findViewById(R.id.pop_bf_3_0)
        bf_3_1 = view?.findViewById(R.id.pop_bf_3_1)
        bf_3_2 = view?.findViewById(R.id.pop_bf_3_2)
        bf_4_0 = view?.findViewById(R.id.pop_bf_4_0)
        bf_4_1 = view?.findViewById(R.id.pop_bf_4_1)
        bf_4_2 = view?.findViewById(R.id.pop_bf_4_2)
        bf_5_0 = view?.findViewById(R.id.pop_bf_5_0)
        bf_5_1 = view?.findViewById(R.id.pop_bf_5_1)
        bf_5_2 = view?.findViewById(R.id.pop_bf_5_2)
        bf_3_other = view?.findViewById(R.id.pop_bf_3_other)

        bf_3_fixed = view?.findViewById(R.id.pop_bf_3_fixed)
        bf_1_fixed = view?.findViewById(R.id.pop_bf_1_fixed)
        bf_0_fixed = view?.findViewById(R.id.pop_bf_0_fixed)

        bf_3_linear = view?.findViewById(R.id.pop_bf_3_linear)
        bf_1_linear = view?.findViewById(R.id.pop_bf_1_linear)
        bf_0_linear = view?.findViewById(R.id.pop_bf_0_linear)

        //平
        bf_0_0 = view?.findViewById(R.id.pop_bf_0_0)
        bf_1_1 = view?.findViewById(R.id.pop_bf_1_1)
        bf_2_2 = view?.findViewById(R.id.pop_bf_2_2)
        bf_3_3 = view?.findViewById(R.id.pop_bf_3_3)
        bf_1_other = view?.findViewById(R.id.pop_bf_1_other)

        bf_0_1 = view?.findViewById(R.id.pop_bf_0_1)
        bf_0_2 = view?.findViewById(R.id.pop_bf_0_2)
        bf_1_2 = view?.findViewById(R.id.pop_bf_1_2)
        bf_0_3 = view?.findViewById(R.id.pop_bf_0_3)
        bf_1_3 = view?.findViewById(R.id.pop_bf_1_3)
        bf_2_3 = view?.findViewById(R.id.pop_bf_2_3)
        bf_0_4 = view?.findViewById(R.id.pop_bf_0_4)
        bf_1_4 = view?.findViewById(R.id.pop_bf_1_4)
        bf_2_4 = view?.findViewById(R.id.pop_bf_2_4)
        bf_0_5 = view?.findViewById(R.id.pop_bf_0_5)
        bf_1_5 = view?.findViewById(R.id.pop_bf_1_5)
        bf_2_5 = view?.findViewById(R.id.pop_bf_2_5)

        bf_0_other = view?.findViewById(R.id.pop_bf_0_other)
        sure = view?.findViewById(R.id.pop_bf_sure)
        cancel = view?.findViewById(R.id.pop_bf_cancel)

    }


    @SuppressLint("SetTextI18n")
    private fun initDate(jczqBeanList: ArrayList<BetBean>) {


        homeName?.text = match?.home3
        awayName?.text = match?.away3


        if (match?.bfFixed == 0) {
            bf_3_fixed?.visibility = View.VISIBLE
            bf_1_fixed?.visibility = View.VISIBLE
            bf_0_fixed?.visibility = View.VISIBLE
            bf_3_linear?.visibility = View.GONE
            bf_1_linear?.visibility = View.GONE
            bf_0_linear?.visibility = View.GONE
        } else {
            bf_3_fixed?.visibility = View.GONE
            bf_1_fixed?.visibility = View.GONE
            bf_0_fixed?.visibility = View.GONE
            bf_3_linear?.visibility = View.VISIBLE
            bf_1_linear?.visibility = View.VISIBLE
            bf_0_linear?.visibility = View.VISIBLE
        }



        openPopTextBg(textView = bf_1_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp10.listIndex], edgeBoolean = true)
        openPopTextBg(textView = bf_2_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp20.listIndex], edgeBoolean = true)
        openPopTextBg(textView = bf_2_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp21.listIndex], edgeBoolean = true)
        openPopTextBg(textView = bf_3_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp30.listIndex], edgeBoolean = true)
        openPopTextBg(textView = bf_3_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp31.listIndex], edgeBoolean = true)
        openPopTextBg(textView = bf_3_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp32.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_4_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp40.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_4_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp41.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_4_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp42.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_5_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp50.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_5_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp51.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_5_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp52.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp00.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp11.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_2_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp22.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_3_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp33.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp01.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp02.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp12.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp03.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp13.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_2_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp23.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp04.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp14.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_2_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp24.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp05.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp15.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_2_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp25.listIndex], edgeBoolean = false)

        openPopTextBg(textView = bf_3_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA3.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_1_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA1.listIndex], edgeBoolean = false)
        openPopTextBg(textView = bf_0_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA0.listIndex], edgeBoolean = false)



        bf_1_0?.setOnClickListener { clickItem(textView = bf_1_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp10.listIndex], edgeBoolean = true) }
        bf_2_0?.setOnClickListener { clickItem(textView = bf_2_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp20.listIndex], edgeBoolean = true) }
        bf_2_1?.setOnClickListener { clickItem(textView = bf_2_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp21.listIndex], edgeBoolean = true) }
        bf_3_0?.setOnClickListener { clickItem(textView = bf_3_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp30.listIndex], edgeBoolean = true) }
        bf_3_1?.setOnClickListener { clickItem(textView = bf_3_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp31.listIndex], edgeBoolean = true) }
        bf_3_2?.setOnClickListener { clickItem(textView = bf_3_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp32.listIndex]) }
        bf_4_0?.setOnClickListener { clickItem(textView = bf_4_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp40.listIndex]) }
        bf_4_1?.setOnClickListener { clickItem(textView = bf_4_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp41.listIndex]) }
        bf_4_2?.setOnClickListener { clickItem(textView = bf_4_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp42.listIndex]) }
        bf_5_0?.setOnClickListener { clickItem(textView = bf_5_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp50.listIndex]) }
        bf_5_1?.setOnClickListener { clickItem(textView = bf_5_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp51.listIndex]) }
        bf_5_2?.setOnClickListener { clickItem(textView = bf_5_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp52.listIndex]) }

        bf_0_0?.setOnClickListener { clickItem(textView = bf_0_0!!, jczq = jczqBeanList[BetTypeEnum.bf_sp00.listIndex]) }
        bf_1_1?.setOnClickListener { clickItem(textView = bf_1_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp11.listIndex]) }
        bf_2_2?.setOnClickListener { clickItem(textView = bf_2_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp22.listIndex]) }
        bf_3_3?.setOnClickListener { clickItem(textView = bf_3_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp33.listIndex]) }

        bf_0_1?.setOnClickListener { clickItem(textView = bf_0_1!!, jczq = jczqBeanList[BetTypeEnum.bf_sp01.listIndex]) }
        bf_0_2?.setOnClickListener { clickItem(textView = bf_0_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp02.listIndex]) }
        bf_1_2?.setOnClickListener { clickItem(textView = bf_1_2!!, jczq = jczqBeanList[BetTypeEnum.bf_sp12.listIndex]) }
        bf_0_3?.setOnClickListener { clickItem(textView = bf_0_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp03.listIndex]) }
        bf_1_3?.setOnClickListener { clickItem(textView = bf_1_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp13.listIndex]) }
        bf_2_3?.setOnClickListener { clickItem(textView = bf_2_3!!, jczq = jczqBeanList[BetTypeEnum.bf_sp23.listIndex]) }
        bf_0_4?.setOnClickListener { clickItem(textView = bf_0_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp04.listIndex]) }
        bf_1_4?.setOnClickListener { clickItem(textView = bf_1_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp14.listIndex]) }
        bf_2_4?.setOnClickListener { clickItem(textView = bf_2_4!!, jczq = jczqBeanList[BetTypeEnum.bf_sp24.listIndex]) }
        bf_0_5?.setOnClickListener { clickItem(textView = bf_0_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp05.listIndex]) }
        bf_1_5?.setOnClickListener { clickItem(textView = bf_1_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp15.listIndex]) }
        bf_2_5?.setOnClickListener { clickItem(textView = bf_2_5!!, jczq = jczqBeanList[BetTypeEnum.bf_sp25.listIndex]) }

        bf_3_other?.setOnClickListener { clickItem(textView = bf_3_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA3.listIndex]) }
        bf_1_other?.setOnClickListener { clickItem(textView = bf_1_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA1.listIndex]) }
        bf_0_other?.setOnClickListener { clickItem(textView = bf_0_other!!, jczq = jczqBeanList[BetTypeEnum.bf_spA0.listIndex]) }

        initLinear()
    }


    private fun initLinear() {
        sure?.setOnClickListener {

            callBeanBack?.onClickListener(list = updatelist, choseList = choselist)
            updatelist.clear()
            choselist.clear()

            this.dismiss()

        }
        cancel?.setOnClickListener {
            updatelist.clear()
            choselist.clear()
            oldList.forEach { updatelist.add(BetUtil().copyJczq(it)) }
            this.dismiss()

        }

    }

    private fun clickItem(textView: TextView, jczq: BetBean, edgeBoolean: Boolean = false) {
        jczq.status = !jczq.status
        openPopTextBg(textView = textView, edgeBoolean = edgeBoolean, jczq = jczq)
        if (choselist.contains(jczq)) choselist.remove(jczq)
        else choselist.add(jczq)


    }


    /**
     * 控件打开的颜色
     * @param boolean 颜色状态
     * @param edgeBoolean 边框状态
     */

    private fun openPopTextBg(textView: TextView, edgeBoolean: Boolean, jczq: BetBean) {
        val colorString = if (jczq.status) "#ffffff" else "#333333"
        val testColorString = if (jczq.status) "#ffffff" else "#666666"
        textView.text = Html.fromHtml("<font color='$colorString'>${jczq.jianChen}</font><br/><font color='$testColorString'>${jczq.sp}</font>")
        if (jczq.status) {
            textView.setBackgroundResource(R.drawable.select_item)
        } else {
            textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)

        }

    }


    fun setCallBack(callPositionBack: CallChoseListBack) {
        this.callBeanBack = callPositionBack
    }


    /**
     * 显示popupWindow
     */
    fun showPopupWindow(match: Match, textView: TextView, betBeanList: ArrayList<BetBean>) {
        if (!this.isShowing) {


            this.match = match
            this.clickText = textView

            oldList.addAll(betBeanList)
            updatelist.clear()

            // 接收存储下他的前一个状态
            betBeanList.forEach { updatelist.add(BetUtil().copyJczq(bean = it)) }

            initDate(jczqBeanList = updatelist)


            this.showAtLocation(viewShow, Gravity.CENTER_HORIZONTAL, 0, 0)

            val lp = mActivity!!.window.attributes
            lp.alpha = 0.4f
            mActivity!!.window.attributes = lp

            this.clickText?.isClickable = false
        } else {
            this.dismiss()
        }
    }
}