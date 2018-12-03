package com.caidian310.bean.enumBean

/**
 * description :  验证码类型 1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
 * Created by wdb on 2017/6/29.
 */

enum class CodeTypeEnum(val type:Int) {
    Register(type = 1),            //注册
    ForgetPassword(type = 2),      //忘记密码
    UpdatePhone(type = 3),         //更换手机
    LoginCode(type = 4),           //登录
    UpdatePassword(type = 5);      //修改密码
}

