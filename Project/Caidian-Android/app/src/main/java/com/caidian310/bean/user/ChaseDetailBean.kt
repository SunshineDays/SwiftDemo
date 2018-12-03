package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.buy.ChaseBean
import com.caidian310.bean.buy.PayCodeBean

/**
 * 追号详情 实体类
 * Created by mac on 2018/2/1.
 */
data class ChaseDetailBean(
        var chase :ChaseBean,
        var code : PayCodeBean,
        @SerializedName("detail_list") var detailList : ArrayList<ChaseDetail>
)

data class ChaseDetail(
        @SerializedName("id") var id: Int,
        @SerializedName("chase_id") var chaseId: Int,
        @SerializedName("order_id") var orderId: Int,
        @SerializedName("num") var num: Int,
        @SerializedName("issue") var issue: String,
        @SerializedName("multiple") var multiple: Int,
        @SerializedName("money") var money: String,
        @SerializedName("status") var status: Int,
        @SerializedName("bet_time") var betTime: Int,
        @SerializedName("ticket_status") var ticketStatus: Int,
        @SerializedName("win_status") var winStatus: Int,
        @SerializedName("bonus") var bonus: Double,
        @SerializedName("open_code") var openCode: String

)
