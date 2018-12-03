package com.caidian310.bean

import com.google.gson.annotations.SerializedName

/**
 * description : 版本更新日志
 * Created by wdb on 2017/9/7.
 */
data class AppUpdateBean(
        val build: Int,
        @SerializedName("download_url") val downLoadUrl: String,
        val id: Int,
        val message: String,
        @SerializedName("platfrom") val platFrom: String,
        @SerializedName("release_day") val releaseDay: String,
        val version: String,
        @SerializedName("is_show") val isShow: Int = 1
)