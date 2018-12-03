package com.caidian310.utils

import java.util.regex.Pattern

/**
 * 监测是否合法
 * Created by mac on 2018/3/15.
 */
object ValidatorUtils{

    /**
     * 验证邮箱
     */
    fun isEmail(str: String): Boolean {
        val regex = "^([\\w-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([\\w-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
        return match(regex, str)
    }

    /**
     * 验证IP地址
     */
    fun isIP(str: String): Boolean {
        val num = "(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)"
        val regex = "^$num\\.$num\\.$num\\.$num$"
        return match(regex, str)
    }

    /**
     * 验证网址Url
     */
    fun isUrl(str: String): Boolean {
        val regex = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
        return match(regex, str)
    }

    /**
     * 验证电话号码
     */
    fun IsTelephone(str: String): Boolean {
        val regex = "^(\\d{3,4}-)?\\d{6,8}$"
        return match(regex, str)
    }

    /**
     * 验证输入密码条件(字符与数据同时出现)
     */
    fun isPassword(str: String): Boolean {
        val regex = "[A-Za-z]+[0-9]"
        return match(regex, str)
    }

    /**
     * 验证输入密码长度 (6-18位)
     */
    fun isPasswordLength(str: String,startIndex:Int = 6,endIndex :Int = 16): Boolean {
        val regex = "^\\d{$startIndex,$endIndex}$"
        return match(regex, str)
    }

    /**
     * 验证输入邮政编号
     */
    fun isPostalcode(str: String): Boolean {
        val regex = "^\\d{6}$"
        return match(regex, str)
    }

    /**
     * 验证输入手机号码
     */
    fun isHandset(str: String): Boolean {
        val regex = "^[1]+[3,5]+\\d{9}$"
        return match(regex, str)
    }

    /**
     * 验证输入身份证号
     */
    fun isIdCard(str: String): Boolean {
        val regex = "(^\\d{18}$)|(^\\d{15}$)"
        return match(regex, str)
    }


    /**
     * @param regex
     */
    private fun match(regex: String, str: String): Boolean {
        val pattern = Pattern.compile(regex)
        val matcher = pattern.matcher(str)
        return matcher.matches()
    }


}
