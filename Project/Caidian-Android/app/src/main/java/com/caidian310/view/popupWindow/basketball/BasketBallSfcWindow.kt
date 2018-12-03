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
 * icon_types_jclq 胜负差选择弹出框
 * Created by mac on 2017/11/16.
 */
class BasketBallSfcWindow() : BasePopupWindow() {

    var view: View? = null
    private var viewShow: View? = null
    var mActivity: Activity? = null
    var match: Match? = null

    var choselist: ArrayList<BetBean> = ArrayList()
    var callBeanBack: CallBasketballBeanBack? = null

    var updateBasketballBean: BasketballBean? = null


    var away_win_1_5: TextView? = null
    var away_win_6_10: TextView? = null
    var away_win_11_15: TextView? = null
    var away_win_16_20: TextView? = null
    var away_win_21_25: TextView? = null
    var away_win_26: TextView? = null

    var home_win_1_5: TextView? = null
    var home_win_6_10: TextView? = null
    var home_win_11_15: TextView? = null
    var home_win_16_20: TextView? = null
    var home_win_21_25: TextView? = null
    var home_win_26: TextView? = null

    var sure: TextView? = null
    var cancel: TextView? = null

    var home :TextView ?=null
    var away :TextView ?= null


    var fixedText: TextView? = null
    var fixedLinear: LinearLayout? = null
    var clickTxt: TextView? = null


    // 选中的比比赛
    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()

