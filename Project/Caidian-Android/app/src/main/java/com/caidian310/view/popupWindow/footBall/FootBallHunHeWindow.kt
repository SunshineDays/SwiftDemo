package com.caidian310.view.popupWindow.footBall

import android.app.Activity
import android.graphics.drawable.ColorDrawable
import android.text.Html
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.R.id.textView
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.utils.BetUtil
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DensityUtil
import com.caidian310.view.callBack.CallChoseListBack
import com.caidian310.view.popupWindow.BasePopupWindow
import org.jetbrains.anko.backgroundColor


/**
 * 竞彩足球 比分选择弹出框
 * Created by mac on 2017/11/16.
 */
class FootBallHunHeWindow() : BasePopupWindow() {

    var view: View? = null
    private var viewShow: View? = null
    private var mActivity: Activity? = null
    var match: Match? = null
    private var oldList: ArrayList<BetBean> = ArrayList()
    private var updatelist: ArrayList<BetBean> = ArrayList()
    private var choseList: ArrayList<BetBean> = ArrayList()


    var callBeanBack: CallChoseListBack? = null

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
    var bfFixes: TextView? = null
    var bfLinear: LinearLayout? = null

    var spf_3: TextView? = null
    var spf_1: TextView? = null
    var spf_0: TextView? = null
    var spf_let_3: TextView? = null
    var spf_let_1: TextView? = null
    var spf_let_0: TextView? = null
    var spfFixes: TextView? = null
    var spfLinear: LinearLayout? = null
    var rqSpfFixes: TextView? = null
    var rqSpfLinear: LinearLayout? = null

    var jqs_0: TextView? = null
    var jqs_1: TextView? = null
    var jqs_2: TextView? = null
    var jqs_3: TextView? = null
    var jqs_4: TextView? = null
    var jqs_5: TextView? = null
    var jqs_6: TextView? = null
    var jqs_7: TextView? = null
    var jqsFixes: TextView? = null
    var jqsLinear: LinearLayout? = null

    var bqc_3_3: TextView? = null
    var bqc_3_1: TextView? = null
    var bqc_3_0: TextView? = null
    var bqc_1_3: TextView? = null
    var bqc_1_0: TextView? = null
    var bqc_0_3: TextView? = null
    var bqc_0_1: TextView? = null
    var bqc_0_0: TextView? = null
    var bqc_1_1: TextView? = null
    var bqcFixes: TextView? = null
    var bqcLinear: LinearLayout? = null


    var letBallText: TextView? = null


    var sure: TextView? = null
    var cancel: TextView? = null
    var home: TextView? = null
    var away: TextView? = null

    var clickTxt: TextView? = null

    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()


