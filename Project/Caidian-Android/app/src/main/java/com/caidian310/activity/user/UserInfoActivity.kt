package com.caidian310.activity.user

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.MediaStore
import android.support.annotation.RequiresApi
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.support.v4.content.FileProvider
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.application.MyApplication
import com.caidian310.bean.UserBean
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.DbUtil
import com.caidian310.utils.FileUtil
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.ImageUtil
import com.caidian310.view.popupWindow.user.HeaderImgWindow
import com.caidian310.view.popupWindow.user.UserSexUpdateWindow
import kotlinx.android.synthetic.main.activity_user_info.*
import org.greenrobot.eventbus.EventBus
import java.io.File
import java.util.*


class UserInfoActivity : BaseActivity() {

    private val CAMERA = 3
    private val ALBUM = 4
    private val CROP_PHOTO = 5
    private val USER_NAME_UPDATE = 1
    private val PERMISSION_RESULT = 6

    private var cacheFile: File? = null
    private var cachePath: String = ""
    private val fileString = "crop_image.jpg"
    private val cameraPictureName = "output_image.jpg"
    private var cameraFile: File? = null
    private var imageUri: Uri? = null


    var userBean: UserBean = UserBean()

    //动态获取权限监听
    private var mListener: PermissionListener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_info)
        initActionBar(centerTitle = "个人信息")

        initView()
        initEvent()
        initListener()

    }


    /**
     * 修改手机号码之后跟新本页数据 此处偷懒
     */
    override fun onStart() {
        super.onStart()
        info_phone.text = hintPassword()
        info_real_name.text = if (DbUtil().getUserBean().isRealName == 1) "已认证" else "未认证"
        info_bind_bank.text = if (DbUtil().getUserBean().isBindBank == 1) "已绑定" else "未绑定"
    }


    override fun initEvent() {
        super.initEvent()


        cachePath = FileUtil.getDiskCacheDir(this) + "/$fileString"
        cacheFile = FileUtil.getCacheFile(File(FileUtil.getDiskCacheDir(this)), fileString)

        info_nick_name.text = DbUtil().getUserBean().nickName
        info_sex.text = sexToString()
        info_phone.text = hintPassword()
        ImageLoaderUtil.displayHeadImg(DbUtil().getUserBean().avatar, header_img)
    }


    override fun initListener() {
        super.initListener()

        val intent = Intent(this, PhoneCheckActivity::class.java)

        /**
         * 修改密码
         */
        info_password_relatvie.setOnClickListener {
            intent.putExtra("type", CodeTypeEnum.UpdatePassword.type)
            intent.putExtra("title", "手机号码验证")
            startActivity(intent)
        }

        /**
         * 更换手机
         */
        info_phone_relative.setOnClickListener {
            // 更换手机
            intent.putExtra("type", CodeTypeEnum.UpdatePhone.type)
            intent.putExtra("title", "原手机号码验证")
            startActivity(intent)
        }

        /**
         * 修改性别
         */
        info_sex.setOnClickListener { openUpdateSexPopupWindow() }


//        info_nick_name.setOnClickListener { startActivityForResult(Intent(this, UpdateUserNameActivity::class.java), USER_NAME_UPDATE) }


        /**
         * 修改头像
         */
        info_header_img.setOnClickListener { openChoseHeaderImgPopupWindow() }


        /**
         * 绑定银行卡
         */
        info_bing_bank_relative.setOnClickListener {
            if (DbUtil().getUserBean().isRealName == 0) {
                showToast("未实名认证,无法绑定银行卡")
                return@setOnClickListener
            }
            startActivity(Intent(this, BindBankActivity::class.java))
        }


        /**
         * 实名认证
         */
        info_real_name_relative.setOnClickListener { startActivity(Intent(this, RealNameActivity::class.java)) }

    }


    /**
     * android 6.0 需要写运行时权限
     * @param permissions 需请求的权限集合
     * @param listener 请求结果监听
     */
    private fun requestRuntimePermission(permissions: Array<String>, listener: PermissionListener) {
        mListener = listener
        val permissionList = ArrayList<String>()

        permissions.filterTo(permissionList) { ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED }
        if (permissionList.isNotEmpty()) {
            ActivityCompat.requestPermissions(this, permissionList.toTypedArray(), PERMISSION_RESULT)
        } else {
            mListener?.onGranted()
        }
    }


    /**
     * 打开相册
     */
    fun openAlbum() {
        val intent = Intent("android.intent.action.GET_CONTENT")
        intent.type = "image/*"
        startActivityForResult(intent, ALBUM)
    }

    /**
     * 打开相机
     */
    fun openCamera() {
        cameraFile = FileUtil.getCacheFile(File(FileUtil.getDiskCacheDir(this)), cameraPictureName)
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        imageUri = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
            Uri.fromFile(cameraFile)
        } else {
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            FileProvider.getUriForFile(this, MyApplication.fileProvider, cameraFile!!)
        }
        // 启动相机程序
        intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri)
        startActivityForResult(intent, CAMERA)
    }


    /**
     * 打开选择头像弹出框
     */
    private fun openChoseHeaderImgPopupWindow() {
        val popupWindow = HeaderImgWindow(this)
        popupWindow.showPopupWindow(info_relative)
        popupWindow.setAlbumBack { takePhotoForAlbum() }
        popupWindow.setBack { takePhotoForCamera() }
    }

    /**
     * 修改性别弹出框
     */
    private fun openUpdateSexPopupWindow() {
        val popupWindow = UserSexUpdateWindow(this)
        popupWindow.showPopupWindow(info_relative)
        popupWindow.setClosePressCallBack {
            info_progress_bar.visibility = View.GONE
            info_sex.text = sexToString()
        }
        popupWindow.setOpenPressCallBack { info_progress_bar.visibility = View.VISIBLE }
    }


    // activity 页面回调
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        // 用户名修改成功 更新当前的页面数据
        if (requestCode == USER_NAME_UPDATE && resultCode == Activity.RESULT_OK) {
            info_nick_name.text = DbUtil().getUserBean().nickName
            return
        }

        //获取相册选择图片的路径
        if (requestCode == ALBUM && resultCode == Activity.RESULT_OK) {
            // 判断手机系统版本号
            if (data == null) return
            // 4.4及以上系统使用这个方法处理图片
            if (Build.VERSION.SDK_INT >= 19) {
                handleImageOnKitKat(data)
                return
            }
            // 4.4以下系统使用这个方法处理图片
            handleImageBeforeKitKat(data)
            return
        }

        if (requestCode == CROP_PHOTO && resultCode == Activity.RESULT_OK) {
            var file = File(cachePath)
            requestUpdateFile(file)
            val bitmap = BitmapFactory.decodeStream(contentResolver.openInputStream(Uri.fromFile(file)))
            header_img.setImageBitmap(bitmap)
            return
        }

        //拍照获取相片  此方法获取的是其缩略图
        if (requestCode == CAMERA) {
            // 将拍摄的照片显示出来
            imageCompress(cameraFile as File)
        }
    }


    /**
     * 获取选择本地图片时的读写权限
     */
    private fun takePhotoForAlbum() {
        val permissions = arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE)
        requestRuntimePermission(permissions, object : PermissionListener {
            override fun onGranted() {
                openAlbum()
            }

            override fun onDenied(deniedPermission: List<String>) {

            }
        })
    }

    /**
     * 获取拍照权限
     */
    private fun takePhotoForCamera() {
        val permissions = arrayOf(Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE)
        requestRuntimePermission(permissions, object : PermissionListener {
            override fun onGranted() {
                openCamera()
            }

            override fun onDenied(deniedPermission: List<String>) {
            }
        })

    }

    /**
     * 4.4及以上系统使用这个方法处理图片
     */
    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun handleImageOnKitKat(data: Intent) {
        val uri = data.data
        val imagePath = FileUtil.getUriToPathAfterKitKat(this, uri)
        startPhotoZoom(File(imagePath), 400)
    }


    /**
     * 4.4以下系统使用这个方法处理图片
     */
    private fun handleImageBeforeKitKat(data: Intent) {
        val uri = data.data
        val imagePath = FileUtil.getUriToPathBeforeKitKat(this, uri, null)
        startPhotoZoom(File(imagePath), 180)
    }

    /**
     * 对图片进行旋转和压缩
     * @param  file 待处理的图片
     */

    private fun imageCompress(file: File) {
        var degree = ImageUtil.getBitmapDegree(file.absolutePath)
        // 对有角度的图片进行本地覆盖
        if (degree != 0) {
            val bitmap = ImageUtil.rotateBitmapByDegree(BitmapFactory.decodeFile(file.absolutePath), degree)
            cameraFile = ImageUtil.saveThePicture(bitmap, cameraFile!!)
        }
        startPhotoZoom(cameraFile!!, 180)
    }

    /**
     * 剪裁图片
     * @param file 带裁剪文件
     * @param size 裁剪尺寸
     */
    private fun startPhotoZoom(file: File, size: Int) {
        val intent = Intent("com.android.camera.action.CROP")
        intent.setDataAndType(FileUtil.getFileContentUri(this, file), "image/*")//自己使用Content Uri替换File Uri
        intent.putExtra("crop", "true")
        intent.putExtra("aspectX", 1)
        intent.putExtra("aspectY", 1)
        intent.putExtra("outputX", size)
        intent.putExtra("outputY", size)
        intent.putExtra("scale", true)
        intent.putExtra("return-data", false)
        intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(cacheFile))//定义输出的File Uri
        intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString())
        intent.putExtra("noFaceDetection", true)
        startActivityForResult(intent, CROP_PHOTO)
    }


    /**
     * 头像上传
     * @param  file  待上传的文件
     * @return
     */
    private fun requestUpdateFile(file: File) {

        UserPresenter.requestUpdateFile(
                context = this,
                file = file,
                onSuccess = {
                    val userBean = DbUtil().getUserBean()
                    userBean.avatar = it.avatar
                    DbUtil().setUserBean(userBean)
                    EventBus.getDefault().post(EventBusBean("login"))
                }

        )
//        HttpUtil().requestUpdateFile(this,file, object : ResponseObject<UserBean> {
//            override fun onSuccess(`object`: UserBean) {
//                userBean = `object`
//                var user = DbUtil().userBean
//                user.avatar = userBean.avatar
//                DbUtil().userBean = user
//                // 通知头像进行刷新
//                EventBus.getDefault().post(MessageEvent("login"))
//            }
//
//            override fun onFailure(httpError: HttpError?) {
//                showToast(httpError?.message)
//            }
//        })
    }

    /**
     * 判断用户性别
     */
    fun sexToString(): String = when (DbUtil().getUserBean().gender) {
        "1" -> "男"
        "2" -> "女"
        else -> "保密"
    }


    /**
     * 隐藏部分手机号码
     */
    private fun hintPassword(): String {
        var phone = DbUtil().getUserBean().phone
        if (phone.isEmpty()) return ""
        //字符串截取
        val bb = phone.substring(3, 7)
        return phone.replace(bb, "****")
    }


    /**
     * 权限回调
     */
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSION_RESULT || grantResults.isEmpty()) return
        val deniedPermissions = ArrayList<String>()
        for (i in grantResults.indices) {
            val grantResult = grantResults[i]
            val permission = permissions[i]
            if (grantResult != PackageManager.PERMISSION_GRANTED) {
                deniedPermissions.add(permission)
            }
        }
        if (deniedPermissions.isEmpty()) {
            mListener?.onGranted()
            return
        }
        mListener?.onDenied(deniedPermissions)

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


