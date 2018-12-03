package com.caidian310.bean.dlt

import com.caidian310.bean.buy.Section
import java.io.Serializable

/**
 *

 *
 * 一块代表一场比赛一种玩法
 * data class Section(
 * var type :String  ,                //投注类型PlayBetTypeEnum
 * var ball_list : ArrayList<Ball>    //投注项集合
 * ):Serializable


 * 大乐透投注显示bean
 * Created by mac on 2018/1/25.
 */

data class DltBetBean(
        var sectionList :ArrayList<Section> = ArrayList(), //
        var betCount: Int,                       //注数
        var multiple:Int,                        //倍数
        var money: Double,                       //本次投注的金额
        var name: String
) : Serializable
