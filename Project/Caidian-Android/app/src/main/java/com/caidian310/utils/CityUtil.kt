package com.caidian310.utils

import com.caidian310.application.MyApplication
import com.caidian310.bean.user.CityBean
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.caidian310.bean.user.ProvinceBean

import java.io.InputStream

/**
 * 城市 -身份 工具
 * Created by mac on 2018/3/15.
 */
class CityUtil{
    /**
     * 获取assets 下的省份json
     */

    private var jsonString :String =""
    var provinceList :ArrayList<ProvinceBean> = ArrayList()
    var provinceOptionsItemsList :ArrayList<ArrayList<String>> = ArrayList()
    var provinceOptionsItemsBeanList :ArrayList<ArrayList<CityBean>> = ArrayList()
    private var cityList :ArrayList<ArrayList<CityBean>> = ArrayList()


    init {

        getJsonString()
        getAllProvinces()
        getAllCity()
        getPickerOptions()
    }


    /**
     * 将json转换成String型
     *
     */
    private fun getJsonString() {
        val inputStream: InputStream = MyApplication.instance.assets.open("city.json")
        jsonString =inputStream.bufferedReader().use{ it.readText() }
    }


    /**
     * 获取所有得省  一级参数
     */
    private fun getAllProvinces() {
       provinceList.addAll(Gson().fromJson(jsonString, object : TypeToken<ArrayList<ProvinceBean>>() {}.type))
    }


    /**
     * 获取地区选择期 二级参数
     */
    private  fun  getPickerOptions() {
         provinceList.forEach {
            val cityString: ArrayList<String> = ArrayList()
            val cityList: ArrayList<CityBean> = ArrayList()
            it.city.forEach {
                cityList.add(it)
                cityString.add(it.name)
            }
             provinceOptionsItemsList.add(cityString)
             provinceOptionsItemsBeanList.add(cityList)
        }
    }


    /**
     * 获得所有的市
     * @return ArrayList<ArrayList<CityBean>>
     */

    private fun getAllCity(){

        val provincesList = Gson().fromJson<ArrayList<ProvinceBean>>(jsonString, object : TypeToken<ArrayList<ProvinceBean>>() {}.type)
        provincesList.forEach { cityList.add(it.city) }

    }

    /**
     * 通过省id   获取省name
     * @param    provinceId 省id
     * @return   name
     */

    fun getProvinceNameFromId(provinceId:Int) : String{
        var provinceName = ""
        provinceList.forEach {
            if (it.id == provinceId) {
                provinceName = it.name
                return@forEach
            }
        }
        return  provinceName
    }


    /**
     * 通过市Id        获取市Id
     * @param cityId  市Id
     *
     */
    fun  getCityNameFromId(cityId:Int):String{
        var cityName =""
        cityList.forEach {
            it.forEach {
                if (it.id== cityId){
                    cityName = it.name
                    return@forEach
                }
            }
        }
        return cityName
    }


}