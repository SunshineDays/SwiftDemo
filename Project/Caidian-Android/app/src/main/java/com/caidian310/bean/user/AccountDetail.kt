package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 * 用户详情信息
 * Created by mac on 2018/1/2.
 */

data class AccountDetailBean(
        var id: String,
        var balance: Double,    //余额
        var reward: Double,     //彩金奖励
        var bonus: Double,      //总中奖
        var recharge: Double,   //充值累计金额
        @SerializedName("order_num")var orderNumber :String, //订单号
        @SerializedName("user_id") var userId: Int,
        @SerializedName("balance_cost") var balanceCost: Double,  //	余额消费
        @SerializedName("reward_cost") var rewardCost: Double,    //	彩金消费
        @SerializedName("create_time") var createTime: Long,
        @SerializedName("update_time") var updateTime: Long
):Serializable