package com.caidian310.activity

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.app.FragmentManager
import android.view.KeyEvent
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.user.LoginActivity
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.fragment.CopyOrderFragment
import com.caidian310.fragment.HomeFragment
import com.caidian310.fragment.LiveFragment
import com.caidian310.fragment.UserFragment
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.service.DownloadService
import com.caidian310.utils.*
import kotlinx.android.synthetic.main.activity_main.*
import org.greenrobot.eventbus.EventBus

class MainActivity : BaseActivity() {


    private var fManager: FragmentManager? = null
    private var images = intArrayOf(R.drawable.tab_home,R.drawable.tab_copy_order,R.drawable.tab_live,R.drawable.tab_user)
    private var titles = arrayOf("购彩","跟单","比分","我的")
    private val mFragment = arrayOf<Class<*>>(HomeFragment::class.java,CopyOrderFragment::class.java,LiveFragment::class.java,UserFragment::class.java)
    private var downLoadUrl:String ?=null

    private val PERMISSIONS = arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE, android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
    private val PERMISSIONSRESULT = 1


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        ActionBarStyleUtil.setActionBarStyle(this)

        UserPresenter.requestServerTime(this)
        initView()
        initEvent()
        hintActionBar()
    }


    override fun initView() {
        super.initView()

        fManager = supportFragmentManager
        main_tab_host.setup(this, fManager, R.id.main_tab_frame_layout)
        main_tab_host.tabWidget?.dividerDrawable = null
        main_tab_host.currentTab = 1

        for (i in images.indices) {
            //对Tab按钮添加标记和图片
            val tabSpec = main_tab_host.newTabSpec(titles[i])?.setIndicator(getImageView(i))
            //添加Fragment
            main_tab_host.addTab(tabSpec, mFragment[i], null)
        }
    }




    override fun initEvent() {
        super.initEvent()

        registerEventBus()

        val version = intent.getStringExtra("version")
        val message = intent.getStringExtra("message")
         downLoadUrl = intent.getStringExtra("downLoadUrl")
        if (downLoadUrl.isNullOrEmpty()) return
        judgeApkDownload(downLoadUrl!!,version)


    }


    /**
     * apk 下载提示
     */
    private fun judgeApkDownload(downLoadUrl: String,versionString: String){
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
                    if (PermissionManagerUtil.checkPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)){
                        isWifiDialog()
                        return@showDialog
                    }
                    /**
                     * 权限不存在
                     */
                    ActivityCompat.requestPermissions(this@MainActivity, PERMISSIONS, PERMISSIONSRESULT)

                }
        )

    }

    /**
     * 网络判断dialog
     */
    private fun isWifiDialog(){

        /**
         * 不是WIFI
         */
        if (NetUtil.isWifi(this)){
            startService()
            return
        }
        DialogUtil.show4GDialog(
                context = this,
                onSure = {
                    startService()
                    it.dismiss()
                },
                onCancel = {

                }
        )
    }

    /**
     * 启动服务下载
     */
    private fun startService(){
        val intent = Intent(this,DownloadService::class.java)
        intent.putExtra("downloadUrl",downLoadUrl)
        startService(intent)
    }



    //获取图片资源
    private fun getImageView(index: Int): View {
        val view = layoutInflater.inflate(R.layout.view_tab_indicator, null)
        val imageView = view.findViewById<ImageView>(R.id.tab_iv_image)
        val title = view.findViewById<TextView>(R.id.tab_tv_text)
        imageView.setImageResource(images[index])
        title.text = titles[index]
        return view

    }


    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSIONSRESULT || grantResults.isEmpty()) return
        if (requestCode == PERMISSIONSRESULT)
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                isWifiDialog()
            } else {
                showToast("拒绝授权，下载取消")
            }

    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            exit()
            return false
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)
        if (event.loginMessage == "needLogin") {
            DbUtil().clearDb()
            EventBus.getDefault().post(EventBusBean("outLogin"))
            startActivity(Intent(this, LoginActivity::class.java))
        }


    }

    private var exitTime: Long = 0

    private fun exit() {
        if (System.currentTimeMillis() - exitTime > 2000) {
            showToast("再按一次退出程序")
            exitTime = System.currentTimeMillis()
        } else {
            finish()
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        unregisterEventBus()
    }


}
