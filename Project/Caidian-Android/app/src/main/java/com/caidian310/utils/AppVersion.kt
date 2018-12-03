package com.caidian310.utils

import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager.NameNotFoundException
import android.net.Uri
import android.os.Build
import android.support.v4.content.FileProvider
import com.caidian310.application.MyApplication
import com.caidian310.http.HttpUtil
import com.caidian310.utils.ToastUtil.showToast
import org.jetbrains.anko.doAsync
import java.io.File


/**
 * description : apk 版本管理工具
 * Created by wdb on 2017/6/1.
 */

object AppVersion {


    /**
     * 获取app的版本Name 1.1
     */
    val versionName: String = getPackInfo()!!.versionName


    /**
     * 获取app的版本code 1100
     */
    val versionCode: Int = getPackInfo()!!.versionCode


    /**
     * 获取App名称
     */

    val appName = MyApplication.instance.resources.getString(getPackInfo()!!.applicationInfo.labelRes)


    /** 获取 packageanager的实例 */
    private fun getPackInfo(): PackageInfo? {
        val packageManager = MyApplication.instance.packageManager
        var packInfo: PackageInfo? = null
        try {
            packInfo = packageManager.getPackageInfo(MyApplication.instance.packageName, 0)
        } catch (e: NameNotFoundException) {
            e.printStackTrace()
        }
        return packInfo

    }


    /**
     * 用于下载完成后安装apk
     *
     * @param context 上下文
     * @param apkFile apk文件
     */
    private fun installApk(context: Context, apkFile: File) {
        val install = Intent(Intent.ACTION_VIEW)
        install.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        if (Build.VERSION.SDK_INT >= 24) {
            val apkUri = FileProvider.getUriForFile(context, MyApplication.fileProvider, apkFile)
            install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            install.setDataAndType(apkUri, "application/vnd.android.package-archive")
        } else {
            install.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            install.setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive")
        }
        context.startActivity(install)
    }


    /**
     * apk下载
     * @param   context     上下文
     * @param   downLoadUrl 下载地址
     */
    fun downApk(
            context: Context,
            downLoadUrl: String,
            onSuccess: (file: File) -> Unit,
            onFailure: (httpError: HttpError) -> Unit,
            onProgress:(progress:Int) ->Unit) {
        if (downLoadUrl.isNullOrEmpty()) return
        showToast("正在下载..")
        HttpUtil().requestDownloadFile(
                url = downLoadUrl,
                file = FileUtil.apkFile(),
                onSuccess = {
                    showToast("下载成功 $it")
                    onSuccess(it)
                    AppVersion.installApk(context, it)

                },
                onProgress = {
                    onProgress(it)
                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                })

    }

}
