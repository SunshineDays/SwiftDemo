package com.caidian310.bean.sport.baskball
import com.google.gson.annotations.SerializedName


/**
 * 竞彩篮球对阵 网络请求结构
 * Created by mac on 2018/1/10.
 */

data class RequestBasketballBean(

		@SerializedName("id") var id: Int,
		@SerializedName("issue") var issue: String,
		@SerializedName("home") var home: String,
		@SerializedName("away") var away: String,
		@SerializedName("color") var color: String,
		@SerializedName("home3") var home3: String,
		@SerializedName("away3") var away3: String,
		@SerializedName("league_full_name") var leagueFullName: String,
		@SerializedName("league_name") var leagueName: String,
		@SerializedName("match_time") var matchTime: Long,
		@SerializedName("score_one") var scoreOne: String,
		@SerializedName("score_two") var scoreTwo: String,
		@SerializedName("score_third") var scoreThird: String,
		@SerializedName("score_fourth") var scoreFourth: String,
		@SerializedName("score_ot") var scoreOt: String,
		@SerializedName("score") var score: String,
		@SerializedName("xid") var xid: String,
		@SerializedName("status") var status: Int,
		@SerializedName("check_status") var checkStatus: Int,
		@SerializedName("result_status") var resultStatus: Int,
		@SerializedName("jc_id") var jcId: Int,
		@SerializedName("sale_end_time") var saleEndTime: Long,
		@SerializedName("let_ball") var letBall: Double,
		@SerializedName("dxf_num") var dxfNum: Double,
		@SerializedName("sf_fixed") var sfFixed: Int,
		@SerializedName("sf_single") var sfSingle: Int,
		@SerializedName("sfc_fixed") var sfcFixed: Int,
		@SerializedName("sfc_single") var sfcSingle: Int,
		@SerializedName("rfsf_fixed") var rfsfFixed: Int,
		@SerializedName("rfsf_single") var rfsfSingle: Int,
		@SerializedName("dxf_fixed") var dxfFixed: Int,
		@SerializedName("dxf_single") var dxfSingle: Int,
		@SerializedName("dxf_sp3") var dxfSp3: Double,
		@SerializedName("dxf_sp0") var dxfSp0: Double,
		@SerializedName("sfc_sp11") var sfcSp11: Double,
		@SerializedName("sfc_sp12") var sfcSp12: Double,
		@SerializedName("sfc_sp13") var sfcSp13: Double,
		@SerializedName("sfc_sp14") var sfcSp14: Double,
		@SerializedName("sfc_sp15") var sfcSp15: Double,
		@SerializedName("sfc_sp16") var sfcSp16: Double,
		@SerializedName("sfc_sp01") var sfcSp01: Double,
		@SerializedName("sfc_sp02") var sfcSp02: Double,
		@SerializedName("sfc_sp03") var sfcSp03: Double,
		@SerializedName("sfc_sp04") var sfcSp04: Double,
		@SerializedName("sfc_sp05") var sfcSp05: Double,
		@SerializedName("sfc_sp06") var sfcSp06: Double,
		@SerializedName("sf_sp3") var sfSp3: Double,
		@SerializedName("sf_sp0") var sfSp0: Double,
		@SerializedName("rfsf_sp3") var rfsfSp3: Double,
		@SerializedName("rfsf_sp0") var rfsfSp0: Double,
		@SerializedName("serial") var serial: String
)
