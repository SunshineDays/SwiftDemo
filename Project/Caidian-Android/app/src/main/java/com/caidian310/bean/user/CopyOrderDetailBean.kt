package com.caidian310.bean.user

import com.caidian310.bean.IssueBean
import com.caidian310.bean.buy.PayCodeBean
import com.caidian310.bean.sport.order.CopyOrderBean

/**
 * 复制跟单详情 实体类
 */

data class CopyOrderDetailBean(
        var copy:CopyOrderBean,
        var order: OrderBean,
        var code :PayCodeBean,
        var issue: IssueBean
)