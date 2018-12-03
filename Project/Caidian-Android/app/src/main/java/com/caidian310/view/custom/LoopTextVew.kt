package com.caidian310.view.custom

import android.content.Context
import android.graphics.drawable.Drawable
import android.text.Html
import android.text.TextUtils
import android.util.AttributeSet
import android.util.TypedValue
import android.view.Gravity
import android.view.animation.Animation
import android.view.animation.DecelerateInterpolator
import android.view.animation.TranslateAnimation
import android.widget.FrameLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.utils.ColorUtil


/**
 * Created by mac on 2018/2/3.
 */
class LooperTextView : FrameLayout {
    private var tipList: List<String>? = null
    private var curTipIndex = 0
    private var lastTimeMillis: Long = 0
//    private var head_icon: Drawable? = null
    private var tv_tip_out: TextView? = null
    private var tv_tip_in: TextView? = null
    private var anim_out: Animation? = null
    private var anim_in: Animation? = null
    /**
     * 获取下一条消息
     * @return
     */
    private val nextTip: String?
        get() = if (isListEmpty(tipList)) null else tipList!![curTipIndex++ % tipList!!.size]

    constructor(context: Context) : super(context) {
        initTipFrame()
        initAnimation()
    }

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs) {
        initTipFrame()
        initAnimation()
    }

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        initTipFrame()
        initAnimation()
    }

    private fun initTipFrame() {
//        head_icon = loadDrawable(R.mipmap.icon_notification)
        tv_tip_out = newTextView()
        tv_tip_in = newTextView()
        addView(tv_tip_in)
        addView(tv_tip_out)
    }

    private fun newTextView(): TextView {
        val textView = TextView(context)
        val lp = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT, Gravity.CENTER_VERTICAL)
        textView.layoutParams = lp
        textView.compoundDrawablePadding = 10
        textView.gravity = Gravity.CENTER_VERTICAL
        textView.setLines(2)
        textView.ellipsize = TextUtils.TruncateAt.END
        textView.setTextColor(DEFAULT_TEXT_COLOR)
        textView.setTextSize(TypedValue.COMPLEX_UNIT_DIP, DEFAULT_TEXT_SIZE.toFloat())
        return textView
    }

    /**
     * 将资源图片转换为Drawable对象
     * @param ResId
     * @return
     */
    private fun loadDrawable(ResId: Int): Drawable {
        val drawable = resources.getDrawable(ResId)
        drawable.setBounds(0, 0, drawable.minimumWidth - 10, drawable.minimumHeight - 10)
        return drawable
    }

    private fun initAnimation() {
        anim_out = newAnimation(0f, -1f)
        anim_in = newAnimation(1f, 0f)
        anim_in!!.setAnimationListener(object : Animation.AnimationListener {

            override fun onAnimationStart(animation: Animation) {

            }

            override fun onAnimationRepeat(animation: Animation) {

            }

            override fun onAnimationEnd(animation: Animation) {
                updateTipAndPlayAnimationWithCheck()
            }
        })
    }

    private fun newAnimation(fromYValue: Float, toYValue: Float): Animation {
        val anim = TranslateAnimation(Animation.RELATIVE_TO_SELF, 0f, Animation.RELATIVE_TO_SELF, 0f,
                Animation.RELATIVE_TO_SELF, fromYValue, Animation.RELATIVE_TO_SELF, toYValue)
        anim.duration = ANIM_DURATION.toLong()
        anim.startOffset = ANIM_DELAYED_MILLIONS.toLong()
        anim.interpolator = DecelerateInterpolator()
        return anim
    }

    private fun updateTipAndPlayAnimationWithCheck() {
        if (System.currentTimeMillis() - lastTimeMillis < 1000) {
            return
        }
        lastTimeMillis = System.currentTimeMillis()
        updateTipAndPlayAnimation()
    }

    private fun updateTipAndPlayAnimation() {
        if (curTipIndex % 2 == 0) {
            updateTip(tv_tip_out)
            tv_tip_in!!.startAnimation(anim_out)
            tv_tip_out!!.startAnimation(anim_in)
            this.bringChildToFront(tv_tip_in)
        } else {
            updateTip(tv_tip_in)
            tv_tip_out!!.startAnimation(anim_out)
            tv_tip_in!!.startAnimation(anim_in)
            this.bringChildToFront(tv_tip_out)
        }
    }

    private fun updateTip(tipView: TextView?) {
//        if (Random().nextBoolean()) {
//            tipView!!.setCompoundDrawables(head_icon, null, null, null)
//        }
        val tip = nextTip
        if (!TextUtils.isEmpty(tip)) {
            tipView!!.text = Html.fromHtml( tip!!)
        }
    }

    fun setTipList(tipList: List<String>) {
        this.tipList = tipList
        curTipIndex = 0
        updateTip(tv_tip_out)
        updateTipAndPlayAnimation()
    }

    companion object {
        private val ANIM_DELAYED_MILLIONS = 1 *1000
        /**  动画持续时长   */
        private val ANIM_DURATION = 1 * 800
        private var DEFAULT_TEXT_COLOR = ColorUtil.getColor(R.color.grayThree)
        private val DEFAULT_TEXT_SIZE = 12
        fun isListEmpty(list: List<*>?): Boolean {
            return list == null || list.isEmpty()
        }
    }
}