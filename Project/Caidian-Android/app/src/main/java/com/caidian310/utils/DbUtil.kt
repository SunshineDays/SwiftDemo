package com.caidian310.utils

import android.content.Context
import android.content.SharedPreferences
import com.caidian310.application.MyApplication
import com.google.gson.Gson
import com.caidian310.bean.UserBean

/**
 *  SharedPreferences 数据库
 * Created by mac on 2017/11/15.
 */
class DbUtil {

    // 读取key值
    private val USERBEAN = "userBean"


    companion object {
        private val sharedPreferences: SharedPreferences = MyApplication.instance.getSharedPreferences("DbUI", Context.MODE_PRIVATE)
        private val editor: SharedPreferences.Editor = sharedPreferences.edit()
    }


    /**
     * 保存检查更新的时间
     *
     * @return
     */
    fun getUpdateCheckTime(): Long= sharedPreferences.getLong("checkTime", 0)


    fun setUpdateCheckTime(checkTime: Long?) = sharedPreferences.edit().putLong("checkTime", checkTime!!).apply()

    /**
     * 以javaBean形式保存和读取用户的基本信息
     */
    fun setUserBean(userBean: UserBean) =editor.putString(USERBEAN, Gson().toJson(userBean)).commit()



    fun getUserBean(): UserBean {
        val json = sharedPreferences.getString(USERBEAN, "")
        if (json=="") return UserBean()
        return Gson().fromJson(json, UserBean::class.java)
    }



    /**
     * 清除数据库
     */
    fun clearDb() {
        editor.clear()
        editor.commit()
    }
}