package com.caidian310.view.callBack

import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.bean.sport.football.Match

/**
 * Created by mac on 2017/11/16.
 */
interface CallFootballBeanBack {

    fun callObjectBack(type:String = BetTypeEnum.hunhe.key, footballBean: FootballBean, map :LinkedHashMap<Match, ArrayList<BetBean>>)
}