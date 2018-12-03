package com.caidian310.utils

import com.caidian310.R
import com.caidian310.application.MyApplication

/**
 *
 * 将颜色值转换为十六进制
 * Created by mac on 2017/11/16.
 */
object ColorUtil {


    /**
     * 颜色值转换为十六进制
     * @param resourcesId color资源文件的Id
     */
    fun getColor(resourcesId:Int=R.color.colorAccent) :Int = MyApplication.instance!!.resources.getColor(resourcesId)
}