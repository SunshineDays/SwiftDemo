package com.caidian310.bean.sport.football


/**
 * 自定义的竞彩足球数据格式
 * Created by mac on 2017/12/4.
 */

data class FootballBean(

        var id: Int,
        var xid: String,
        var leagueFullName: String,
        var leagueName: String,
        var home: String,
        var away: String,
        var away3: String,
        var home3: String,
        var matchTime: Long,
        var saleEndTime: Long,
        var letBall: Double,
        var color: String,
        var issue: String,
        var score: String,
        var scoreHalf: String,
        var status: Int,
        var checkStatus: Int,
        var resultStatus: Int,
        var jczqBeanList: ArrayList<BetBean>,

        var spfFixed: Int,
        var rqspfFixed: Int,
        var bqcFixed: Int,
        var jqsFixed: Int,
        var bfFixed: Int,
        var spfSingle: Int,
        var rqspfSingle: Int,
        var bfSingle: Int,
        var bqcSingle: Int,
        var jqsSingle: Int,
        var jcId: Int,
        var serial: String
) {

    fun getMatchBean(): Match {
        return Match(
                id = this.id,
                xid = this.xid,
                leagueFullName = this.leagueFullName,
                leagueName = leagueName,
                home = this.home,
                away = this.away,
                away3 = this.away3,
                home3 = this.home3,
                matchTime = this.matchTime,
                saleEndTime = this.saleEndTime,
                letBall = this.letBall,
                color = this.color,
                issue = this.issue,
                score = this.score,
                scoreHalf = this.scoreHalf,
                status = this.status,
                checkStatus = this.checkStatus,
                resultStatus = this.resultStatus,
                spfFixed = this.spfFixed,
                rqspfFixed = this.rqspfFixed,
                bqcFixed = this.bqcFixed,
                jqsFixed = this.jqsFixed,
                bfFixed = this.bfFixed,
                spfSingle = this.spfSingle,
                rqspfSingle = this.rqspfSingle,
                bfSingle = this.bfSingle,
                bqcSingle = this.bqcSingle,
                jqsSingle = this.jqsSingle,
                jcId = this.jcId,
                serial = this.serial
        )
    }


}