    constructor(context: Activity, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) : this() {
        view = LayoutInflater.from(context).inflate(R.layout.pop_foot_ball_he, null)

        this.mActivity = context
        this.match = match
        this.choseMap = choseMap

        initView()


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
            this.clickTxt?.isClickable = true
        }


    }

    override fun initView() {
        super.initView()
        home = view?.findViewById(R.id.pop_bf_home)
        away = view?.findViewById(R.id.pop_bf_away)
        letBallText = view?.findViewById(R.id.pop_let_ball)


        //胜平负
        spf_3 = view?.findViewById(R.id.pop_spf_3)
        spf_1 = view?.findViewById(R.id.pop_spf_1)
        spf_0 = view?.findViewById(R.id.pop_spf_0)
        spfFixes = view?.findViewById(R.id.pop_spf_fixed)
        spfLinear = view?.findViewById(R.id.pop_spf_linear)

        spf_let_3 = view?.findViewById(R.id.pop_spf_let_3)
        spf_let_1 = view?.findViewById(R.id.pop_spf_let_1)
        spf_let_0 = view?.findViewById(R.id.pop_spf_let_0)
        rqSpfFixes = view?.findViewById(R.id.pop_rq_spf_fixed)
        rqSpfLinear = view?.findViewById(R.id.pop_rq_spf_linear)

        //进球数
        jqs_0 = view?.findViewById(R.id.pop_he_jqs_0)
        jqs_1 = view?.findViewById(R.id.pop_he_jqs_1)
        jqs_2 = view?.findViewById(R.id.pop_he_jqs_2)
        jqs_3 = view?.findViewById(R.id.pop_he_jqs_3)
        jqs_4 = view?.findViewById(R.id.pop_he_jqs_4)
        jqs_5 = view?.findViewById(R.id.pop_he_jqs_5)
        jqs_6 = view?.findViewById(R.id.pop_he_jqs_6)
        jqs_7 = view?.findViewById(R.id.pop_he_jqs_7)
        jqsFixes = view?.findViewById(R.id.pop_jqs_fixed)
        jqsLinear = view?.findViewById(R.id.pop_jqs_linear)


        //半全场
        bqc_3_3 = view?.findViewById(R.id.pop_he_bqc_3_3)
        bqc_3_1 = view?.findViewById(R.id.pop_he_bqc_3_1)
        bqc_3_0 = view?.findViewById(R.id.pop_he_bqc_3_0)
        bqc_1_3 = view?.findViewById(R.id.pop_he_bqc_1_3)
        bqc_1_0 = view?.findViewById(R.id.pop_he_bqc_1_0)
        bqc_0_3 = view?.findViewById(R.id.pop_he_bqc_0_3)
        bqc_0_1 = view?.findViewById(R.id.pop_he_bqc_0_1)
        bqc_0_0 = view?.findViewById(R.id.pop_he_bqc_0_0)
        bqc_1_1 = view?.findViewById(R.id.pop_he_bqc_1_1)
        bqcFixes = view?.findViewById(R.id.pop_bqc_fixed)
        bqcLinear = view?.findViewById(R.id.pop_bqc_linear)

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

        //平
        bf_0_0 = view?.findViewById(R.id.pop_bf_0_0)
        bf_1_1 = view?.findViewById(R.id.pop_bf_1_1)
        bf_2_2 = view?.findViewById(R.id.pop_bf_2_2)
        bf_3_3 = view?.findViewById(R.id.pop_bf_3_3)
        bf_1_other = view?.findViewById(R.id.pop_bf_1_other)
        bfFixes = view?.findViewById(R.id.pop_bf_fixed)
        bfLinear = view?.findViewById(R.id.pop_bf_linear)


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

        initLinear()

    }

    private fun initDate(jczqBeanList: ArrayList<BetBean>) {

        home?.text = match?.home
        away?.text = match?.away


        letBallText?.text = "${if (match!!.letBall > 0) "+" else ""}${match!!.letBall.toInt()}"
        letBallText?.backgroundColor = ColorUtil.getColor(if (match!!.letBall > 0) R.color.homeWin else R.color.LetSfBg)

        run {
            //胜平负是否开售
            if (match?.spfFixed == 0) {
                spfFixes?.visibility = View.VISIBLE
                spfLinear?.visibility = View.GONE

            } else {
                spfFixes?.visibility = View.GONE
                spfLinear?.visibility = View.VISIBLE
            }
            //让球胜平负是否开售
            if (match?.rqspfFixed == 0) {
                rqSpfFixes?.visibility = View.VISIBLE
                rqSpfLinear?.visibility = View.GONE

            } else {
                rqSpfFixes?.visibility = View.GONE
                rqSpfLinear?.visibility = View.VISIBLE
            }
            //进球数是否开售
            if (match?.jqsFixed == 0) {
                jqsFixes?.visibility = View.VISIBLE
                jqsLinear?.visibility = View.GONE

            } else {
                jqsFixes?.visibility = View.GONE
                jqsLinear?.visibility = View.VISIBLE
            }
            //半全场是否开售
            if (match?.bqcFixed == 0) {
                bqcFixes?.visibility = View.VISIBLE
                bqcLinear?.visibility = View.GONE

            } else {
                bqcFixes?.visibility = View.GONE
                bqcLinear?.visibility = View.VISIBLE
            }
            //比分是否开售
            if (match?.bqcFixed == 0) {
                bfFixes?.visibility = View.VISIBLE
                bfLinear?.visibility = View.GONE

            } else {
                bfFixes?.visibility = View.GONE
                bfLinear?.visibility = View.VISIBLE
            }
        }

        val jqs_sp0 = jczqBeanList[BetTypeEnum.jqs_sp0.listIndex]
        val jqs_sp1 = jczqBeanList[BetTypeEnum.jqs_sp1.listIndex]
        val jqs_sp2 = jczqBeanList[BetTypeEnum.jqs_sp2.listIndex]
        val jqs_sp3 = jczqBeanList[BetTypeEnum.jqs_sp3.listIndex]
        val jqs_sp4 = jczqBeanList[BetTypeEnum.jqs_sp4.listIndex]
        val jqs_sp5 = jczqBeanList[BetTypeEnum.jqs_sp5.listIndex]
        val jqs_sp6 = jczqBeanList[BetTypeEnum.jqs_sp6.listIndex]
        val jqs_sp7 = jczqBeanList[BetTypeEnum.jqs_sp7.listIndex]

        val bqc_sp33 = jczqBeanList[BetTypeEnum.bqc_sp33.listIndex]
        val bqc_sp31 = jczqBeanList[BetTypeEnum.bqc_sp31.listIndex]
        val bqc_sp30 = jczqBeanList[BetTypeEnum.bqc_sp30.listIndex]
        val bqc_sp13 = jczqBeanList[BetTypeEnum.bqc_sp13.listIndex]
        val bqc_sp10 = jczqBeanList[BetTypeEnum.bqc_sp10.listIndex]
        val bqc_sp03 = jczqBeanList[BetTypeEnum.bqc_sp03.listIndex]
        val bqc_sp01 = jczqBeanList[BetTypeEnum.bqc_sp01.listIndex]
        val bqc_sp00 = jczqBeanList[BetTypeEnum.bqc_sp00.listIndex]
        val bqc_sp11 = jczqBeanList[BetTypeEnum.bqc_sp11.listIndex]


        val spf_sp3 = jczqBeanList[BetTypeEnum.spf_sp3.listIndex]
        val spf_sp1 = jczqBeanList[BetTypeEnum.spf_sp1.listIndex]
        val spf_sp0 = jczqBeanList[BetTypeEnum.spf_sp0.listIndex]
        val rqspf_sp3 = jczqBeanList[BetTypeEnum.rqspf_sp3.listIndex]
        val rqspf_sp1 = jczqBeanList[BetTypeEnum.rqspf_sp1.listIndex]
        val rqspf_sp0 = jczqBeanList[BetTypeEnum.rqspf_sp0.listIndex]

        val bf_sp10 = jczqBeanList[BetTypeEnum.bf_sp10.listIndex]
        val bf_sp20 = jczqBeanList[BetTypeEnum.bf_sp20.listIndex]
        val bf_sp21 = jczqBeanList[BetTypeEnum.bf_sp21.listIndex]
        val bf_sp30 = jczqBeanList[BetTypeEnum.bf_sp30.listIndex]
        val bf_sp31 = jczqBeanList[BetTypeEnum.bf_sp31.listIndex]
        val bf_sp32 = jczqBeanList[BetTypeEnum.bf_sp32.listIndex]
        val bf_sp40 = jczqBeanList[BetTypeEnum.bf_sp40.listIndex]
        val bf_sp41 = jczqBeanList[BetTypeEnum.bf_sp41.listIndex]
        val bf_sp42 = jczqBeanList[BetTypeEnum.bf_sp42.listIndex]
        val bf_sp50 = jczqBeanList[BetTypeEnum.bf_sp50.listIndex]
        val bf_sp51 = jczqBeanList[BetTypeEnum.bf_sp51.listIndex]
        val bf_sp52 = jczqBeanList[BetTypeEnum.bf_sp52.listIndex]

        val bf_sp00 = jczqBeanList[BetTypeEnum.bf_sp00.listIndex]
        val bf_sp11 = jczqBeanList[BetTypeEnum.bf_sp11.listIndex]
        val bf_sp22 = jczqBeanList[BetTypeEnum.bf_sp22.listIndex]
        val bf_sp33 = jczqBeanList[BetTypeEnum.bf_sp33.listIndex]
        val bf_sp01 = jczqBeanList[BetTypeEnum.bf_sp01.listIndex]
        val bf_sp02 = jczqBeanList[BetTypeEnum.bf_sp02.listIndex]
        val bf_sp12 = jczqBeanList[BetTypeEnum.bf_sp12.listIndex]
        val bf_sp03 = jczqBeanList[BetTypeEnum.bf_sp03.listIndex]
        val bf_sp13 = jczqBeanList[BetTypeEnum.bf_sp13.listIndex]
        val bf_sp23 = jczqBeanList[BetTypeEnum.bf_sp23.listIndex]
        val bf_sp04 = jczqBeanList[BetTypeEnum.bf_sp04.listIndex]
        val bf_sp14 = jczqBeanList[BetTypeEnum.bf_sp14.listIndex]
        val bf_sp24 = jczqBeanList[BetTypeEnum.bf_sp24.listIndex]
        val bf_sp05 = jczqBeanList[BetTypeEnum.bf_sp05.listIndex]
        val bf_sp15 = jczqBeanList[BetTypeEnum.bf_sp15.listIndex]
        val bf_sp25 = jczqBeanList[BetTypeEnum.bf_sp25.listIndex]
        val bf_spA3 = jczqBeanList[BetTypeEnum.bf_spA3.listIndex]
        val bf_spA1 = jczqBeanList[BetTypeEnum.bf_spA1.listIndex]
        val bf_spA0 = jczqBeanList[BetTypeEnum.bf_spA0.listIndex]


        //进球数
        setOpenTextViewBg(textView = jqs_0!!, jczq = jqs_sp0, edgeBoolean = true)
        setOpenTextViewBg(textView = jqs_1!!, jczq = jqs_sp1, edgeBoolean = true)
        setOpenTextViewBg(textView = jqs_2!!, jczq = jqs_sp2, edgeBoolean = true)
        setOpenTextViewBg(textView = jqs_3!!, jczq = jqs_sp3, edgeBoolean = true)
        setOpenTextViewBg(textView = jqs_4!!, jczq = jqs_sp4, edgeBoolean = false)
        setOpenTextViewBg(textView = jqs_5!!, jczq = jqs_sp5, edgeBoolean = false)
        setOpenTextViewBg(textView = jqs_6!!, jczq = jqs_sp6, edgeBoolean = false)
        setOpenTextViewBg(textView = jqs_7!!, jczq = jqs_sp7, edgeBoolean = false)


        //半全场
        setOpenTextViewBg(textView = bqc_3_3!!, jczq = bqc_sp33, edgeBoolean = true)
        setOpenTextViewBg(textView = bqc_1_1!!, jczq = bqc_sp11, edgeBoolean = true)
        setOpenTextViewBg(textView = bqc_3_1!!, jczq = bqc_sp31, edgeBoolean = true)
        setOpenTextViewBg(textView = bqc_3_0!!, jczq = bqc_sp30, edgeBoolean = true)
        setOpenTextViewBg(textView = bqc_1_3!!, jczq = bqc_sp13, edgeBoolean = true)
        setOpenTextViewBg(textView = bqc_1_0!!, jczq = bqc_sp10, edgeBoolean = false)
        setOpenTextViewBg(textView = bqc_0_3!!, jczq = bqc_sp03, edgeBoolean = false)
        setOpenTextViewBg(textView = bqc_0_1!!, jczq = bqc_sp01, edgeBoolean = false)
        setOpenTextViewBg(textView = bqc_0_0!!, jczq = bqc_sp00, edgeBoolean = false)

        //胜平负
        setOpenTextViewBg(textView = spf_3!!, jczq = spf_sp3, edgeBoolean = true)
        setOpenTextViewBg(textView = spf_1!!, jczq = spf_sp1, edgeBoolean = true)
        setOpenTextViewBg(textView = spf_0!!, jczq = spf_sp0, edgeBoolean = true)
        setOpenTextViewBg(textView = spf_let_3!!, jczq = rqspf_sp3, edgeBoolean = false)
        setOpenTextViewBg(textView = spf_let_1!!, jczq = rqspf_sp1, edgeBoolean = false)
        setOpenTextViewBg(textView = spf_let_0!!, jczq = rqspf_sp0, edgeBoolean = false)


        //比分
        setOpenTextViewBg(textView = bf_1_0!!, jczq = bf_sp10, edgeBoolean = true)
        setOpenTextViewBg(textView = bf_2_0!!, jczq = bf_sp20, edgeBoolean = true)
        setOpenTextViewBg(textView = bf_2_1!!, jczq = bf_sp21, edgeBoolean = true)
        setOpenTextViewBg(textView = bf_3_0!!, jczq = bf_sp30, edgeBoolean = true)
        setOpenTextViewBg(textView = bf_3_1!!, jczq = bf_sp31, edgeBoolean = true)
        setOpenTextViewBg(textView = bf_3_2!!, jczq = bf_sp32, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_4_0!!, jczq = bf_sp40, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_4_1!!, jczq = bf_sp41, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_4_2!!, jczq = bf_sp42, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_5_0!!, jczq = bf_sp50, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_5_1!!, jczq = bf_sp51, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_5_2!!, jczq = bf_sp52, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_0!!, jczq = bf_sp00, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_1!!, jczq = bf_sp11, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_2_2!!, jczq = bf_sp22, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_3_3!!, jczq = bf_sp33, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_1!!, jczq = bf_sp01, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_2!!, jczq = bf_sp02, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_2!!, jczq = bf_sp12, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_3!!, jczq = bf_sp03, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_3!!, jczq = bf_sp13, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_2_3!!, jczq = bf_sp23, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_4!!, jczq = bf_sp04, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_4!!, jczq = bf_sp14, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_2_4!!, jczq = bf_sp24, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_5!!, jczq = bf_sp05, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_5!!, jczq = bf_sp15, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_2_5!!, jczq = bf_sp25, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_3_other!!, jczq = bf_spA3, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_1_other!!, jczq = bf_spA1, edgeBoolean = false)
        setOpenTextViewBg(textView = bf_0_other!!, jczq = bf_spA0, edgeBoolean = false)


        //胜平负
        spf_3?.setOnClickListener { setOnClickBackGround(textView = spf_3!!, edgeBoolean = true, jczq = spf_sp3) }
        spf_1?.setOnClickListener { setOnClickBackGround(textView = spf_1!!, edgeBoolean = true, jczq = spf_sp1) }
        spf_0?.setOnClickListener { setOnClickBackGround(textView = spf_0!!, edgeBoolean = true, jczq = spf_sp0) }
        spf_let_3?.setOnClickListener { setOnClickBackGround(textView = spf_let_3!!, edgeBoolean = false, jczq = rqspf_sp3) }
        spf_let_1?.setOnClickListener { setOnClickBackGround(textView = spf_let_1!!, edgeBoolean = false, jczq = rqspf_sp1) }
        spf_let_0?.setOnClickListener { setOnClickBackGround(textView = spf_let_0!!, edgeBoolean = false, jczq = rqspf_sp0) }

        //进球数
        jqs_0?.setOnClickListener { setOnClickBackGround(textView = jqs_0!!, edgeBoolean = true, jczq = jqs_sp0) }
        jqs_1?.setOnClickListener { setOnClickBackGround(textView = jqs_1!!, edgeBoolean = true, jczq = jqs_sp1) }
        jqs_2?.setOnClickListener { setOnClickBackGround(textView = jqs_2!!, edgeBoolean = true, jczq = jqs_sp2) }
        jqs_3?.setOnClickListener { setOnClickBackGround(textView = jqs_3!!, edgeBoolean = true, jczq = jqs_sp3) }
        jqs_4?.setOnClickListener { setOnClickBackGround(textView = jqs_4!!, edgeBoolean = false, jczq = jqs_sp4) }
        jqs_5?.setOnClickListener { setOnClickBackGround(textView = jqs_5!!, edgeBoolean = false, jczq = jqs_sp5) }
        jqs_6?.setOnClickListener { setOnClickBackGround(textView = jqs_6!!, edgeBoolean = false, jczq = jqs_sp6) }
        jqs_7?.setOnClickListener { setOnClickBackGround(textView = jqs_7!!, edgeBoolean = false, jczq = jqs_sp7) }


        //半全场

        bqc_3_3?.setOnClickListener { setOnClickBackGround(textView = bqc_3_3!!, edgeBoolean = true, jczq = bqc_sp33) }
        bqc_3_1?.setOnClickListener { setOnClickBackGround(textView = bqc_3_1!!, edgeBoolean = true, jczq = bqc_sp31) }
        bqc_3_0?.setOnClickListener { setOnClickBackGround(textView = bqc_3_0!!, edgeBoolean = true, jczq = bqc_sp30) }
        bqc_1_3?.setOnClickListener { setOnClickBackGround(textView = bqc_1_3!!, edgeBoolean = true, jczq = bqc_sp13) }
        bqc_1_0?.setOnClickListener { setOnClickBackGround(textView = bqc_1_0!!, edgeBoolean = false, jczq = bqc_sp10) }
        bqc_0_3?.setOnClickListener { setOnClickBackGround(textView = bqc_0_3!!, edgeBoolean = false, jczq = bqc_sp03) }
        bqc_0_1?.setOnClickListener { setOnClickBackGround(textView = bqc_0_1!!, edgeBoolean = false, jczq = bqc_sp01) }
        bqc_0_0?.setOnClickListener { setOnClickBackGround(textView = bqc_0_0!!, edgeBoolean = false, jczq = bqc_sp00) }
        bqc_1_1?.setOnClickListener { setOnClickBackGround(textView = bqc_1_1!!, edgeBoolean = true, jczq = bqc_sp11) }


        //比分
        bf_1_0?.setOnClickListener { setOnClickBackGround(textView = bf_1_0!!, edgeBoolean = true, jczq = bf_sp10) }
        bf_2_0?.setOnClickListener { setOnClickBackGround(textView = bf_2_0!!, edgeBoolean = true, jczq = bf_sp20) }
        bf_2_1?.setOnClickListener { setOnClickBackGround(textView = bf_2_1!!, edgeBoolean = true, jczq = bf_sp21) }
        bf_3_0?.setOnClickListener { setOnClickBackGround(textView = bf_3_0!!, edgeBoolean = true, jczq = bf_sp30) }
        bf_3_1?.setOnClickListener { setOnClickBackGround(textView = bf_3_1!!, edgeBoolean = true, jczq = bf_sp31) }
        bf_3_2?.setOnClickListener { setOnClickBackGround(textView = bf_3_2!!, edgeBoolean = false, jczq = bf_sp32) }
        bf_4_0?.setOnClickListener { setOnClickBackGround(textView = bf_4_0!!, edgeBoolean = false, jczq = bf_sp40) }
        bf_4_1?.setOnClickListener { setOnClickBackGround(textView = bf_4_1!!, edgeBoolean = false, jczq = bf_sp41) }
        bf_4_2?.setOnClickListener { setOnClickBackGround(textView = bf_4_2!!, edgeBoolean = false, jczq = bf_sp42) }
        bf_5_0?.setOnClickListener { setOnClickBackGround(textView = bf_5_0!!, edgeBoolean = false, jczq = bf_sp50) }
        bf_5_1?.setOnClickListener { setOnClickBackGround(textView = bf_5_1!!, edgeBoolean = false, jczq = bf_sp51) }
        bf_5_2?.setOnClickListener { setOnClickBackGround(textView = bf_5_2!!, edgeBoolean = false, jczq = bf_sp52) }

        bf_0_0?.setOnClickListener { setOnClickBackGround(textView = bf_0_0!!, edgeBoolean = false, jczq = bf_sp00) }
        bf_1_1?.setOnClickListener { setOnClickBackGround(textView = bf_1_1!!, edgeBoolean = false, jczq = bf_sp11) }
        bf_2_2?.setOnClickListener { setOnClickBackGround(textView = bf_2_2!!, edgeBoolean = false, jczq = bf_sp22) }
        bf_3_3?.setOnClickListener { setOnClickBackGround(textView = bf_3_3!!, edgeBoolean = false, jczq = bf_sp33) }

        bf_0_1?.setOnClickListener { setOnClickBackGround(textView = bf_0_1!!, edgeBoolean = false, jczq = bf_sp01) }
        bf_0_2?.setOnClickListener { setOnClickBackGround(textView = bf_0_2!!, edgeBoolean = false, jczq = bf_sp02) }
        bf_1_2?.setOnClickListener { setOnClickBackGround(textView = bf_1_2!!, edgeBoolean = false, jczq = bf_sp12) }
        bf_0_3?.setOnClickListener { setOnClickBackGround(textView = bf_0_3!!, edgeBoolean = false, jczq = bf_sp03) }
        bf_1_3?.setOnClickListener { setOnClickBackGround(textView = bf_1_3!!, edgeBoolean = false, jczq = bf_sp13) }
        bf_2_3?.setOnClickListener { setOnClickBackGround(textView = bf_2_3!!, edgeBoolean = false, jczq = bf_sp23) }
        bf_0_4?.setOnClickListener { setOnClickBackGround(textView = bf_0_4!!, edgeBoolean = false, jczq = bf_sp04) }
        bf_1_4?.setOnClickListener { setOnClickBackGround(textView = bf_1_4!!, edgeBoolean = false, jczq = bf_sp14) }
        bf_2_4?.setOnClickListener { setOnClickBackGround(textView = bf_2_4!!, edgeBoolean = false, jczq = bf_sp24) }
        bf_0_5?.setOnClickListener { setOnClickBackGround(textView = bf_0_5!!, edgeBoolean = false, jczq = bf_sp05) }
        bf_1_5?.setOnClickListener { setOnClickBackGround(textView = bf_1_5!!, edgeBoolean = false, jczq = bf_sp15) }
        bf_2_5?.setOnClickListener { setOnClickBackGround(textView = bf_2_5!!, edgeBoolean = false, jczq = bf_sp25) }

        bf_3_other?.setOnClickListener { setOnClickBackGround(textView = bf_3_other!!, edgeBoolean = false, jczq = bf_spA3) }
        bf_0_other?.setOnClickListener { setOnClickBackGround(textView = bf_0_other!!, edgeBoolean = false, jczq = bf_spA0) }
        bf_1_other?.setOnClickListener { setOnClickBackGround(textView = bf_1_other!!, edgeBoolean = false, jczq = bf_spA1) }


    }


    private fun initLinear() {
        sure?.setOnClickListener { sureChose() }
        cancel?.setOnClickListener { cancelChose() }

    }


    /**
     * 设置控件一打开就下是的边框样式
     * @param textView 控件
     * @param jczq 样式选择条件
     * @param edgeBoolean 边框样式
     */
    private fun setOpenTextViewBg(textView: TextView, jczq: BetBean, edgeBoolean: Boolean = false) {
        val colorString = if (jczq.status) "#ffffff" else "#333333"
        val testColorString = if (jczq.status) "#ffffff" else "#666666"
        textView.text = Html.fromHtml("<font color='$colorString'>${jczq.jianChen}</font><br /><font color='$testColorString'>${jczq.sp}</font>")
        if (jczq.status) {
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
    private fun setOnClickBackGround(textView: TextView, edgeBoolean: Boolean = true, jczq: BetBean) {

        jczq.status = !jczq.status
        setOpenTextViewBg(textView = textView, edgeBoolean = edgeBoolean, jczq = jczq)

        if (choseList.contains(jczq)) choseList.remove(jczq)
        else choseList.add(jczq)

    }


    fun setCallBack(callChoseListBack: CallChoseListBack) {
        this.callBeanBack = callChoseListBack
    }


    /**
     * 确认选择的数据
     */

    private fun sureChose() {
        this.dismiss()
        callBeanBack?.onClickListener(list = updatelist, choseList = choseList)
        updatelist.clear()
        choseList.clear()
    }

    /**
     * 取消本次的选择
     */

    private fun cancelChose() {
        updatelist.clear()
        choseList.clear()
        oldList.forEach {
            updatelist.add(BetUtil().copyJczq(bean = it))
        }

        this.dismiss()
    }


    /**
     * 显示popupWindow
     */
    fun showPopupWindow(textView: TextView, match: Match,list: ArrayList<BetBean>) {
        if (!this.isShowing) {

            this.clickTxt = textView
            this.match = match

            oldList.addAll(list)
            updatelist.clear()

            list.forEach { updatelist.add(BetUtil().copyJczq(bean = it)) }

            initDate(jczqBeanList = updatelist)

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