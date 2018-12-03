package com.caidian310.view.popupWindow.basketball

import android.app.Activity
import android.graphics.drawable.ColorDrawable
import android.text.Html
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.baskball.BasketballHelp
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.utils.DensityUtil
import com.caidian310.view.callBack.CallBasketballBeanBack
import com.caidian310.view.popupWindow.BasePopupWindow


/**
 * icon_types_jclq 混合选择弹出框
 * Created by mac on 2017/11/16.
 */
class BasketballHunHeWindow() : BasePopupWindow() {

    var view: View? = null
    private var viewShow: View? = null
    private var mActivity: Activity? = null
    var match: Match? = null

    var oldBasketballBean: BasketballBean? = null

    private var choseList: ArrayList<BetBean> = ArrayList()

    var callBeanBack: CallBasketballBeanBack? = null

    var hun_away_1_5: TextView? = null
    var hun_away_6_10: TextView? = null
    var hun_away_11_15: TextView? = null
    var hun_away_16_20: TextView? = null
    var hun_away_21_25: TextView? = null
    var hun_away_26: TextView? = null
    var hun_home_1_5: TextView? = null
    var hun_home_6_10: TextView? = null
    var hun_home_11_15: TextView? = null
    var hun_home_16_20: TextView? = null
    var hun_home_21_25: TextView? = null
    var hun_home_26: TextView? = null
    var hun_dxf_3: TextView? = null
    var hun_dxf_0: TextView? = null

    var hunSpfFixed: TextView? = null
    var hunSpfLinear: LinearLayout? = null
    var hunRqspfFixed: TextView? = null
    var hunRqspfLinear: LinearLayout? = null

    var hunSfcLinear:LinearLayout ?=null
    var hunSfcFixed :TextView ?=null

    var hunDxfFixed: TextView? = null
    var hunDxfLinear: LinearLayout? = null


    var hun_home_last: TextView? = null
    var hun_home_win: TextView? = null
    var hun_home_let_last: TextView? = null
    var hun_home_let_win: TextView? = null


    var sure: TextView? = null
    var cancel: TextView? = null
    var home: TextView? = null
    var away: TextView? = null

    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()

    var updateBasketballBean: BasketballBean? = null
    var clickTxt:TextView ?=null


    constructor(context: Activity, textView: TextView,choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) : this() {
        view = LayoutInflater.from(context).inflate(R.layout.pop_baeketball_he, null)

        this.mActivity = context
        this.match = match
        this.choseMap = choseMap

        initView()

        this.clickTxt = textView

        this.viewShow = context.window.decorView
        this.contentView = view // 设置视图
        this.isFocusable = true
        this.height = LinearLayout.LayoutParams.WRAP_CONTENT
        this.width = DensityUtil.getDisplayWidth(context) - 100
        this.isFocusable = true

        val dw = ColorDrawable(0x00000000)
        this.setBackgroundDrawable(dw)


        this.setOnDismissListener {
            val lp = context.window.attributes
            lp.alpha = 1f
            context.window.attributes = lp
            this.clickTxt?.isClickable= true
        }


    }

    override fun initView() {
        super.initView()
        home = view?.findViewById(R.id.pop_hun_home)
        away = view?.findViewById(R.id.pop_hun_away)

        hunSpfFixed = view?.findViewById(R.id.pop_spf_fixed)
        hunSpfLinear = view?.findViewById(R.id.pop_spf_linear)

        hunRqspfFixed = view?.findViewById(R.id.pop_rq_spf_fixed)
        hunRqspfLinear = view?.findViewById(R.id.pop_rq_spf_linear)

        hunDxfFixed = view?.findViewById(R.id.pop_dxf_fixed)
        hunDxfLinear = view?.findViewById(R.id.pop_dxf_linear)

        hunSfcFixed = view?.findViewById(R.id.pop_sfc_fixed)
        hunSfcLinear = view?.findViewById(R.id.pop_sfc_linear)

        hun_away_1_5 = view?.findViewById(R.id.pop_hun_away_1_5)
        hun_away_6_10 = view?.findViewById(R.id.pop_hun_away_6_10)
        hun_away_11_15 = view?.findViewById(R.id.pop_hun_away_11_15)
        hun_away_16_20 = view?.findViewById(R.id.pop_hun_away_16_20)
        hun_away_21_25 = view?.findViewById(R.id.pop_hun_away_21_25)
        hun_away_26 = view?.findViewById(R.id.pop_hun_away_26)
        hun_home_1_5 = view?.findViewById(R.id.pop_hun_home_1_5)
        hun_home_6_10 = view?.findViewById(R.id.pop_hun_home_6_10)
        hun_home_11_15 = view?.findViewById(R.id.pop_hun_home_11_15)
        hun_home_16_20 = view?.findViewById(R.id.pop_hun_home_16_20)
        hun_home_21_25 = view?.findViewById(R.id.pop_hun_home_21_25)
        hun_home_26 = view?.findViewById(R.id.pop_hun_home_26)

        hun_dxf_3 = view?.findViewById(R.id.pop_he_big)
        hun_dxf_0 = view?.findViewById(R.id.pop_he_small)


        hun_home_last = view?.findViewById(R.id.pop_home_0)
        hun_home_win = view?.findViewById(R.id.pop_home_3)
        hun_home_let_last = view?.findViewById(R.id.pop_home_let_0)
        hun_home_let_win = view?.findViewById(R.id.pop_home_let_3)


        sure = view?.findViewById(R.id.pop_hun_sure)
        cancel = view?.findViewById(R.id.pop_hun_cancel)


    }


