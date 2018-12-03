package com.caidian310.bean.sport.baskball

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.buy.Bet
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match


/**
 * 竞彩篮球对阵 网络请求结构
 * Created by mac on 2018/1/10.
 */

data class BasketballBean(

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
        @SerializedName("dxf_sp3") var dxfSp3: BetBean,
        @SerializedName("dxf_sp0") var dxfSp0: BetBean,
        @SerializedName("sfc_sp11") var sfcSp11: BetBean,
        @SerializedName("sfc_sp12") var sfcSp12: BetBean,
        @SerializedName("sfc_sp13") var sfcSp13: BetBean,
        @SerializedName("sfc_sp14") var sfcSp14: BetBean,
        @SerializedName("sfc_sp15") var sfcSp15: BetBean,
        @SerializedName("sfc_sp16") var sfcSp16: BetBean,
        @SerializedName("sfc_sp01") var sfcSp01: BetBean,
        @SerializedName("sfc_sp02") var sfcSp02: BetBean,
        @SerializedName("sfc_sp03") var sfcSp03: BetBean,
        @SerializedName("sfc_sp04") var sfcSp04: BetBean,
        @SerializedName("sfc_sp05") var sfcSp05: BetBean,
        @SerializedName("sfc_sp06") var sfcSp06: BetBean,
        @SerializedName("sf_sp3") var sfSp3: BetBean,
        @SerializedName("sf_sp0") var sfSp0: BetBean,
        @SerializedName("rfsf_sp3") var rfsfSp3: BetBean,
        @SerializedName("rfsf_sp0") var rfsfSp0: BetBean,
        @SerializedName("serial") var serial: String


) {
    fun getMatchBean(): Match {
        return Match(
                id = this.id,
                issue = this.issue,
                home = this.home,
                away = this.away,
                color = this.color,
                home3 = this.home3,
                away3 = this.away3,

                leagueFullName = this.leagueFullName,
                leagueName = this.leagueName,
                matchTime = this.matchTime,
                scoreOne = this.scoreOne,
                scoreTwo = this.scoreTwo,
                scoreThird = this.scoreThird,
                scoreFourth = this.scoreFourth,
                scoreOt = this.scoreOt,
                score = this.score,
                xid = this.xid,
                status = this.status,

                checkStatus = this.checkStatus,
                resultStatus = this.resultStatus,
                jcId = this.jcId,
                saleEndTime = this.saleEndTime,
                letBall = this.letBall,
                dxfNum = this.dxfNum,
                sfFixed = this.sfFixed,
                scoreHalf = "",
                spfSingle = 0,
                spfFixed = 0,
                rqspfSingle = 0,
                rqspfFixed = 0,
                bqcSingle = 0,
                bqcFixed = 0,
                jqsSingle = 0,
                jqsFixed = 0,
                bfSingle = 0,
                bfFixed = 0,

                sfcFixed = this.sfcFixed,
                sfSingle = this.sfSingle,
                sfcSingle = this.sfcSingle,
                rfsfFixed = this.rfsfFixed,
                rfsfSingle = this.rfsfSingle,
                dxfFixed = this.dxfFixed,
                dxfSingle = this.dxfSingle,
                wave = false,
                serial = this.serial,
                clickWave = false

        )
    }
}

