package com.caidian310.view.custom

import android.content.Context
import android.util.AttributeSet
import com.github.lzyzsd.jsbridge.BridgeWebView
import android.support.v4.widget.SwipeRefreshLayout
import android.view.MotionEvent
import android.view.ViewGroup
import org.jetbrains.anko.switch


class BridgeWebViewRefresh : BridgeWebView {
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context?, attrs: AttributeSet?, defStyle: Int) : super(context, attrs, defStyle)
    constructor(context: Context?) : super(context)

    private var swipeRefreshLayout: SwipeRefreshLayout? = null

   fun setViewGroup(swipeRefreshLayout: SwipeRefreshLayout){
       this.swipeRefreshLayout = swipeRefreshLayout
   }


    override fun onScrollChanged(l: Int, t: Int, oldl: Int, oldt: Int) {
        super.onScrollChanged(l, t, oldl, oldt)
        if (this.scrollY == 0) {
            swipeRefreshLayout?.setEnabled(true)
        } else {
            swipeRefreshLayout?.setEnabled(false)
        }
    }
}