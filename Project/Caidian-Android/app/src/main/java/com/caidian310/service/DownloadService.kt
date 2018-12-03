package com.caidian310.service

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.caidian310.utils.AppVersion
class DownloadService : Service() {


    override fun onBind(intent: Intent?): IBinder? {
        return  null
    }


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        /**
         * 开始下载
         */
        val  downloadUrl = intent!!.getStringExtra("downloadUrl")


        AppVersion.downApk(
                context = this,
                downLoadUrl = downloadUrl,
                onSuccess = {
                    this.stopSelf()
                },
                onFailure = {
                    this.stopSelf()
                },
                onProgress = {})
        return super.onStartCommand(intent, flags, startId)
    }

}