class BasketballHelp {
    fun getBasketBallBean(requestBasketballBean: RequestBasketballBean): BasketballBean {
        return BasketballBean(
                id = requestBasketballBean.id,
                issue = requestBasketballBean.issue,
                home = requestBasketballBean.home,
                away = requestBasketballBean.away,
                color = requestBasketballBean.color,
                home3 = requestBasketballBean.home3,
                away3 = requestBasketballBean.away3,

                leagueFullName = requestBasketballBean.leagueFullName,
                leagueName = requestBasketballBean.leagueName,
                matchTime = requestBasketballBean.matchTime,
                scoreOne = requestBasketballBean.scoreOne,
                scoreTwo = requestBasketballBean.scoreTwo,
                scoreThird = requestBasketballBean.scoreThird,
                scoreFourth = requestBasketballBean.scoreFourth,
                scoreOt = requestBasketballBean.scoreOt,
                score = requestBasketballBean.score,
                xid = requestBasketballBean.xid,
                status = requestBasketballBean.status,

                checkStatus = requestBasketballBean.checkStatus,
                resultStatus = requestBasketballBean.resultStatus,
                jcId = requestBasketballBean.jcId,
                saleEndTime = requestBasketballBean.saleEndTime,
                letBall = requestBasketballBean.letBall,
                dxfNum = requestBasketballBean.dxfNum,
                sfFixed = requestBasketballBean.sfFixed,

                sfSingle = requestBasketballBean.sfSingle,
                sfcFixed = requestBasketballBean.sfcFixed,
                sfcSingle = requestBasketballBean.sfcSingle,
                rfsfFixed = requestBasketballBean.rfsfFixed,
                rfsfSingle = requestBasketballBean.rfsfSingle,
                dxfFixed = requestBasketballBean.dxfFixed,
                dxfSingle = requestBasketballBean.dxfSingle,
                dxfSp3 = BetBean(key = "dxf_sp3", sp = requestBasketballBean.dxfSp3, status = false, jianChen = "大球${requestBasketballBean.dxfNum}",typeString = "大球${requestBasketballBean.dxfNum}"),
                dxfSp0 = BetBean(key = "dxf_sp0", sp = requestBasketballBean.dxfSp0, status = false, jianChen = "小球${requestBasketballBean.dxfNum}",typeString = "小球${requestBasketballBean.dxfNum}"),


                sfcSp11 = BetBean(key = "sfc_sp11", sp = requestBasketballBean.sfcSp11, status = false, jianChen = "1-5", typeString = "1-5"),
                sfcSp12 = BetBean(key = "sfc_sp12", sp = requestBasketballBean.sfcSp12, status = false, jianChen = "6-10", typeString = "6-10"),
                sfcSp13 = BetBean(key = "sfc_sp13", sp = requestBasketballBean.sfcSp13, status = false, jianChen = "11-15", typeString = "11-15"),
                sfcSp14 = BetBean(key = "sfc_sp14", sp = requestBasketballBean.sfcSp14, status = false, jianChen = "16-20", typeString = "16-20"),
                sfcSp15 = BetBean(key = "sfc_sp15", sp = requestBasketballBean.sfcSp15, status = false, jianChen = "21-25", typeString = "21-25"),
                sfcSp16 = BetBean(key = "sfc_sp16", sp = requestBasketballBean.sfcSp16, status = false, jianChen = "26+", typeString = "26+"),
                sfcSp01 = BetBean(key = "sfc_sp01", sp = requestBasketballBean.sfcSp01, status = false, jianChen = "1-5", typeString = "1-5"),
                sfcSp02 = BetBean(key = "sfc_sp02", sp = requestBasketballBean.sfcSp02, status = false, jianChen = "6-10", typeString = "6-10"),
                sfcSp03 = BetBean(key = "sfc_sp03", sp = requestBasketballBean.sfcSp03, status = false, jianChen = "11-15", typeString = "11-15"),
                sfcSp04 = BetBean(key = "sfc_sp04", sp = requestBasketballBean.sfcSp04, status = false, jianChen = "16-20", typeString = "16-20"),
                sfcSp05 = BetBean(key = "sfc_sp05", sp = requestBasketballBean.sfcSp05, status = false, jianChen = "21-25", typeString = "21-25"),
                sfcSp06 = BetBean(key = "sfc_sp06", sp = requestBasketballBean.sfcSp06, status = false, jianChen = "26+", typeString = "26+"),
                sfSp3 = BetBean(key = "sf_sp3", sp = requestBasketballBean.sfSp3, status = false, jianChen = "主胜", typeString = "主胜"),
                sfSp0 = BetBean(key = "sf_sp0", sp = requestBasketballBean.sfSp0, status = false, jianChen = "主负", typeString = "主负"),
                rfsfSp3 = BetBean(key = "rfsf_sp3", sp = requestBasketballBean.rfsfSp3, status = false, jianChen = "让分主胜", typeString = "主胜"),
                rfsfSp0 = BetBean(key = "rfsf_sp0", sp = requestBasketballBean.rfsfSp0, status = false, jianChen = "让分主负", typeString = "主负"),
                serial = requestBasketballBean.serial

        )
    }


