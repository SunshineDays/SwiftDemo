package com.caidian310.utils

import android.app.AlertDialog
import android.content.Context
import android.widget.ProgressBar
import android.widget.TextView
import com.caidian310.R
import com.caidian310.R.id.cancel
import com.caidian310.utils.ToastUtil.showToast

/**
 * 对话框
 * Created by mac on 2018/1/29.
 */

object DialogUtil {


    /**
     * 对话框
     * @param messageString 提示语
     */
    fun showDialog(
            context: Context,
            messageString: String = "确定清空所有信息? ",
            onSure: (it: AlertDialog) -> Unit,
            onCancel: () -> Unit) {

        val alertDialog = AlertDialog.Builder(context).create()
        alertDialog.show()
        val window = alertDialog.window
        window!!.setContentView(R.layout.layout_diagnosis_dialog)

        val message = window.findViewById<TextView>(R.id.diagnosis_dialog_title)
        val ok = window.findViewById<TextView>(R.id.diagnosis_dialog_ok)
        val cancel = window.findViewById<TextView>(R.id.diagnosis_dialog_cancel)
        message.text = messageString

        ok.setOnClickListener {
            onSure(alertDialog)

        }
        cancel.setOnClickListener {
            //如果取消  返回false
            onCancel()
            alertDialog.dismiss()
        }

    }


    /**
     * 4G提示对话框
     */
    fun show4GDialog(
            context: Context,
            titleString: String = "友情提示",
            messageString: String = "您使用4G网络，是否要继续更新？",
            onSure: (it: AlertDialog) -> Unit,
            onCancel: () -> Unit) {

        val alertDialog = AlertDialog.Builder(context).create()
        alertDialog.show()
        val window = alertDialog.window

        window!!.setContentView(R.layout.layout_tip_4g)

        val title = window.findViewById<TextView>(R.id.update_remind_title)
        val message = window.findViewById<TextView>(R.id.update_remind_message)
        val ok = window.findViewById<TextView>(R.id.update_remind_confirm)
        val cancel = window.findViewById<TextView>(R.id.update_remind_cancel)
        title.text = titleString
        message.text = messageString

        ok.setOnClickListener {
            onSure(alertDialog)

        }
        cancel.setOnClickListener {
            //如果取消  返回false
            onCancel()
            alertDialog.dismiss()
        }

    }

    /**
     * 下载进度条
     */
    fun showDownloadProgressDialog(
            context: Context,
            downloadUrl:String
            ) {

        val alertDialog = AlertDialog.Builder(context).create()
        alertDialog.setCanceledOnTouchOutside(false)
        alertDialog.show()
        val window = alertDialog.window

        window!!.setContentView(R.layout.layout_apk_update)



        val message = window.findViewById<TextView>(R.id.update_apk_progress_message)
        val progressBar = window.findViewById<ProgressBar>(R.id.update_apk_progress)

        AppVersion.downApk(
                context = context,
                downLoadUrl = downloadUrl,
                onSuccess = {
                    alertDialog.dismiss()
                },
                onFailure = {
                    showToast(it.message)
                    alertDialog.dismiss()
                },
                onProgress ={
                    progressBar.progress = it
                    message.text = "$it%"
                })

    }
}