    private fun initLinear(basketballBean: BasketballBean) {
        sure?.setOnClickListener { sureChose() }
        cancel?.setOnClickListener { cancelChose() }


        hun_away_1_5?.setOnClickListener { setOnClickBackGround(textView = hun_away_1_5!!, betBean = basketballBean.sfcSp11, edgeBoolean = true) }
        hun_away_6_10?.setOnClickListener { setOnClickBackGround(textView = hun_away_6_10!!, betBean = basketballBean.sfcSp12, edgeBoolean = true) }
        hun_away_11_15?.setOnClickListener { setOnClickBackGround(textView = hun_away_11_15!!, betBean = basketballBean.sfcSp13, edgeBoolean = true) }
        hun_away_16_20?.setOnClickListener { setOnClickBackGround(textView = hun_away_16_20!!, betBean = basketballBean.sfcSp14) }
        hun_away_21_25?.setOnClickListener { setOnClickBackGround(textView = hun_away_21_25!!, betBean = basketballBean.sfcSp15) }
        hun_away_26?.setOnClickListener { setOnClickBackGround(textView = hun_away_26!!, betBean = basketballBean.sfcSp16) }
        hun_home_1_5?.setOnClickListener { setOnClickBackGround(textView = hun_home_1_5!!, betBean = basketballBean.sfcSp01) }
        hun_home_6_10?.setOnClickListener { setOnClickBackGround(textView = hun_home_6_10!!, betBean = basketballBean.sfcSp02) }
        hun_home_11_15?.setOnClickListener { setOnClickBackGround(textView = hun_home_11_15!!, betBean = basketballBean.sfcSp03) }
        hun_home_16_20?.setOnClickListener { setOnClickBackGround(textView = hun_home_16_20!!, betBean = basketballBean.sfcSp04) }
        hun_home_21_25?.setOnClickListener { setOnClickBackGround(textView = hun_home_21_25!!, betBean = basketballBean.sfcSp05) }
        hun_home_26?.setOnClickListener { setOnClickBackGround(textView = hun_home_26!!, betBean = basketballBean.sfcSp06) }

        hun_dxf_3?.setOnClickListener { setOnClickBackGround(textView = hun_dxf_3!!, betBean = basketballBean.dxfSp3, edgeBoolean = true) }
        hun_dxf_0?.setOnClickListener { setOnClickBackGround(textView = hun_dxf_0!!, betBean = basketballBean.dxfSp0, edgeBoolean = true) }


        hun_home_last?.setOnClickListener { setOnClickBackGround(textView = hun_home_last!!, betBean = basketballBean.sfSp0, edgeBoolean = true) }
        hun_home_win?.setOnClickListener { setOnClickBackGround(textView = hun_home_win!!, betBean = basketballBean.sfSp3, edgeBoolean = true) }
        hun_home_let_last?.setOnClickListener { setOnClickBackGround(textView = hun_home_let_last!!, betBean = basketballBean.rfsfSp0) }
        hun_home_let_win?.setOnClickListener { setOnClickBackGround(textView = hun_home_let_win!!, betBean = basketballBean.rfsfSp3, letBall = basketballBean.letBall) }

        cancel?.setOnClickListener { cancelChose() }
        sure?.setOnClickListener { sureChose() }

    }