    /**
     * 复制不同地址的Bean
     */
    fun copyBasketBallBean(basketballBean: BasketballBean): BasketballBean {
        return BasketballBean(
                id = basketballBean.id,
                issue = basketballBean.issue,
                home = basketballBean.home,
                away = basketballBean.away,
                color = basketballBean.color,
                home3 = basketballBean.home3,
                away3 = basketballBean.away3,

                leagueFullName = basketballBean.leagueFullName,
                leagueName = basketballBean.leagueName,
                matchTime = basketballBean.matchTime,
                scoreOne = basketballBean.scoreOne,
                scoreTwo = basketballBean.scoreTwo,
                scoreThird = basketballBean.scoreThird,
                scoreFourth = basketballBean.scoreFourth,
                scoreOt = basketballBean.scoreOt,
                score = basketballBean.score,
                xid = basketballBean.xid,
                status = basketballBean.status,

                checkStatus = basketballBean.checkStatus,
                resultStatus = basketballBean.resultStatus,
                jcId = basketballBean.jcId,
                saleEndTime = basketballBean.saleEndTime,
                letBall = basketballBean.letBall,
                dxfNum = basketballBean.dxfNum,
                sfFixed = basketballBean.sfFixed,

                sfSingle = basketballBean.sfSingle,
                sfcFixed = basketballBean.sfcFixed,
                sfcSingle = basketballBean.sfcSingle,
                rfsfFixed = basketballBean.rfsfFixed,
                rfsfSingle = basketballBean.rfsfSingle,
                dxfFixed = basketballBean.dxfFixed,
                dxfSingle = basketballBean.dxfSingle,
                dxfSp3  = BetBean(key = "dxf_sp3" , sp = basketballBean.dxfSp3.sp, status = basketballBean.dxfSp3.status, jianChen = basketballBean.dxfSp3.jianChen),
                dxfSp0  = BetBean(key = "dxf_sp0" , sp = basketballBean.dxfSp0.sp, status = basketballBean.dxfSp0.status, jianChen = basketballBean.dxfSp0.jianChen),
                sfcSp11 = BetBean(key = "sfc_sp11", sp = basketballBean.sfcSp11.sp, status = basketballBean.sfcSp11.status, jianChen = "1-5"  , typeString = "1-5"),
                sfcSp12 = BetBean(key = "sfc_sp12", sp = basketballBean.sfcSp12.sp, status = basketballBean.sfcSp12.status, jianChen = "6-10" , typeString = "6-10"),
                sfcSp13 = BetBean(key = "sfc_sp13", sp = basketballBean.sfcSp13.sp, status = basketballBean.sfcSp13.status, jianChen = "11-15", typeString = "11-15"),
                sfcSp14 = BetBean(key = "sfc_sp14", sp = basketballBean.sfcSp14.sp, status = basketballBean.sfcSp14.status, jianChen = "16-20", typeString = "16-20"),
                sfcSp15 = BetBean(key = "sfc_sp15", sp = basketballBean.sfcSp15.sp, status = basketballBean.sfcSp15.status, jianChen = "21-25", typeString = "21-25"),
                sfcSp16 = BetBean(key = "sfc_sp16", sp = basketballBean.sfcSp16.sp, status = basketballBean.sfcSp16.status, jianChen = "26+"  , typeString = "26+"),
                sfcSp01 = BetBean(key = "sfc_sp01", sp = basketballBean.sfcSp01.sp, status = basketballBean.sfcSp01.status, jianChen = "1-5"  , typeString = "1-5"),
                sfcSp02 = BetBean(key = "sfc_sp02", sp = basketballBean.sfcSp02.sp, status = basketballBean.sfcSp02.status, jianChen = "6-10" , typeString = "6-10"),
                sfcSp03 = BetBean(key = "sfc_sp03", sp = basketballBean.sfcSp03.sp, status = basketballBean.sfcSp03.status, jianChen = "11-15", typeString = "11-15"),
                sfcSp04 = BetBean(key = "sfc_sp04", sp = basketballBean.sfcSp04.sp, status = basketballBean.sfcSp04.status, jianChen = "16-20", typeString = "16-20"),
                sfcSp05 = BetBean(key = "sfc_sp05", sp = basketballBean.sfcSp05.sp, status = basketballBean.sfcSp05.status, jianChen = "21-25", typeString = "21-25"),
                sfcSp06 = BetBean(key = "sfc_sp06", sp = basketballBean.sfcSp06.sp, status = basketballBean.sfcSp06.status, jianChen = "26+"  , typeString = "26+"),
                sfSp3   = BetBean(key = "sf_sp3" , sp = basketballBean.sfSp3.sp, status = basketballBean.sfSp3.status,      jianChen = "主胜"   ,  typeString = "主胜"),
                sfSp0   = BetBean(key = "sf_sp0" , sp = basketballBean.sfSp0.sp, status = basketballBean.sfSp0.status,      jianChen = "主负"    ,  typeString = "主负"),
                rfsfSp3 = BetBean(key = "rfsf_sp3", sp = basketballBean.rfsfSp3.sp, status = basketballBean.rfsfSp3.status, jianChen = "让分主胜", typeString = "主胜"),
                rfsfSp0 = BetBean(key = "rfsf_sp0", sp = basketballBean.rfsfSp0.sp, status = basketballBean.rfsfSp0.status, jianChen = "让分主负", typeString = "主负"),
                serial  = basketballBean.serial

        )
    }


