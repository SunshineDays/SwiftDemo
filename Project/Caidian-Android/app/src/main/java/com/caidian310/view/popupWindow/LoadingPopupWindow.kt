package com.caidian310.view.popupWindow

import android.graphics.drawable.ColorDrawable
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.application.MyApplication


open class LoadingPopupWindow : BasePopupWindow {

    var activity: BaseActivity? = null

    constructor(context: BaseActivity) {
        val inflater = context.getSystemService(MyApplication.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val mView = inflater.inflate(R.layout.layout_loading, null)

        this.activity = context

        this.isFocusable = false                                     // 设置弹出窗体可点击

        this.contentView = mView                                       // 设置视图
        this.height = LinearLayout.LayoutParams.MATCH_PARENT
        this.width = LinearLayout.LayoutParams.MATCH_PARENT
        this.isFocusable = false

        val dw = ColorDrawable(0x00000000)
        this.setBackgroundDrawable(dw)


        this.setOnDismissListener {
            val lp = context.window.attributes
            lp.alpha = 1f
            context.window.attributes = lp

        }

    }

    fun show() {
        if (!this.isShowing){
            val lp = activity!!.window.attributes
            lp.alpha = 0.4f
            activity!!.window.attributes = lp
            this.showAsDropDown(activity!!.window.decorView, 0, 0, Gravity.BOTTOM)
        }
    }

    fun hint() {
        if (this.isShowing) {
            this.dismiss()
            return
        }
    }
}