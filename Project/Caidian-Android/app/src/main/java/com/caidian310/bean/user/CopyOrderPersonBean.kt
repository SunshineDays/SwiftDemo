package com.caidian310.bean.user

import com.caidian310.bean.PageInfo
import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class CopyOrderPersonBean(
        var list : ArrayList<CopyOrderPerson> = ArrayList(),
        @SerializedName("page_info") var pageInfo:PageInfo
)

data class CopyOrderPerson(
        @SerializedName("total_money") val totalMoney :Double =0.00,
        @SerializedName("user_id") val userId :Int ,
        @SerializedName("create_time") val createTime :Long =0L,
        @SerializedName("user_name") val userName :String=""

):Serializable