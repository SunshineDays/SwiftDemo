package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName

data class RechargeBean(
        var id:Int,
        var name :String,
        var key:String,
        var description:String,
        var merchant :String,
        var logo :String ?=null,
        @SerializedName("max_amount") var maxAmount:Int =0,
        @SerializedName("in_out") var inOut:Int =0,
        @SerializedName("is_recommend") var isRecommend :Int =0,
        @SerializedName("is_show") var isKill :Int =0
)