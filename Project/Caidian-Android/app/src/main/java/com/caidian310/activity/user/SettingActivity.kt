package com.caidian310.activity.user

import android.Manifest
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.widget.SimpleAdapter
import android.widget.TextView
import com.caidian310.R
import com.caidian310.R.id.setting_list_view
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.AppUpdateBean
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.*
import com.caidian310.utils.ToastUtil.showToast
import kotlinx.android.synthetic.main.activity_user_setting.*
import org.greenrobot.eventbus.EventBus


class SettingActivity : BaseActivity() {

    private val dialogTitle = "是否清理缓存?"
    private var listMap: ArrayList<HashMap<String, Any>> = ArrayList()

    private var appUpdateBean: AppUpdateBean? = null


    private val PERMISSIONS = arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE, android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
    private val PERMISSIONSRESULT = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_setting)

        initActionBar(centerTitle = "设置")
        initEvent()

    }

    override fun initEvent() {
        super.initEvent()
        getDate()
        setting_list_view.setOnItemClickListener { _, _, position, _ ->
            when (position) {
                0 -> showDiagnosisDialog(dialogTitle)
//                1 -> startActivity(Intent(this, UpdateVersionInfoActivity::class.java))
//                2 -> startActivity(Intent(this, UpdateVersionInfoActivity::class.java))
                2 -> requestCheckVersion()
                else -> {
                }
            }
        }
        setting_outLogin.setOnClickListener { outLogin() }
    }


    /**
     * 检测会否有新版本
     */
    private fun requestCheckVersion() {
        UserPresenter.requestUpdateCheckData(
                context = this,
                onSuccess = {
                    appUpdateBean = it
                    if (it.build <= AppVersion.versionCode) {
                        showToast("当前已是最新版本")
                        return@requestUpdateCheckData
                    }
                    judgeApkDownload(downLoadUrl = it.downLoadUrl, versionString = it.version)

                },
                onFailure = {
                    showToast(it.message)
                })
    }


    /**
     * apk 下载提示框
     */
    private fun judgeApkDownload(downLoadUrl: String, versionString: String) {
        if (downLoadUrl.isNullOrEmpty()) return
        DialogUtil.showDialog(
                context = this,
                messageString = "检测到新版本$versionString,是否更新?",
                onCancel = {},
                onSure = {

                    it.dismiss()

                    /**
                     * WIFI 小监测权限
                     */
                    if (PermissionManagerUtil.checkPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
                        isWifiDialog(downLoadUrl = downLoadUrl)
                        return@showDialog
                    }
                    /**
                     * 权限不存在
                     */
                    ActivityCompat.requestPermissions(this, PERMISSIONS, PERMISSIONSRESULT)

                }
        )

    }

    /**
     * 开会下载
     */
    private fun startDown(downLoadUrl: String) {
        DialogUtil.showDownloadProgressDialog(context = this,downloadUrl = downLoadUrl)
    }

    /**
     * 网络判断dialog
     */
    private fun isWifiDialog(downLoadUrl: String) {

        /**
         * 不是WIFI
         */
        if (NetUtil.isWifi(this)) {
            startDown(downLoadUrl)
            return
        }
        DialogUtil.show4GDialog(
                context = this,
                onSure = {
                    startDown(downLoadUrl = downLoadUrl)
                    it.dismiss()
                },
                onCancel = {

                }
        )
    }


    /***  设置数据  */
    private fun getDate() {

        var map: HashMap<String, Any> = HashMap()
        listMap.clear()

        map = HashMap()
        map["txt"] = "清理缓存"
        map["state"] = CleanCacheUtil.getTotalCacheSize(this)
        map["img"] = ""
        listMap.add(map)

        map = HashMap()
        map["txt"] = "版本号"
        map["state"] = "(当前版本v " + AppVersion.versionName + ")"
        map["img"] = ""

        listMap.add(map)

//        map = HashMap()
//        map["txt"] = "更新内容"
//        map["state"] = ""
//        map["img"] = R.mipmap.ic_btn_search_go
//        listMap.add(map)

        map = HashMap()
        map["txt"] = "版本更新"
        map["state"] = ""
        map["img"] = R.mipmap.ic_btn_search_go
        listMap.add(map)

        setting_list_view.adapter = SimpleAdapter(baseContext, listMap, R.layout.layout_listview,
                arrayOf("txt", "img", "state"), intArrayOf(R.id.list_text, R.id.search_img, R.id.list_state))

    }


    /**
     * 清理缓存对话框
     * @param messageStr 提示语
     */
    private fun showDiagnosisDialog(messageStr: String) {

        val alertDialog = AlertDialog.Builder(this@SettingActivity).create()
        alertDialog.show()
        val window = alertDialog.window
        window!!.setContentView(R.layout.layout_diagnosis_dialog)

        val message = window.findViewById<TextView>(R.id.diagnosis_dialog_title)
        val ok = window.findViewById<TextView>(R.id.diagnosis_dialog_ok)
        val cancel = window.findViewById<TextView>(R.id.diagnosis_dialog_cancel)
        message.text = messageStr

        ok.setOnClickListener {
            //清理缓存
            CleanCacheUtil.clearAllCache(this)
            getDate()
            showToast("已清理全部缓存")
            alertDialog.dismiss()
        }
        cancel.setOnClickListener {
            //如果取消  返回false
            alertDialog.dismiss()
        }
    }


    /** 需要重写onActivityResult */
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
//        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data)
    }


    /** 退出当前账号*/
    private fun outLogin() {
        UserPresenter.requestNormalOutLogin(context = this,
                onSuccess = {
                    EventBus.getDefault().post(EventBusBean("outLogin"))
                    finish()

                })
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSIONSRESULT || grantResults.isEmpty()) return
        if (requestCode == PERMISSIONSRESULT)
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                if (appUpdateBean != null) isWifiDialog(downLoadUrl = appUpdateBean!!.downLoadUrl)
            } else {
                showToast("拒绝授权，下载取消")
            }

    }


}
