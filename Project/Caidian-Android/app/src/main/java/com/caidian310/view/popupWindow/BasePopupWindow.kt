package com.caidian310.view.popupWindow

import android.app.Activity
import android.graphics.drawable.ColorDrawable
import android.view.View
import android.widget.PopupWindow

/**
 * Created by mac on 2017/11/15.
 */
open class BasePopupWindow : PopupWindow(), View.OnClickListener {
    override fun onClick(v: View?) {
    }


    open fun initView() {}    // 初始化控件

    open fun initEvent() {}    //处理逻辑

    /**
     * 显示pop
     * @param view  根据view 设置显示位置
     */
    open fun show(view: View) {}


    /**
     * 遮罩效果
     * @param context 当前的activity实例
     */
    open fun setBackgroundAlpha(context: Activity) {

        // 实例化一个ColorDrawable颜色为半透明
        val dw = ColorDrawable(0x00000000)

        // 设置弹出窗体的背景
        this.setBackgroundDrawable(dw)

        val lp = context.window.attributes
        lp.alpha = 0.4f
        context.window.attributes = lp

        //
        this.setOnDismissListener {
            val lp = context.window.attributes
            lp.alpha = 1f
            context.window.attributes = lp
        }

    }

    /**
     * 显示遮罩
     */
    fun showBackground() {
        // 实例化一个ColorDrawable颜色为半透明
        val dw = ColorDrawable(0x00000000)
        // 设置弹出窗体的背景
        this.setBackgroundDrawable(dw)
    }


}