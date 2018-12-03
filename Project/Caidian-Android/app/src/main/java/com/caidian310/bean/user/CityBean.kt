package com.caidian310.bean.user

import com.bigkoo.pickerview.model.IPickerViewData
import com.google.gson.annotations.SerializedName

/**
 * Created by mac on 2018/3/15.
 */
 class CityBean : IPickerViewData{
    override fun getPickerViewText(): String {
        return name
    }

    var id: Int =0
    var name:String=""
    @SerializedName("is_kill") var isKill =0
}