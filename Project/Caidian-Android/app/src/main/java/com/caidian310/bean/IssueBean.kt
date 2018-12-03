package com.caidian310.bean

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 * 期号
 * Created by mac on 2018/1/22.
 */

data class IssueBean(
        var id: Int,        //Id
        @SerializedName("lottery_id") var lotteryId: Int,
        var name: String,                                                       //期号
        @SerializedName("sale_end_time") var saleEndTime: Long,           //官方截止时间
        @SerializedName("single_end_time") var singleEndTime: Long,       //系统单式截止时间
        @SerializedName("multiple_end_time") var multipleEndTime: Long,   //系统复式截止时间
        @SerializedName("is_current") var isCurrent: Int,                 //当前期
        @SerializedName("allow_buy") var allowBuy: Int,                   //0 不让购买 1 可以购买
        @SerializedName("allow_ticket") var allowTicket: Int,             //0 可以出票 1 不能出票
        @SerializedName("is_over") var isOver: Int,                       //结算标志
        @SerializedName("open_code") var openCode: String,                //开奖
        @SerializedName("is_confirm") var isConfirm: Int,                 //是否确认开奖
        @SerializedName("create_time") var createTime: Int
):Serializable
