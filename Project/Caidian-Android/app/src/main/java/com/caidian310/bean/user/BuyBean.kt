package com.caidian310.bean.user
import com.google.gson.annotations.SerializedName
import java.io.Serializable


/**
 * 购买信息
 * Created by mac on 2018/1/2.
 */

data class BuyBean(
		 var id: Int,
		@SerializedName("order_id") var orderId: String,    //订单id
		@SerializedName("user_id") var userId: Int,         //用户Id
		@SerializedName("buy_count") var buyCount: Int,      //购买注数
  		@SerializedName("buy_money") var buyMoney: Double,   //购买金额(包含彩金)
		@SerializedName("buy_time") var buyTime: Long,       //购买时间
		@SerializedName("buy_type") var buyType: String,      //1 发起认购,2 保底认购,3 追号认购,4 自动跟单认购,5 参与认购
		 var source: Int,                                            //购买来源:0 平台认购,1 活动认购
		 var bonus: Double,                                          //奖金
		@SerializedName("send_prize") var sendPrize: Int,       //奖金派送标识:0 未派奖,1 已派奖
		@SerializedName("revoke_status") var revokeStatus: Int,// 撤单类型:0 未撤单,1 发起人撤单,2 系统撤单,3 参与人撤单
		@SerializedName("reward_money") var rewardMoney: Int,  // 彩金消费
		@SerializedName("create_time") var createTime: Long    //订单创建时间
):Serializable