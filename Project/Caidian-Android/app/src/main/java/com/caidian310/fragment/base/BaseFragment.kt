package com.caidian310.fragment.base


import android.support.v4.app.Fragment
import android.view.View
import android.widget.Toast
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.http.HttpUtil
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode


/**
 * Fragment 基类
 */
open class BaseFragment : Fragment() ,View.OnClickListener{

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


    override fun onClick(v: View?) {

    }


    override fun onAttachFragment(childFragment: Fragment?) {
        super.onAttachFragment(childFragment)
        showToast("颠三倒四多")
    }

    @Subscribe(threadMode = ThreadMode.MAIN, sticky = true) //在ui线程执行
    open fun getEventData(event: EventBusBean){}
    /**
     * 注册eventBus
     */
    open fun registerEventBus(){
        EventBus.getDefault().register(this)
    }
    /**
     * 解除注册eventBus
     */
    open fun unregisterEventBus(){
        EventBus.getDefault().unregister(this)
    }


    fun  showToast(message:String){
        Toast.makeText(context,message,Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
        super.onDestroy()
        HttpUtil.cancelRequests(context!!)
    }

}
