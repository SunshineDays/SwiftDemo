package com.caidian310.bean.sport
import com.google.gson.annotations.SerializedName


/**
 * Created by mac on 2018/3/6.
 */


data class SfcMatchBean(
		@SerializedName("id") var id: Int,
		@SerializedName("lottery_id") var lotteryId: Int,
		@SerializedName("issue") var issue: String,
		@SerializedName("xid") var xid: Int,
		@SerializedName("home") var home: String,
		@SerializedName("away") var away: String,
		@SerializedName("match_time") var matchTime: Long,
		@SerializedName("score_half") var scoreHalf: String,
		@SerializedName("score") var score: String,
		@SerializedName("color") var color: String,
		@SerializedName("league_name") var leagueName: String,
		@SerializedName("status") var status: Int,
		@SerializedName("home3") var home3: String,
		@SerializedName("away3") var away3: String
){

		fun getMatchBean(sfcMatchBean: SfcMatchBean) =
				MatchBean(
						id = sfcMatchBean.id,
						lotteryId = sfcMatchBean.lotteryId,
						issue =  sfcMatchBean.issue,
						xid = sfcMatchBean.xid,
						home = sfcMatchBean.home,
						away =  sfcMatchBean.away,
						matchTime = sfcMatchBean.matchTime,
						scoreHalf = sfcMatchBean.scoreHalf,
						score = sfcMatchBean.score,
						color = sfcMatchBean.color,
						leagueName = sfcMatchBean.leagueName,
						status =  sfcMatchBean.status,
						home3 = sfcMatchBean.home3,
						away3 = sfcMatchBean.away3,
						betList = arrayListOf()
				)

}
