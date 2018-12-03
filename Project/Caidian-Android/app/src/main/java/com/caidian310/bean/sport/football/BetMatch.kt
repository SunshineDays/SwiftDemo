package com.caidian310.bean.sport.football

import java.io.Serializable

/**
 * 投注项简单显示数据格式
 * Created by mac on 2018/1/16.
 */
data class BetMatch(
        var name:String,
        var color: String
):Serializable