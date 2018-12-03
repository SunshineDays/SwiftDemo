package com.caidian310.utils

import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.widget.Toast
import com.caidian310.R
import com.caidian310.application.MyApplication


/**
 * Toast 工具
 * Created by mac on 2017/12/27.
 */
object  ToastUtil{

    var toast :Toast ?= null

    // 显示toast信息框时间
    val defateCalcelTime = 1000


    fun showToast(message:String){
        Toast.makeText(MyApplication.instance,message,Toast.LENGTH_SHORT).show()
    }


    /**
     * 自定义网络加载转圈
     * @param context   上下文
     * @param duration  展示时长  0  默认不取消 手动取消
     */
    fun toastLoading(context: Context,duration: Int = 0) :Toast{
        val inflater = MyApplication.instance.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val view = inflater.inflate(R.layout.layout_loading, null)
        if (toast == null) toast = Toast(context)
        toast!!.view = view
        toast!!.setGravity(Gravity.CENTER_VERTICAL,0,0)
        val time = if (duration ==0) defateCalcelTime else duration
        toast!!.duration = time
        return toast!!
    }



}
