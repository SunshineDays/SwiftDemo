package com.caidian310.view.popupWindow

import android.app.Activity
import android.content.Intent
import android.graphics.drawable.ColorDrawable
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.user.BuyListActivity
import com.caidian310.activity.web.IntroWebActivity
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DensityUtil


/**
 * 竞彩足球 更多
 * Created by mac on 2017/11/16.
 */
class FootBallMoreWindow() : BasePopupWindow() {

    var view: View? = null
    private var recordTxt: TextView? = null
    private var introduceTxt: TextView? = null
    private var context: Activity? = null
    private var bgImg: ImageView? = null
    private var lotteryId =0

    constructor(context: Activity,lotteryId:Int) : this() {
        this.context = context
        view = LayoutInflater.from(context).inflate(R.layout.pop_foot_ball_more, null)

        recordTxt = view?.findViewById(R.id.pop_foot_ball_more_record)
        introduceTxt = view?.findViewById(R.id.pop_foot_ball_more_introduce)
        bgImg = view?.findViewById(R.id.pop_foot_ball_more_img)
        bgImg?.setColorFilter(ColorUtil.getColor(R.color.white))
        recordTxt?.setOnClickListener(this)
        introduceTxt?.setOnClickListener(this)

        this.lotteryId = lotteryId
        this.contentView = view // 设置视图
        this.isFocusable = true
        this.height = DensityUtil.dip2px(context, 120f)
        this.width = DensityUtil.dip2px(context, 100f)
        this.isFocusable = true

        val dw = ColorDrawable(0x00000000)
        this.setBackgroundDrawable(dw)

        this.setOnDismissListener {
            val lp = context.window.attributes
            lp.alpha = 1f
            context.window.attributes = lp
        }


    }

    override fun show(view: View) {
        super.show(view)
        if (this.isShowing) {
            dismiss()
        }
        //偏移200  使其在图片的正下方
        else {
            val lp = context!!.window.attributes
            lp.alpha = 0.4f
            context!!.window.attributes = lp

            this.showAsDropDown(view, -200, 0)
        }
    }

    override fun onClick(v: View?) {
        super.onClick(v)
        when (v?.id) {
            R.id.pop_foot_ball_more_record -> {
                //投注记录
                context?.startActivity(Intent(context, BuyListActivity::class.java))
                this.dismiss()

            }
            R.id.pop_foot_ball_more_introduce -> {
                // 玩法介绍
                showAgreementFormLottery(lotteryId)
                this.dismiss()
            }
        }
    }


    /**
     * 显示不同协议
     */

    private fun showAgreementFormLottery(lotteryId: Int){

        val intent = Intent(context,IntroWebActivity::class.java)
        intent.putExtra("title","玩法介绍")
        intent.putExtra("lotteryId",lotteryId)
        context!!.startActivity(intent)
    }
}