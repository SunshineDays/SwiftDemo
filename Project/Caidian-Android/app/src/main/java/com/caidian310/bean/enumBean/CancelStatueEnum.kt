package com.caidian310.bean.enumBean

/**
 * 投注 取消状态
 * Created by mac on 2018/2/2.
 */
enum class CancelStatueEnum(var id: Int, var statueName: String) {
    NoBet(id = 0, statueName = "未投注"),

    BetFinish(id = 1, statueName = "已完成投注"),
    WinCanCel(id = 2, statueName = "中奖取消"),
    UserCanCel(id = 3, statueName = "用户取消"),
    SystemCancel(id = 4, statueName = "系统取消"), ;


    fun getCanCelStatueEnumFromId(id: Int) = when (id) {
        NoBet.id -> NoBet
        BetFinish.id -> BetFinish
        WinCanCel.id -> WinCanCel
        UserCanCel.id -> UserCanCel
        else -> SystemCancel
    }

}
