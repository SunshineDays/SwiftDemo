package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.PageInfo

/**
 * 账户信息
 * Created by mac on 2018/1/2.
 */
data  class BuyRecordBean(
        var list :ArrayList<OrderAndBuyBean>,
        @SerializedName("page_info") var pageInfo : PageInfo
)
data  class OrderAndBuyBean(
        var buy: BuyBean,
        var order: OrderBean
)