package com.caidian310.bean.sport.order

import com.google.gson.annotations.SerializedName

data class CopyOrderBean(
        var id:Int,
        @SerializedName("order_id") var orderId :Int,                 //订单
        var rate :Double,
        var follow :Int,
        @SerializedName("total_money") var totalMoney :Double,
        @SerializedName("follow_money") var followMoney :Double,       // 跟单金额
        @SerializedName("one_money") var oneMoney :Double,             //
        @SerializedName("end_time") var endTime :Long,                 //截止时间
        @SerializedName("create_time") var createTime :Long,
        @SerializedName("user_name") var userName :String,
        @SerializedName("user_avatar") var userAvatar :String,
        @SerializedName("user_id") var userId :Int,
        @SerializedName("week_statistics") var weekStatisticsBean :WeekStatisticsBean,
        var reason :String =""



)

data class WeekStatisticsBean(
        @SerializedName("nums") var number: Int =0,
        @SerializedName("winnums") var winNumber:Int =0
)