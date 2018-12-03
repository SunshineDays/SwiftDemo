package com.caidian310.http
import java.io.File
import java.util.*


/**
 * Created by wdb on 2016/9/27.
 * 参数封装
 * path baseUrl后面的路径
 * jsonObject 以Json格式给后台传值
 * method  网络请求方式  post ? get
 */

data class HttpParameter(
        var path: String? = null,                   //拼接路径
        val hashMap: HashMap<String, Any>? = null,          //参数
        val method: HttpMethod = HttpMethod.POST,    //网络请求方式
        var cacheTime: Int = 0,                    // 设置缓存更新时间
        var file: File ?= null
)

