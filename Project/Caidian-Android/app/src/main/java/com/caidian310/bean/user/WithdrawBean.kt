package com.caidian310.bean.user

import com.google.gson.annotations.SerializedName

/**
 * 提现列表bean
 */

data class WithdrawBean(
        @SerializedName("order_num")
        var codeNumber: String,                   //提现编号
        @SerializedName("create_time")
        var createTime: Long,                     //时间
        @SerializedName("failed_rollback")
        var failedRollback: Int,                  //提现是否回滚(返款) 0:未回滚 1:已回滚
        var id: Int,
        @SerializedName("is_allow")
        var isAllow: Int,                         //
        var money: String,
        var remark: String,                       //备注
        var status: Int,                          //状态 0:进行中 1:提现成功 -1:提现失败
        @SerializedName("update_time")
        var updateTime: Long,
        @SerializedName("user_id")
        var userAccountId: Int

)