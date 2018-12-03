package com.caidian310.utils

import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.google.gson.Gson

/**
 *
 * 复制工具管理类
 * Created by mac on 2017/12/25.
 */
object CopyUtil{
    /**
     * 深层拷贝
     * @param obj 需要拷贝的对象
     * @param classType 被拷贝对象的类型
     * @return 深拷贝的对象
     */
    fun <T> CopyClass(obj: Any, classType: Class<T>): T {
        val json = Gson().toJson(obj)
        return Gson().fromJson(json, classType)
    }

    fun copyMatchBean(match: FootballBean)= FootballBean(
            id = match.id,
            xid = match.xid,
            leagueFullName = match.leagueFullName,
            leagueName = match.leagueName,
            home = match.home,
            away = match.away,
            away3 = match.away3,
            home3 = match.home3,
            matchTime = match.matchTime,
            saleEndTime = match.saleEndTime,
            letBall = match.letBall,
            color = match.color,
            issue = match.issue,
            score = match.score,
            scoreHalf = match.scoreHalf,
            status = match.status,
            checkStatus = match.checkStatus,
            resultStatus = match.resultStatus,
            jczqBeanList = copyBetBeanList(match.jczqBeanList),
            spfFixed = match.spfFixed,
            rqspfFixed = match.rqspfFixed,
            bqcFixed = match.bqcFixed,
            jqsFixed = match.jqsFixed,
            bfFixed = match.bfFixed,
            spfSingle = match.spfSingle,
            rqspfSingle = match.rqspfSingle,
            bfSingle = match.bfSingle,
            bqcSingle = match.bqcSingle,
            jqsSingle = match.jqsSingle,
            jcId = match.jcId,
            serial = match.serial

    )


    /**
     * 深度复制Jcba
     */

    private fun copyBetBeanList(list: ArrayList<BetBean>) :ArrayList<BetBean>{
        val newList: ArrayList<BetBean> = ArrayList()
        list.forEach {
            newList.add(
                    BetBean(
                            key = it.key,
                            sp = it.sp,
                            jianChen = it.jianChen,
                            status = it.status,
                            typeString = it.typeString
                    )
            )

        }
        return newList

    }

}