    constructor(context: Activity, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) : this() {
        view = LayoutInflater.from(context).inflate(R.layout.pop_basket_ball_bf, null)

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
            this.clickTxt?.isClickable = true
        }


    }

    override fun initView() {
        super.initView()

        home = view?.findViewById(R.id.pop_bf_home)
        away = view?.findViewById(R.id.pop_bf_away)


        // 客胜
        away_win_1_5 = view?.findViewById(R.id.pop_basket_away_win_1_5)
        away_win_6_10 = view?.findViewById(R.id.pop_basket_away_win_6_10)
        away_win_11_15 = view?.findViewById(R.id.pop_basket_away_win_11_15)
        away_win_16_20 = view?.findViewById(R.id.pop_basket_away_win_16_20)
        away_win_21_25 = view?.findViewById(R.id.pop_basket_away_win_21_25)
        away_win_26 = view?.findViewById(R.id.pop_basket_away_win_26)

        // 主胜
        home_win_1_5 = view?.findViewById(R.id.pop_basket_home_win_1_5)
        home_win_6_10 = view?.findViewById(R.id.pop_basket_home_win_6_10)
        home_win_11_15 = view?.findViewById(R.id.pop_basket_home_win_11_15)
        home_win_16_20 = view?.findViewById(R.id.pop_basket_home_win_16_20)
        home_win_21_25 = view?.findViewById(R.id.pop_basket_home_win_21_25)
        home_win_26 = view?.findViewById(R.id.pop_basket_home_win_26)


        fixedText = view?.findViewById(R.id.pop_basket_sfc_fixed)
        fixedLinear = view?.findViewById(R.id.pop_basket_sfc_fixed_linear)


        sure = view?.findViewById(R.id.pop_bf_sure)
        cancel = view?.findViewById(R.id.pop_bf_cancel)

    }


    private fun initDate() {

        home?.text = match?.home3
        away?.text = match?.away3


        openPopTextBg(textView = away_win_1_5!!, betBean = updateBasketballBean!!.sfcSp11, edgeBoolean = true)
        openPopTextBg(textView = away_win_6_10!!, betBean = updateBasketballBean!!.sfcSp12, edgeBoolean = true)
        openPopTextBg(textView = away_win_11_15!!, betBean = updateBasketballBean!!.sfcSp13, edgeBoolean = true)
        openPopTextBg(textView = away_win_16_20!!, betBean = updateBasketballBean!!.sfcSp14)
        openPopTextBg(textView = away_win_21_25!!, betBean = updateBasketballBean!!.sfcSp15)
        openPopTextBg(textView = away_win_26!!, betBean = updateBasketballBean!!.sfcSp16)

        openPopTextBg(textView = home_win_1_5!!, betBean = updateBasketballBean!!.sfcSp01)
        openPopTextBg(textView = home_win_6_10!!, betBean = updateBasketballBean!!.sfcSp02)
        openPopTextBg(textView = home_win_11_15!!, betBean = updateBasketballBean!!.sfcSp03)
        openPopTextBg(textView = home_win_16_20!!, betBean = updateBasketballBean!!.sfcSp04)
        openPopTextBg(textView = home_win_21_25!!, betBean = updateBasketballBean!!.sfcSp05)
        openPopTextBg(textView = home_win_26!!, betBean = updateBasketballBean!!.sfcSp06)


        //是否开售
        fixedText!!.visibility = if (updateBasketballBean!!.dxfFixed == 0) View.VISIBLE else View.GONE
        fixedLinear!!.visibility = if (updateBasketballBean!!.dxfFixed == 0) View.GONE else View.VISIBLE

        //  0 主  1客
        away_win_1_5?.setOnClickListener { clickItem(textView = away_win_1_5!!, betBean = updateBasketballBean!!.sfcSp11, edgeBoolean = true) }
        away_win_6_10?.setOnClickListener { clickItem(textView = away_win_6_10!!, betBean = updateBasketballBean!!.sfcSp12, edgeBoolean = true) }
        away_win_11_15?.setOnClickListener { clickItem(textView = away_win_11_15!!, betBean = updateBasketballBean!!.sfcSp13, edgeBoolean = true) }
        away_win_16_20?.setOnClickListener { clickItem(textView = away_win_16_20!!, betBean = updateBasketballBean!!.sfcSp14) }
        away_win_21_25?.setOnClickListener { clickItem(textView = away_win_21_25!!, betBean = updateBasketballBean!!.sfcSp15) }
        away_win_26?.setOnClickListener { clickItem(textView = away_win_26!!, betBean = updateBasketballBean!!.sfcSp16) }

        home_win_1_5?.setOnClickListener { clickItem(textView = home_win_1_5!!, betBean = updateBasketballBean!!.sfcSp01) }
        home_win_6_10?.setOnClickListener { clickItem(textView = home_win_6_10!!, betBean = updateBasketballBean!!.sfcSp02) }
        home_win_11_15?.setOnClickListener { clickItem(textView = home_win_11_15!!, betBean = updateBasketballBean!!.sfcSp03) }
        home_win_16_20?.setOnClickListener { clickItem(textView = home_win_16_20!!, betBean = updateBasketballBean!!.sfcSp04) }
        home_win_21_25?.setOnClickListener { clickItem(textView = home_win_21_25!!, betBean = updateBasketballBean!!.sfcSp05) }
        home_win_26?.setOnClickListener { clickItem(textView = home_win_26!!, betBean = updateBasketballBean!!.sfcSp06) }



        initLinear()
    }


    private fun initLinear() {
        sure?.setOnClickListener {

            callBeanBack?.onClickListener(basketballBean = updateBasketballBean!!, choseList = choselist)
            this.dismiss()
        }
        cancel?.setOnClickListener {
            choselist.clear()
            this.dismiss()

        }

    }

    private fun clickItem(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {
        betBean.status = !betBean.status
        openPopTextBg(textView = textView, edgeBoolean = edgeBoolean, betBean = betBean)

        if (choselist.any { it.key == betBean.key }) choselist.remove(betBean)
        else choselist.add(betBean)


    }


    /**
     * 控件打开的颜色
     * @param boolean 颜色状态
     * @param edgeBoolean 边框状态
     */

    private fun openPopTextBg(textView: TextView, edgeBoolean: Boolean = false, betBean: BetBean) {
        val colorString = if (betBean.status) "#ffffff" else "#333333"
        val testColorString = if (betBean.status) "#ffffff" else "#666666"
        textView.text = Html.fromHtml("<font color='$colorString'>${betBean.jianChen}</font><br/><font color='$testColorString'>${betBean.sp}</font>")
        if (betBean.status) {
            textView.setBackgroundResource(R.drawable.select_item)
        } else {
            textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)

        }

    }


    fun setCallBack(callBasketballBeanBack: CallBasketballBeanBack) {
        this.callBeanBack = callBasketballBeanBack
    }


    /**
     * 显示popupWindow
     */
    fun showPopupWindow(textView: TextView, match: Match, basketballBean: BasketballBean) {
        if (!this.isShowing) {

            this.clickTxt = textView
            this.match = match

            //保存数据源
            this.updateBasketballBean = BasketballHelp().copyBasketBallBean(basketballBean = basketballBean)


            //修改已选择项
            this.choselist.clear()
            this.choselist.addAll(BasketballHelp().getChoseBetList(basketballBean = updateBasketballBean!!))

            initDate()

            this.showAtLocation(viewShow, Gravity.CENTER_HORIZONTAL, 0, 0)

            val lp = mActivity!!.window.attributes
            lp.alpha = 0.4f
            mActivity!!.window.attributes = lp

            this.clickTxt?.isClickable = false


        } else {
            this.dismiss()
        }
    }

}