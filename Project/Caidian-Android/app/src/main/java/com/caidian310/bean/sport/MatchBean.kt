package com.caidian310.bean.sport
import com.google.gson.annotations.SerializedName
import com.caidian310.bean.sport.football.BetBean


/**
 * Created by mac on 2018/3/6.
 */


data class MatchBean(
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
		@SerializedName("away3") var away3: String,
		var betList : ArrayList<BetBean>
)
