package com.caidian310.bean.enumBean

/**
 * 中奖状态
 * Created by mac on 2018/1/6.
 */
enum class WinStatueEnum(var id: Int, var nameString: String) {
    NoStart(id = 0, nameString = "暂未开奖"),
    Lost(id = 1, nameString = "未中奖"),
    Win(id = 2, nameString = "已中奖");

    fun getWinStatueEnumFromId(statue: Int) = when (statue) {
        NoStart.id -> NoStart
        Lost.id -> Lost
            else -> Win
        }
}