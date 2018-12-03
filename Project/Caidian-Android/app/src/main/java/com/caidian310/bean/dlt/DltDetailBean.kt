package com.caidian310.bean.dlt

import com.google.gson.annotations.SerializedName

/**
 * 大乐透详情
 * Created by mac on 2018/1/24.
 */
data  class DltDetailBean(
        var id :Int,
        @SerializedName("lottery_id") var lotteryId :Int,
        var name:String,
        @SerializedName("sale_end_time") var saleEndTime :Long,
        @SerializedName("single_end_time") var singleEndTime :Long,
        @SerializedName("multiple_end_time") var multipleEndTime :Long,
        @SerializedName("is_current") var isCurrent :Int,
        @SerializedName("allow_buy") var allowBuy :Int,
        @SerializedName("allow_ticket") var allowTicket :Int,
        @SerializedName("is_over") var isOver :Int,
        @SerializedName("open_code") var openCode :String,
        @SerializedName("is_confirm") var idConfirm :Int,
        var bonus :DltBonusBean
        )
