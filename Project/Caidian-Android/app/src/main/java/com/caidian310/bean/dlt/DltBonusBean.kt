package com.caidian310.bean.dlt

import com.google.gson.annotations.SerializedName

/**
 * 大乐透 投注项
 * Created by mac on 2018/1/24.
 */
data class DltBonusBean(
        var pool : Double,
        @SerializedName("total_sales") var totalSales :Double,
        var number :String,
        @SerializedName("num_sequence") var numSequence:String,
        var detail : ArrayList<BonusDetailBean>
)

data class BonusDetailBean(
        @SerializedName("all_money") var  allMoney : Double,
        var level :String,
        var money :Double,
        var piece :Double,
        var key :String
)