    /**
     * 修改Bean中的状态
     */
    fun updateBetBean(betBean: BetBean, basketballBean: BasketballBean) {
        when (betBean.key) {
            basketballBean.dxfSp3.key -> basketballBean.dxfSp3.status = betBean.status
            basketballBean.dxfSp0.key -> basketballBean.dxfSp0.status = betBean.status
            basketballBean.sfcSp11.key -> basketballBean.sfcSp11.status = betBean.status
            basketballBean.sfcSp12.key -> basketballBean.sfcSp12.status = betBean.status
            basketballBean.sfcSp13.key -> basketballBean.sfcSp13.status = betBean.status
            basketballBean.sfcSp14.key -> basketballBean.sfcSp14.status = betBean.status
            basketballBean.sfcSp15.key -> basketballBean.sfcSp15.status = betBean.status
            basketballBean.sfcSp16.key -> basketballBean.sfcSp16.status = betBean.status
            basketballBean.sfcSp01.key -> basketballBean.sfcSp01.status = betBean.status
            basketballBean.sfcSp02.key -> basketballBean.sfcSp02.status = betBean.status
            basketballBean.sfcSp03.key -> basketballBean.sfcSp03.status = betBean.status
            basketballBean.sfcSp04.key -> basketballBean.sfcSp04.status = betBean.status
            basketballBean.sfcSp05.key -> basketballBean.sfcSp05.status = betBean.status
            basketballBean.sfcSp06.key -> basketballBean.sfcSp06.status = betBean.status
            basketballBean.sfSp3.key -> basketballBean.sfSp3.status = betBean.status
            basketballBean.sfSp0.key -> basketballBean.sfSp0.status = betBean.status
            basketballBean.rfsfSp3.key -> basketballBean.rfsfSp3.status = betBean.status
            basketballBean.rfsfSp0.key -> basketballBean.rfsfSp0.status = betBean.status
            else -> {
            }
        }

    }


    fun resetBetBean(basketballBean: BasketballBean) {
        basketballBean.dxfSp3.status = false
        basketballBean.dxfSp0.status = false
        basketballBean.sfcSp11.status = false
        basketballBean.sfcSp12.status = false
        basketballBean.sfcSp13.status = false
        basketballBean.sfcSp14.status = false
        basketballBean.sfcSp15.status = false
        basketballBean.sfcSp16.status = false
        basketballBean.sfcSp01.status = false
        basketballBean.sfcSp02.status = false
        basketballBean.sfcSp03.status = false
        basketballBean.sfcSp04.status = false
        basketballBean.sfcSp05.status = false
        basketballBean.sfcSp06.status = false
        basketballBean.sfSp3.status = false
        basketballBean.sfSp0.status = false
        basketballBean.rfsfSp3.status = false
        basketballBean.rfsfSp0.status = false
    }


