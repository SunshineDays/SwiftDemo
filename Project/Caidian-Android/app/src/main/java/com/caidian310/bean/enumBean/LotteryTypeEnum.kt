package com.caidian310.bean.enumBean

/**
 *
 * 彩种类型
 * Created by mac on 2018/2/1.
 */
enum class LotteryTypeEnum(var id:Int,var lotterName:String){
    SportLottery(id = 1,lotterName = "竞技彩"),      //不可用
    NumericLottery(id = 2,lotterName = "数字彩"),       //数字彩
    QuickLottery(id = 3,lotterName = "快频")
 }

