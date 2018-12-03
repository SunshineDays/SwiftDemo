package com.caidian310.bean.user
import com.google.gson.annotations.SerializedName
import java.io.Serializable


/**
 * 订单信息
 * Created by mac on 2018/1/2.
 */

data class OrderBean(
		var id: Int,
		@SerializedName("order_num") var orderNum: String,
		@SerializedName("user_id") var userId: Int,        //用户Id
		@SerializedName("nickname") var nickName: String, //用户名
		@SerializedName("lottery_id") var lotteryId: Int,  //彩种id
		@SerializedName("play_id") var playId: Int,        //玩法类型
		@SerializedName("issue_id") var issueId: Int,      //旗号Id
		@SerializedName("issue") var issue: String,        //期号
		@SerializedName("chase_id") var chaseId: Int,      //
		@SerializedName("multiple") var multiple: Int,     //倍数
		@SerializedName("bet_count") var betCount: Int,
		@SerializedName("total_money") var totalMoney: Double,         //总投注金额
		@SerializedName("single_money") var singleMoney: Double,       //单注金额 大乐透追加3元其余都2元
		@SerializedName("is_upload") var isUpload: Long,
		@SerializedName("upload_time") var uploadTime: Long,
		@SerializedName("file_path") var filePath: String,
		@SerializedName("source") var source: String,
		@SerializedName("ticket_status") var ticketStatus: Int,     //出票状态:0 未出票,1 出票中,2 出票成功,3 出票失败
		@SerializedName("ticket_time") var ticketTime: Long,        //出票时间
		@SerializedName("task_count") var taskCount: String,
		@SerializedName("revoke_status") var revokeStatus: Int,     //撤单标识:0 未撤单,1 发起人撤单,2 系统撤单
		@SerializedName("bonus") var bonus: Double,                 //奖金
		@SerializedName("margin") var margin: Double,               //毛利润
		@SerializedName("order_type") var orderType: Int ,           //订单类型:0:代购,1:合买,2:追号
		@SerializedName("send_prize") var sendPrize: Double,
		@SerializedName("send_admin_id") var sendAdminId: Int,
		@SerializedName("win_status") var winStatus: Int,             //中奖状态:0 暂未开奖,1 未中奖,2 已中奖
		@SerializedName("clearing") var clearing: Int,
		@SerializedName("match_ids") var matchIds: String,            //赛事id
		@SerializedName("first_match_end") var firstMatchEnd: Long,
		@SerializedName("series") var series: String,                 //串关
		@SerializedName("create_time") var createTime: Long,          //创建时间
		@SerializedName("is_secret") var isSecret: Int,              // 0: 公开无佣金 ,1:截止后公开无佣金
		@SerializedName("update_time") var updateTime: Long,
		@SerializedName("copy_order_id") var copyOrderId: Int
):Serializable