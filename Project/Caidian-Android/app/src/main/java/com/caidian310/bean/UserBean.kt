package com.caidian310.bean

import com.google.gson.annotations.SerializedName


/**
 * 用户基本信息
 * Created by mac on 2017/11/10.
 */
data class UserBean(

        var id: Int =0,
        var phone: String = "",
        @SerializedName("nickname") var nickName: String = "",
        @SerializedName("user_type") var userType: String = "",
        var avatar: String = "",
        var email: String = "",
        var qq: String = "",
        var gender: String = "",
        @SerializedName("last_login_time") var lastLoginTime: String = "",
        var status: String = "",
        @SerializedName("is_kill") var isKill: String = "",
        @SerializedName("create_time") var createTime: String = "",
        @SerializedName("update_time") var updateTime: String = "",
        @SerializedName("parent_id") var parentId: String = "",
        @SerializedName("is_bind_bank") var isBindBank: Int = 0,
        @SerializedName("is_real_name") var isRealName: Int = 0,
        var token: String = ""

)
