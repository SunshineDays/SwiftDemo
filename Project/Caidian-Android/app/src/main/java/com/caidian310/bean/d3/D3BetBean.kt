package com.caidian310.bean.d3

import java.io.Serializable

/**
 *
 * d3 遗漏 和 选择状态
 * Created by mac on 2018/1/30.
 */
data class D3BetBean(
        var position:String = "0",              //显示数字
        var missNumber: Int = -1,               //遗漏
        var choseStatue: Boolean = false,        //选择状态
        var waveStatueBoolean :Boolean = false   //波胆状态
):Serializable