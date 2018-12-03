package com.caidian310.activity.base

import android.content.pm.ActivityInfo
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.support.v7.app.ActionBar
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar
import android.text.TextUtils
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import com.caidian310.R
import com.caidian310.application.MyApplication
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.http.HttpUtil
import com.caidian310.utils.ActivityManagerUtil
import com.caidian310.view.popupWindow.LoadingPopupWindow
import com.umeng.analytics.MobclickAgent
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode


open class BaseActivity : AppCompatActivity(), View.OnClickListener {


    private var actionBar: ActionBar? = null
    var centerTxt: TextView? = null
    var leftImg: ImageView? = null
    var rightImg: ImageView? = null
    var rightTxt: TextView? = null
    var leftTxt: TextView? = null

     var loadingView: LoadingPopupWindow? = null

    var  toastLoading :Toast ?= null

    public override fun onCreate(savedInstanceState: Bundle?) {
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT     //禁止横屏
        super.onCreate(savedInstanceState)

        ActivityManagerUtil.instance.addActivity(this)
        loadingView = LoadingPopupWindow(this)

    }


    /**
     * 使用默认的actionBar布局
     * @param centerTitle 中间的提示title
     * @param rightTitle 右边的提示title 默认隐藏
     */
    fun initActionBar(leftTitle: String? = null, centerTitle: String, rightTitle: String? = null) {

        var defaultView: View = LayoutInflater.from(baseContext).inflate(R.layout.bar_base, null)
        centerTxt = defaultView.findViewById(R.id.bar_center_title)
        leftImg = defaultView.findViewById(R.id.bar_back)
        rightImg = defaultView.findViewById(R.id.bar_right_img)
        rightTxt = defaultView.findViewById(R.id.bar_right_title)
        leftTxt = defaultView.findViewById(R.id.bar_left_title)
        centerTxt?.text = centerTitle
        if (rightTitle == null) rightTxt?.visibility = View.GONE
        leftTxt?.visibility = if (leftTitle == null) View.GONE else View.VISIBLE
        rightTxt?.text = rightTitle
        leftTxt?.text = leftTitle
        rightImg?.visibility = View.GONE

        leftImg?.setOnClickListener(this)
        rightImg?.setOnClickListener(this)
        leftImg?.setColorFilter(Color.WHITE)
        rightImg?.setColorFilter(Color.WHITE)
        initActionBarView(defaultView)

    }


    /** 初始化参数 */
    open fun initView() {}


    /**
     * 交互处理
     */
    open fun initEvent() {}


    /**
     * 监听事件处理
     */
    open fun initListener() {}


    override fun finish() {
        super.finish()
        ActivityManagerUtil.instance.popActivity()
    }


    @Subscribe(threadMode = ThreadMode.MAIN, sticky = true) //在ui线程执行
    open fun onDataSynEvent(event: EventBusBean) {
    }

    /**
     * 注册eventBus
     */
    open fun registerEventBus() {
        EventBus.getDefault().register(this)
    }

    /**
     * 解除注册eventBus
     */
    open fun unregisterEventBus() {
        EventBus.getDefault().unregister(this)
    }

    /**
     *
     */

    open fun postEvent(event: EventBusBean){
        EventBus.getDefault().post(event)
    }


    /**
     * 隐藏activityBar
     */
    fun hintActionBar() {
        actionBar = supportActionBar
        actionBar?.hide()
    }


    /**
     * @param view  自定义的actionBar
     */
    fun initActionBarView(view: View) {
        var actionBar = this.supportActionBar
        actionBar?.displayOptions = ActionBar.DISPLAY_SHOW_CUSTOM
        actionBar?.setDisplayShowCustomEnabled(true)
        actionBar?.customView = view
        val parent = view.parent as Toolbar
        parent.setContentInsetsAbsolute(0, 0)
        // 消除阴影
        if (Build.VERSION.SDK_INT >= 21) actionBar?.elevation = 0f

    }


    override fun onClick(v: View?) {
        if (v?.id == R.id.bar_back) finish()
    }

    /**  Toast 消息message */
    fun showToast(message: String?) {
        if (TextUtils.isEmpty(message)) return
        MyApplication.instance.showToast(message)
    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == KeyEvent.KEYCODE_BACK) {
            // 左上角和虚拟回退键 事件处理
            finish()
            return true
        }
        return super.onOptionsItemSelected(item)
    }


    override fun onDestroy() {
        super.onDestroy()
        toastLoading?.cancel()
        HttpUtil.cancelRequests(this)
    }

    override fun onResume() {
        super.onResume()
        MobclickAgent.onResume(this)
    }


    override fun onPause() {

        super.onPause()
        MobclickAgent.onPause(this)
    }



}
