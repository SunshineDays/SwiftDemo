package com.caidian310.bean.sport.football

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 * 该场比赛的详情 不涉及选项 填充map的key
 * Created by mac on 2017/12/5.
 */
data class Match(

        @SerializedName("id") var id: Int,
        @SerializedName("xid") var xid: String,
        @SerializedName("league_full_name") var leagueFullName: String,
        @SerializedName("league_name") var leagueName: String,
        @SerializedName("home") var home: String,
        @SerializedName("away") var away: String,
        @SerializedName("away3") var away3: String,
        @SerializedName("home3") var home3: String,
        @SerializedName("match_time") var matchTime: Long,
        @SerializedName("sale_end_time") var saleEndTime: Long,
        @SerializedName("let_ball") var letBall: Double,
        @SerializedName("color") var color: String,
        @SerializedName("issue") var issue: String,
        @SerializedName("score") var score: String,
        @SerializedName("score_half") var scoreHalf: String,
        @SerializedName("status") var status: Int,
        @SerializedName("check_status") var checkStatus: Int,
        @SerializedName("result_status") var resultStatus: Int,
        @SerializedName("spf_fixed") var spfFixed: Int,
        @SerializedName("rqspf_fixed") var rqspfFixed: Int,
        @SerializedName("bqc_fixed") var bqcFixed: Int,
        @SerializedName("jqs_fixed") var jqsFixed: Int,
        @SerializedName("bf_fixed") var bfFixed: Int,
        @SerializedName("spf_single") var spfSingle: Int,
        @SerializedName("rqspf_single") var rqspfSingle: Int,
        @SerializedName("bf_single") var bfSingle: Int,
        @SerializedName("bqc_single") var bqcSingle: Int,
        @SerializedName("jqs_single") var jqsSingle: Int,
        @SerializedName("jc_id") var jcId: Int,

        @SerializedName("score_one") var scoreOne: String = "",
        @SerializedName("score_two") var scoreTwo: String = "",
        @SerializedName("score_third") var scoreThird: String ="",
        @SerializedName("score_fourth") var scoreFourth: String ="",
        @SerializedName("score_ot") var scoreOt: String = "",
        @SerializedName("dxf_num") var dxfNum: Double = 0.00,
        @SerializedName("sf_fixed") var sfFixed: Int = 0,
        @SerializedName("sf_single") var sfSingle: Int = 0,
        @SerializedName("sfc_fixed") var sfcFixed: Int = 1,
        @SerializedName("sfc_single") var sfcSingle: Int= 0,
        @SerializedName("rfsf_fixed") var rfsfFixed: Int = 0,
        @SerializedName("rfsf_single") var rfsfSingle: Int = 0,
        @SerializedName("dxf_fixed") var dxfFixed: Int = 1,
        @SerializedName("dxf_single") var dxfSingle: Int = 1,

        var serial: String,
        var wave: Boolean = false,         // 该场比赛是否支持显示选择波胆
        var clickWave: Boolean = false     // 该场比赛是选择了波胆

) : Serializable