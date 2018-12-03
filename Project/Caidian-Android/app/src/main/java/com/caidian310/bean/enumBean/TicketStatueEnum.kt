package com.caidian310.bean.enumBean

/**
 * 出票状态
 * Created by mac on 2018/2/1.
 */
enum class TicketStatueEnum(var id:Int,var ticketName:String){
    NoTicket(id = 0,ticketName = "未出票"),
    Ticketing(id = 1,ticketName = "出票中"),
    TicketSuccess(id = 2,ticketName = "出票成功"),
    TicketFailure(id = 3,ticketName = "出票失败");

    fun getTicketStatueEnumFromId(id:Int)= when(id){
        NoTicket.id -> NoTicket
        Ticketing.id -> Ticketing
        TicketSuccess.id -> TicketSuccess
            else -> TicketFailure
        }


}