    /**
     * 获取左右已选择状态的玩法中的选项
     */
    fun getChoseBetList(basketballBean: BasketballBean): ArrayList<BetBean> {

        val choseBetBeanList: ArrayList<BetBean> = ArrayList()
        if (basketballBean.dxfSp3.status) choseBetBeanList.add(basketballBean.dxfSp3)
        if (basketballBean.dxfSp0.status) choseBetBeanList.add(basketballBean.dxfSp0)
        if (basketballBean.sfcSp11.status) choseBetBeanList.add(basketballBean.sfcSp11)
        if (basketballBean.sfcSp12.status) choseBetBeanList.add(basketballBean.sfcSp12)
        if (basketballBean.sfcSp13.status) choseBetBeanList.add(basketballBean.sfcSp13)
        if (basketballBean.sfcSp14.status) choseBetBeanList.add(basketballBean.sfcSp14)
        if (basketballBean.sfcSp15.status) choseBetBeanList.add(basketballBean.sfcSp15)
        if (basketballBean.sfcSp16.status) choseBetBeanList.add(basketballBean.sfcSp16)
        if (basketballBean.sfcSp01.status) choseBetBeanList.add(basketballBean.sfcSp01)
        if (basketballBean.sfcSp02.status) choseBetBeanList.add(basketballBean.sfcSp02)
        if (basketballBean.sfcSp03.status) choseBetBeanList.add(basketballBean.sfcSp03)
        if (basketballBean.sfcSp04.status) choseBetBeanList.add(basketballBean.sfcSp04)
        if (basketballBean.sfcSp05.status) choseBetBeanList.add(basketballBean.sfcSp05)
        if (basketballBean.sfcSp06.status) choseBetBeanList.add(basketballBean.sfcSp06)
        if (basketballBean.sfSp3.status) choseBetBeanList.add(basketballBean.sfSp3)
        if (basketballBean.sfSp0.status) choseBetBeanList.add(basketballBean.sfSp0)
        if (basketballBean.rfsfSp3.status) choseBetBeanList.add(basketballBean.rfsfSp3)
        if (basketballBean.rfsfSp0.status) choseBetBeanList.add(basketballBean.rfsfSp0)

        return choseBetBeanList

    }


    /**
     * 通过key   获取完整的betBean
     */
    fun getBetNameFromSp(bet: Bet): BetBean {
        val betList = arrayListOf(
                BetBean(key =  "dxf_sp3" , jianChen = "大球"  ,   typeString =  "大球"     ),
                BetBean(key =  "dxf_sp0" , jianChen = "小球" ,    typeString =  "小球"     ),
                BetBean(key =  "sfc_sp11", jianChen = "1-5",     typeString  = "1-5"     ),
                BetBean(key =  "sfc_sp12", jianChen = "6-10",    typeString ="6-10"      ),
                BetBean(key =  "sfc_sp13", jianChen = "11-15",   typeString ="11-15"     ),
                BetBean(key =  "sfc_sp14", jianChen = "16-20"  , typeString ="16-20"     ),
                BetBean(key =  "sfc_sp15", jianChen = "21-25"  , typeString ="21-25"     ),
                BetBean(key =  "sfc_sp16", jianChen = "26+" ,    typeString ="26+"       ),
                BetBean(key =  "sfc_sp01", jianChen = "1-5",     typeString ="1-5"       ),
                BetBean(key =  "sfc_sp02", jianChen = "6-10",    typeString ="6-10"      ),
                BetBean(key =  "sfc_sp03", jianChen = "11-15",   typeString ="11-15"),
                BetBean(key =  "sfc_sp04", jianChen = "16-20"  , typeString ="16-20"),
                BetBean(key =  "sfc_sp05", jianChen = "21-25"  , typeString = "21-25"  ),
                BetBean(key =  "sfc_sp06", jianChen = "26+"  ,   typeString = "26+"    ),
                BetBean(key =  "sf_sp3" ,  jianChen = "主胜",     typeString = "主胜"   ),
                BetBean(key =  "sf_sp0" ,  jianChen = "主负",     typeString = "主负" ),
                BetBean(key =  "rfsf_sp3" ,jianChen = "主胜",     typeString = "让分主胜"),
                BetBean(key =  "rfsf_sp0" ,jianChen = "主负",     typeString = "让分主负")
        )

        val betBean = betList.filter { it.key == bet.bet_key }.first()
        betBean.sp = bet.sp
        return  betBean



    }
}

