package com.caidian310.bean

import com.google.gson.annotations.SerializedName

/**
 * 分页详情
 * Created by mac on 2018/1/3.
 */
data class PageInfo(
        var page:Int =1,
        @SerializedName("page_count") var pageCount :Int=0,
        @SerializedName("page_size")var pageSize :Int=20,
        @SerializedName("data_count")var dataCount :Int
)