package com.caidian310.utils

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import com.caidian310.application.MyApplication
import java.util.*

/**
 * description : 手机权限权利工具
 * Created by wdb on 2017/6/19.
 */

object PermissionManagerUtil {

    /**
     * @description :跳转到用哪应用的权限设置页面
     * @param context
     */
    fun goAppDetailSettingIntent(context: Context) {
        val localIntent = Intent()
        localIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        if (Build.VERSION.SDK_INT >= 9) {
            localIntent.action = "android.settings.APPLICATION_DETAILS_SETTINGS"
            localIntent.data = Uri.fromParts("package", context.packageName, null)
        } else if (Build.VERSION.SDK_INT <= 8) {
            localIntent.action = Intent.ACTION_VIEW
            localIntent.setClassName("com.android.settings", "com.android.setting.InstalledAppDetails")
            localIntent.putExtra("com.android.settings.ApplicationPkgName", context.packageName)
        }
        context.startActivity(localIntent)
    }


    /**
     * 检查应用是否拥有该权限
     */
    fun checkPermission(permissionString: String): Boolean {
        return PackageManager.PERMISSION_GRANTED == MyApplication.instance!!.packageManager.checkPermission(permissionString, "packageName")
    }


    /**
     * android 6.0 需要写运行时权限
     * @param permissions 需请求的权限集合
     * @param permissionListener 请求结果监听
     */
    fun requestRuntimePermission(context: Activity,resultCode:Int, permissions: Array<String>, permissionListener: PermissionListener ?=null) {
        val permissionList = ArrayList<String>()

        permissions.filterTo(permissionList) { ContextCompat.checkSelfPermission(context, it) != PackageManager.PERMISSION_GRANTED }
        if (!permissionList.isEmpty()) {
            ActivityCompat.requestPermissions(context, permissionList.toTypedArray(), resultCode)
        } else {
            permissionListener?.onGranted()
        }
    }




    interface PermissionListener {
        /**
         * 成功获取权限
         */
        fun onGranted()

        /**
         * 为获取权限
         * @param deniedPermission
         */
        fun onDenied(deniedPermission: List<String>)

    }

}