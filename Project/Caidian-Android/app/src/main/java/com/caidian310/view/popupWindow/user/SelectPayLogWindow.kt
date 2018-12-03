package com.caidian310.view.popupWindow

import android.content.Context
import android.graphics.drawable.ColorDrawable
import android.view.LayoutInflater
import android.view.View
import android.widget.PopupWindow
import android.widget.RelativeLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.application.MyApplication
import com.caidian310.utils.DensityUtil
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.selectView.LoopView
import com.caidian310.view.selectView.OnItemSelectedListener

import java.util.*

/**

 * description : 用户支出流水
 * Created by wdb on 2017/4/25.
 */

class SelectPayLogWindow() : PopupWindow(), View.OnClickListener {
    private var callBack: CallPositionBack? = null
    var cancel: TextView? = null
    var center: TextView? = null
    var submit: TextView? = null
    var view: View? = null

    var loopView: LoopView? = null
    var timeList: List<String>? = null
    private var currentIndex: Int = 0

    constructor(context: Context, timeList: ArrayList<String>, initPosition: Int = 0) : this() {
        this.timeList = timeList
        this.currentIndex = when (initPosition) {
            0 -> 0
            1 -> 1
            2 -> 2
            else -> 3
        }

        val inflater = MyApplication.instance.getSystemService(MyApplication.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        view = inflater.inflate(R.layout.layout_select_window, null)
        loopView = view?.findViewById(R.id.pop_loop_view)

        initView()
        initEvent()

        this.contentView = this.view                                // 设置视图
        this.height = DensityUtil.dip2px(context, 200f)
        this.width = RelativeLayout.LayoutParams.MATCH_PARENT
        this.isFocusable = true                                     // 设置弹出窗体可点击
        val dw = ColorDrawable(0xb0000000.toInt())                  // 实例化一个ColorDrawable颜色为半透明
        this.setBackgroundDrawable(dw)                              // 设置弹出窗体的背景
        this.animationStyle = R.style.take_photo_anim               // 设置弹出窗体显示时的动画，从底部向上弹出
    }


    // 设置 LoopView
    fun initEvent() {
        loopView?.setItems(timeList)                                 //设置标题
        loopView?.setNotLoop()                                       //不循环
        loopView?.setListener(onItemSelectedListener)                //loopView 监听

        loopView?.setInitPosition(currentIndex)                      //设置初始位置
    }

    // loopView 监听
    private var onItemSelectedListener: OnItemSelectedListener = OnItemSelectedListener { index ->
        currentIndex = index

    }

    // 初始化参数
    fun initView() {
        cancel = view?.findViewById(R.id.cancel)
        center = view?.findViewById(R.id.center)
        submit = view?.findViewById(R.id.complete)
        center?.text = "选择查询方式"
        cancel!!.setOnClickListener(this)
        submit!!.setOnClickListener(this)
    }

    fun setCallBack(callBack: CallPositionBack) {
        this.callBack = callBack

    }

    override fun onClick(v: View) {
        when (v.id) {
            R.id.cancel -> this.dismiss()
            R.id.complete -> {
                callBack?.callPositionBack(position = when (currentIndex) {
                    0 -> 0
                    1 -> 1
                    2 -> 2
                    else -> 3
                })
                this.dismiss()
            }
        }

    }
}
