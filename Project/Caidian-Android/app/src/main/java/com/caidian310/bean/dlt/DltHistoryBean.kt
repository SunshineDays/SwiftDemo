package com.caidian310.bean.dlt

import com.google.gson.annotations.SerializedName
import com.caidian310.bean.IssueBean
import com.caidian310.bean.PageInfo

/**
 * 大乐透历史期Bean
 * Created by mac on 2018/1/24.
 */
data class DltHistoryBean(
        var list : ArrayList<IssueBean>,
        @SerializedName("page_info") var pageInfo : PageInfo
)