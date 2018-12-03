package com.caidian310.http

import com.caidian310.utils.AppVersion
import com.caidian310.utils.DbUtil
import com.loopj.android.http.RequestParams
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

/**
 * 网络请求参数签名和封装
 * Created by mac on 2017/11/13.
 */
class SignParams {
    private val PRIVATEKEY = "@(caidian310#@!)@"

    /** 随即字符串  */
    private var signString = arrayOf("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s",
            "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b",
            "n", "m", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Q",
            "W", "E", "R", "T", "Y", "U", "I", "O", "P", "Z", "X", "C",
            "V", "B", "N", "M")

    /**
     * @param map  参数
     * @return
     */
    fun createSign(map: HashMap<String, Any>?) : RequestParams {


        map?.putAll(getSignApiParams())
        var parameter  = RequestParams()
        map?.let {
            val keySet = map.keys
            val list = ArrayList(keySet)
            list.sort()
            var sign = ""
            for (key in  list){
                sign += key + PRIVATEKEY + map[key]
                parameter.add(key,map[key].toString())

            }

            parameter.put("sign",md5(string = sign))
        }


        return  parameter

    }


    /**
     * 获取八位随机字符串
     * @return
     */
    private fun getRandomString(): String {
        var randomString = ""
        for (i in 0..7) {
            randomString += signString[Random().nextInt(signString.count())]
        }
        return randomString
    }

    /**
     *  md5 算法签名
     *
     */
    private fun md5(string: String): String {
        try {
            val instance: MessageDigest = MessageDigest.getInstance("MD5")//获取md5加密对象
            val digest: ByteArray = instance.digest(string.toByteArray())//对字符串加密，返回字节数组
            var sb = StringBuffer()
            for (b in digest) {
                var i: Int = b.toInt() and 0xff//获取低八位有效值
                var hexString = Integer.toHexString(i)//将整数转化为16进制
                if (hexString.length < 2) {
                    hexString = "0" + hexString//如果是一位的话，补0
                }
                sb.append(hexString)
            }
            return sb.toString()

        } catch (e: NoSuchAlgorithmException) {
            return ""
        }

    }


    /**
     * API请求规则
     */

    private fun getSignApiParams(): HashMap<String, String> {

        val hashMap = HashMap<String,String>()
        hashMap.put("p", "a")                                       //平台  i:iphone a:android
        hashMap.put("r", getRandomString())                         //随机字符串   8位
        hashMap.put("t", System.currentTimeMillis().toString())     //t        	   时间戳
        hashMap.put("v", AppVersion.versionCode.toString())         //v            app版本
        hashMap.put("token", DbUtil().getUserBean().token)          //token     app版本
        return hashMap
    }


}