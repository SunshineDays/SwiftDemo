package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName

/**
 *
 * 真实信息bean
 * Created by mac on 2018/3/15.
 */
data class RealAuthBean(
        @SerializedName("bank_branch") var bankBranch: String ="",
        @SerializedName("bank_city") var bankCity: Int,
        @SerializedName("bank_code") var bankCode: String ="",
        @SerializedName("bank_id") var bankId: Int = -1,
        @SerializedName("bank_province") var bankProvince: Int,
        @SerializedName("card_code") var cardCode: String,
        @SerializedName("create_time") var createTime: Long,
        @SerializedName("id") var id: Int,
        @SerializedName("real_name") var realName: String,
        @SerializedName("update_time") var updateTime:Long,
        @SerializedName("user_id") var customUserId: Int
)