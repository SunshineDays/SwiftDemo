package com.caidian310.bean.user

import com.bigkoo.pickerview.model.IPickerViewData
import com.google.gson.annotations.SerializedName

/**
 * 省 bean
 * Created by mac on 2018/3/15.
 */

 class ProvinceBean:IPickerViewData{
    override fun getPickerViewText(): String {
       return  this.name
    }

    var id :Int =0
    var name:String = ""
    @SerializedName("children") var city:ArrayList<CityBean> = ArrayList()

}
