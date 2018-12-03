package com.caidian310.bean.buy

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.user.AccountDetailBean
import com.caidian310.bean.user.BuyBean
import com.caidian310.bean.user.OrderBean
import java.io.Serializable

/**
 * 购买成功Bean
 * Created by mac on 2018/1/15.
 */
data class PaySuccessDetailBean(
        var account: AccountDetailBean,
        var order: OrderBean,
        var buy: BuyBean,
        var chase: ChaseBean
) : Serializable


/**
 * 追号信息
 */
data class ChaseBean(
        var id: Int,
        @SerializedName("lottery_id") var lotteryId: Int,
        @SerializedName("user_id") var userId: Int,
        @SerializedName("cancel_count") var cancelCount: Int,       //取消的期次数
        @SerializedName("finish_count") var finishCount: Int,       //已完成期次数
        @SerializedName("total_count") var totalCount: Int,         //总追号期次数
        @SerializedName("freeze_money") var freezeMoney: Double,    //总冻结金额
        @SerializedName("cost_money") var costMoney: Double,        //已花费金额
        @SerializedName("total_money") var totalMoney: Double,      //总金额(单注金额*总注数*总倍数)
        @SerializedName("cancel_money") var cancelMoney: Double,    //中奖停止追号的奖金额
        @SerializedName("total_bonus") var totalBonus: Double,      //总奖金
        @SerializedName("is_hit_stop") var isHitStop: Int,          //中奖后停止追号
        @SerializedName("status") var status: Int,                  //状态(0:追号中;1:到期停止;2:中奖停止;3:用户取消;4:系统取消
        @SerializedName("end_time") var endTime: Long,              //任务停止的时间
        @SerializedName("create_time") var createTime: Long,         //追号任务发起时间
        @SerializedName("chase_num") var chaseNum: String
        ) : Serializable