    private fun initData(basketballBean: BasketballBean) {

        initLinear(basketballBean = basketballBean)

        away?.text = basketballBean.away
        home?.text = basketballBean.home

        /**
         * 非让分
         */
        if (basketballBean.sfFixed == 0) {
            hunSpfFixed?.visibility = View.VISIBLE
            hunSpfLinear?.visibility = View.GONE
        } else {
            hunSpfFixed?.visibility = View.GONE
            hunSpfLinear?.visibility = View.VISIBLE
        }

        /**
         * 让分
         */
        if (basketballBean.rfsfFixed == 0) {
            hunRqspfFixed?.visibility = View.VISIBLE
            hunRqspfLinear?.visibility = View.GONE
        } else {
            hunRqspfFixed?.visibility = View.GONE
            hunRqspfLinear?.visibility = View.VISIBLE
        }

        /**
         * 大小分
         */
        if (basketballBean.dxfFixed == 0) {
            hunDxfFixed?.visibility = View.VISIBLE
            hunDxfLinear?.visibility = View.GONE
        } else {
            hunDxfFixed?.visibility = View.GONE
            hunDxfLinear?.visibility = View.VISIBLE
        }

        /**
         * 进球数
         */
        if (basketballBean.sfcFixed == 0) {
            hunSfcFixed?.visibility = View.VISIBLE
            hunSfcLinear?.visibility = View.GONE
        } else {
            hunSfcFixed?.visibility = View.GONE
            hunSfcLinear?.visibility = View.VISIBLE
        }

        setOpenTextViewBg(hun_away_1_5!!, betBean = basketballBean.sfcSp11, edgeBoolean = true)
        setOpenTextViewBg(hun_away_6_10!!, betBean = basketballBean.sfcSp12, edgeBoolean = true)
        setOpenTextViewBg(hun_away_11_15!!, betBean = basketballBean.sfcSp13, edgeBoolean = true)
        setOpenTextViewBg(hun_away_16_20!!, betBean = basketballBean.sfcSp14)
        setOpenTextViewBg(hun_away_21_25!!, betBean = basketballBean.sfcSp15)
        setOpenTextViewBg(hun_away_26!!, betBean = basketballBean.sfcSp16)
        setOpenTextViewBg(hun_home_1_5!!, betBean = basketballBean.sfcSp01)
        setOpenTextViewBg(hun_home_6_10!!, betBean = basketballBean.sfcSp02)
        setOpenTextViewBg(hun_home_11_15!!, betBean = basketballBean.sfcSp03)
        setOpenTextViewBg(hun_home_16_20!!, betBean = basketballBean.sfcSp04)
        setOpenTextViewBg(hun_home_21_25!!, betBean = basketballBean.sfcSp05)
        setOpenTextViewBg(hun_home_26!!, betBean = basketballBean.sfcSp06)


        setOpenTextViewBg(hun_dxf_3!!, betBean = basketballBean.dxfSp3, edgeBoolean = true)
        setOpenTextViewBg(hun_dxf_0!!, betBean = basketballBean.dxfSp0, edgeBoolean = true)

        setOpenTextViewBg(hun_home_last!!, betBean = basketballBean.sfSp0, edgeBoolean = true)
        setOpenTextViewBg(hun_home_win!!, betBean = basketballBean.sfSp3, edgeBoolean = true)
        setOpenTextViewBg(hun_home_let_last!!, betBean = basketballBean.rfsfSp0)
        setOpenTextViewBg(hun_home_let_win!!, betBean = basketballBean.rfsfSp3, letBall = basketballBean.letBall)
    }


    /**
     * 设置控件一打开就下是的边框样式
     * @param textView 控件
     * @param betBean 样式选择条件
     * @param edgeBoolean 边框样式
     */
    private fun setOpenTextViewBg(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false, letBall: Double? = null) {
        val colorString = if (betBean.status) "#ffffff" else "#333333"
        val testColorString = if (betBean.status) "#ffffff" else "#666666"

        var letBallColor = if (betBean.status) "#ffffff" else "#63B8FF"
        if (letBall != null && letBall > 0) letBallColor = "#ff0000"
        val letString = if (letBall != null) "<font color='$letBallColor'>(${if (letBall > 0) "+$letBall" else letBall})</font>" else ""

        textView.text = Html.fromHtml("<font color='$colorString'>${betBean.jianChen}</font>$letString<br /><font color='$testColorString'>${betBean.sp}</font>")
        if (betBean.status) {
            textView.setBackgroundResource(R.drawable.select_item)
        } else {
            textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)

        }


    }


    /**
     * 设置点击事件
     * @param edgeBoolean  是否需要上边框
     * @param textView   控件
     */
    private fun setOnClickBackGround(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false, letBall: Double? = null) {

        betBean.status = !betBean.status
        setOpenTextViewBg(textView = textView, edgeBoolean = edgeBoolean, betBean = betBean, letBall = letBall)

        if (!choseList.none { it.key == betBean.key }) choseList.remove(betBean)
        else choseList.add(betBean)


    }


    fun setCallBack(callBasketballBeanBack: CallBasketballBeanBack) {
        this.callBeanBack = callBasketballBeanBack
    }


    /**
     * 确认选择的数据
     */

    private fun sureChose() {
        this.dismiss()
        callBeanBack?.onClickListener(basketballBean = updateBasketballBean!!, choseList = choseList)
        choseList.clear()
    }

    /**
     * 取消本次的选择
     */

    private fun cancelChose() {
        choseList.clear()
        this.dismiss()
    }


    /**
     * 显示popupWindow
     */
    fun showPopupWindow(basketballBean: BasketballBean) {
        if (!this.isShowing) {
            val lp = mActivity!!.window.attributes
            lp.alpha = 0.4f
            mActivity!!.window.attributes = lp

            this.oldBasketballBean = basketballBean
            this.updateBasketballBean = BasketballHelp().copyBasketBallBean(basketballBean = oldBasketballBean!!)

            initData(updateBasketballBean!!)
            this.showAtLocation(viewShow, Gravity.CENTER_HORIZONTAL, 0, 0)
            this.clickTxt?.isClickable= false
        } else {
            this.dismiss()
        }
    }


}