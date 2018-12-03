package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName

/**
 * 获取验证码
 * Created by mac on 2017/12/23.
 */
data class CodeBean(
        var code:String,
        @SerializedName("is_user")var isUser:Int,
        var phone:String

)