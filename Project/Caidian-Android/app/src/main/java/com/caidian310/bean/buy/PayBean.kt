package com.caidian310.bean.buy
import com.google.gson.annotations.SerializedName


/**
 * 交易详情
 * Created by mac on 2018/1/3.
 */
data class PayBean(
        var id: Int,
		@SerializedName("user_id") var userId: Int,              //用户id
		@SerializedName("in_out") var inOut: Int,                //交易类型 -1:支出 1:收入
		@SerializedName("trade_parent_id") var tradeParentId: Int, //交易类型父级id
		@SerializedName("trade_id") var tradeId: Int,            //交易类型id
		@SerializedName("resource_id") var resourceId: Int,      //对应此记录的资源id
		@SerializedName("issue") var issue: String,              //旗号
		@SerializedName("lottery_id") var lotteryId: Int,        //彩种id
		@SerializedName("pay_code") var payCode: String,         //交易编号
		@SerializedName("pay_money") var payMoney: Double,       //支付金额 或彩金
		@SerializedName("pay_poundage") var payPoundage: Double, //手续费
		@SerializedName("balance") var balance: Double,          //交易后余额
		@SerializedName("reward") var reward: Double,            //交易后彩金
		@SerializedName("remark") var remark: String,            //备注
		@SerializedName("admin_id") var adminId: String,
		@SerializedName("admin_name") var adminName: String,
		@SerializedName("money_type") var moneyType: String,     //类型 1 余额 2 彩金
		@SerializedName("create_time") var createTime: Long,
		@SerializedName("trade_name") var tradeName: String      //交易类型名字
)