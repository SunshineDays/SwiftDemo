package com.caidian310.bean.enumBean

/**
 * 订单类型 0:代购自购 1:发单 2:复制跟单 3:追号  4:合买
 * Created by mac on 2018/1/5.
 */
enum class OrderTypeEnum(var id: Int, var orderName: String) {
    Purchasing(id = 0, orderName = "代购自购"),
    Order(id = 1, orderName = "发单"),
    CopyOrder(id = 2, orderName = "复制跟单"),
    Chase(id = 3, orderName = "追号"),
    TogetherBuy(id = 4, orderName = "合买");

    fun getOrderEnumFormId(id: Int) = when (id) {
        Purchasing.id -> Purchasing
        TogetherBuy.id -> TogetherBuy
        Order.id -> Order
        CopyOrder.id ->CopyOrder
        else -> Chase

    }
}