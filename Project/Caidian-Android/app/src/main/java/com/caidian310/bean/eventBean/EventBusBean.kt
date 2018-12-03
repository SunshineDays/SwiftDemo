package com.caidian310.bean.eventBean

import com.caidian310.bean.dlt.DltBetBean


/**
 * description :
 *
 * 事件分发机制 参数
 * Created by wdb on 2017/5/9.
 */

class EventBusBean {
    var jczqTypeString : String ?=null
    var jczqDeleteList :ArrayList<Int> =ArrayList()
    var loginMessage :String =""
    var betLotteryId :Int ?=null

    var betBeanArrayList: ArrayList<DltBetBean> = ArrayList()



    constructor(type:String,deleteList:ArrayList<Int>) {
        this.jczqTypeString = type
        this.jczqDeleteList = deleteList
    }

    constructor(loginMessage:String){
        this.loginMessage = loginMessage
    }

    constructor(betLotteryId:Int){
        this.betLotteryId = betLotteryId
    }



    constructor(betLotteryId: Int,betBeanArrayList: ArrayList<DltBetBean>){
        this.betLotteryId = betLotteryId
        this.betBeanArrayList = betBeanArrayList
    }



}
