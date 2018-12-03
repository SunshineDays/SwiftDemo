package com.caidian310.bean.buy

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.IssueBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.bean.user.BuyBean
import com.caidian310.bean.user.OrderBean


/**
 * 订单详情
 * Created by mac on 2018/1/3.
 */

data class PayDetailBean(
        var buy: BuyBean,
        var order: OrderBean,
        var code: PayCodeBean,
        var issue: IssueBean,
        var parent :OrderBean
)



data class PayCodeBean(
        var multiple: Int = 1, //倍数
        @SerializedName("bet_count") var betCount: Int = 0,                //注数
        @SerializedName("total_money") var totalMoney: Double = 0.00,      //总金额
        @SerializedName("serial_list") var serialList: ArrayList<String>,   //串关方式 1串1 2串1
        @SerializedName("match_list") var matchList: ArrayList<PayMatch>,  //投注赛事列表

        @SerializedName("issue") var issue: String,                 //期号
        @SerializedName("issue_id") var issueId: Int,               //旗号Id
        @SerializedName("user_id") var userId: Int,
        @SerializedName("play_id") var playId: Int,
        @SerializedName("lottery_id") var lotteryId: Int,           //彩种id
        @SerializedName("id") var id: Int,                          //旗号Id
        @SerializedName("order_id") var orderId: Int,               //期号
        @SerializedName("create_time") var createTime: Long,        //期号
        @SerializedName("single_money") var singleMoney: Double,       //期号
        @SerializedName("bet_list") var betList: ArrayList<ArrayList<Section>>,    //投注记录
        @SerializedName("chase_list") var chaseList : ArrayList<Chase>,            //期号列表
        @SerializedName("is_secret") var isSecret :Int                             //是否可显示 0 可以 1不可以

)


data class PayMatch(
        var match: Match,
        @SerializedName("bet_info") var betInfo: PayBetInfo
)

data class PayBetInfo(
        @SerializedName("bet_list") var betList: ArrayList<Bet>,
        var id: Int,
        @SerializedName("is_must_bet") var isMustBet: Boolean,
        @SerializedName("let_ball") var letBall: Double
)