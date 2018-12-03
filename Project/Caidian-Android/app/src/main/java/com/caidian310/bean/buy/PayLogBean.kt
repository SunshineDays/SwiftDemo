package com.caidian310.bean.buy

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.PageInfo

/**
 * 交易日志
 * Created by mac on 2018/1/3.
 */
data class  PayLogBean(
        var list :ArrayList<PayBean>,
        @SerializedName("page_info") var pageInfo: PageInfo


)