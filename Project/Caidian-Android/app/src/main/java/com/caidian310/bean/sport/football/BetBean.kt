package com.caidian310.bean.sport.football

import java.io.Serializable

/**
 * 选中项的一些基本信息
 * Created by mac on 2017/12/4.
 */
data class BetBean(

        var key: String = "",           //字段名  方便后期回传给接口
        var sp: Double = 0.00,          //赔率
        var status: Boolean = false,    // 选择状态
        var jianChen: String = "",      //简称
        var typeString: String = ""

) : Serializable