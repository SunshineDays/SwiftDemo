package com.caidian310.bean.enumBean

/**
 * 追号状态
 * Created by mac on 2018/1/26.
 */
enum class ChaseStatueEnum(var id: Int, var nameType: String) {

    Chaseing(id = 0, nameType = "追号中"),
    IssueEnd(id = 1, nameType = "到期停止"),
    WinEnd(id = 2, nameType = "中奖停止"),
    UserCancel(id = 3, nameType = "用户取消"),
    SystemCancel(id = 4, nameType = "系统取消");


    /**
     * 通过Id 获取本条枚举
     * @param id
     * @return ChaseStatueEnum
     */
    fun getChaseStatueEnumFromId(id: Int) = when (id) {
        UserCancel.id -> UserCancel
        SystemCancel.id -> SystemCancel
        Chaseing.id -> Chaseing
        IssueEnd.id -> IssueEnd
        else -> WinEnd

    }

}
