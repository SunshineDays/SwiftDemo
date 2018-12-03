package com.caidian310.activity.user

import android.content.Intent
import android.os.Bundle
import android.text.InputType
import android.text.SpannableString
import android.text.Spanned
import android.text.SpannedString
import android.text.style.AbsoluteSizeSpan
import android.view.View
import android.widget.EditText

import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.enumBean.ThirdLoginTypeEnum
import com.caidian310.bean.eventBean.EventBusBean

import com.caidian310.bean.user.CodeBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.*
import kotlinx.android.synthetic.main.activity_user_login.*
import org.greenrobot.eventbus.EventBus

class LoginActivity : BaseActivity() {

    var type = CodeTypeEnum.LoginCode.type                      // 类型1:注册 2:找3:更换手机 4:验证码登录 5:修改密码
    private var codeBean: CodeBean? = null
    private var loginType = ThirdLoginTypeEnum.QQ.type                   // 第三方类型 1:微信 2:qq 3:微博


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_login)
        ActionBarStyleUtil.whiteActionBar(window)
        initView()
        hintActionBar()
        initListener()
    }


    override fun initView() {
        super.initView()
        login_back.setColorFilter(ColorUtil.getColor(R.color.white))
        login_net.text = AppVersion.appName
        login_agreement.text = "《${AppVersion.appName}用户协议》"
    }

    override fun initListener() {
        super.initListener()
        registerEventBus()
        login_qq.setOnClickListener(this)
        login_weixin.setOnClickListener(this)
        login_sina.setOnClickListener(this)
        login_password.setOnClickListener(this)
        login_code.setOnClickListener(this)
        login_get_code.setOnClickListener(this)
        login_back.setOnClickListener { finish() }
        login_login.setOnClickListener(this)
        login_register.setOnClickListener(this)
        login_agreement.setOnClickListener(this)
        login_forget_password.setOnClickListener(this)

    }


    /**
     * 短信验证码
     * @param phone   手机号
     * @return
     */

    private fun requestGetCode(phone: String) {

        UserPresenter.requestGetCode(context = this,
                phone = phone,
                type = CodeTypeEnum.LoginCode.type,
                onSuccess = {
                    this.codeBean = it
                },
                onFailure = {
                }
        )

    }


    /**
     * 登录 手机号+[密码|验证码]
     *
     * @param code     验证码与password二选一
     * @param password 密码长度必须大于6位且小于16位
     * @param phone
     * @return
     */

    private fun requestNormalLogin(code: String, password: String, phone: String) {

        if (!checkBok()) return

        UserPresenter.requestNormalLogin(
                context = this,
                code = code,
                password = password,
                phone = phone,
                onSuccess = {
                    DbUtil().setUserBean(it)
                    EventBus.getDefault().post(EventBusBean("login"))
                    finish()
                },
                onFailure = {})


    }

    // 检查选择框是是否选择
    private fun checkBok(): Boolean {
        return if (!login_check_box.isChecked) {
            showToast("请点击同意用户协议")
            false
        } else {
            true
        }
    }


    override fun onClick(v: View?) {
        super.onClick(v)
        when (v?.id) {

            R.id.login_weixin -> {
                //微信登录
                if (!checkBok()) return
                loginType = ThirdLoginTypeEnum.WeiXin.type
//                UMShareAPI.get(this).getPlatformInfo(this, SHARE_MEDIA.WEIXIN, umAuthListener)
            }

            R.id.login_qq -> {
                // qq登录
                if (!checkBok()) return
                loginType = ThirdLoginTypeEnum.QQ.type
//                UMShareAPI.get(this).getPlatformInfo(this, SHARE_MEDIA.QQ, umAuthListener)
            }

            R.id.login_sina -> {
                // 微博登录
                if (!checkBok()) return
                loginType = ThirdLoginTypeEnum.SiNa.type
//                UMShareAPI.get(this).getPlatformInfo(this, SHARE_MEDIA.SINA, umAuthListener)
            }
        //用户协议
            R.id.login_agreement -> {
                val intent  = Intent(this, UserAgreementActivity::class.java)
                intent.putExtra("lotteryId",0)
                intent.putExtra("title","用户协议")
                startActivity(intent)
            }
            R.id.login_register -> startActivity(Intent(this, RegisterActivity::class.java))
            R.id.login_forget_password -> {
                val intent = Intent(this, PhoneCheckActivity::class.java)
                intent.putExtra("type", CodeTypeEnum.ForgetPassword.type)
                intent.putExtra("title", "手机号码验证")
                startActivity(intent)
            }
        // 点击登录
            R.id.login_login -> {
                // 如果显示密码登录 则验证码为空
                if (login_code.visibility == View.VISIBLE)
                    requestNormalLogin("", login_user_password.text.toString(), login_user_phone.text.toString())
                else
                    requestNormalLogin(login_user_password.text.toString(), "", login_user_phone.text.toString())
            }
        // 密码登录页面
            R.id.login_password -> setPasswordLogin()

        // 验证码登录页面
            R.id.login_code -> setCodeLogin()

        //倒数计时
            R.id.login_get_code -> getCode(login_user_phone.text.toString(), CodeTypeEnum.LoginCode.type)
        }
    }

//    /**
//     * 第三方登录 请求监听
//     */
//    private val umAuthListener = object : UMAuthListener {
//        override fun onStart(platform: SHARE_MEDIA) {
//            //授权开始的回调
//            login_progress_bar.visibility = View.VISIBLE
//        }
//
//        override fun onComplete(platform: SHARE_MEDIA, action: Int, data: Map<String, String>) {
//            setThirdLoginData(data)
//        }
//
//        override fun onError(platform: SHARE_MEDIA, action: Int, t: Throwable) {
//            login_progress_bar.visibility = View.GONE
//            Toast.makeText(applicationContext, "登录失败" + t.message, Toast.LENGTH_SHORT).show()
//        }
//
//        override fun onCancel(platform: SHARE_MEDIA, action: Int) {
//            login_progress_bar.visibility = View.GONE
//            Toast.makeText(applicationContext, "已取消登录", Toast.LENGTH_SHORT).show()
//        }
//    }


    /**
     * 第三方数据登录参数删改
     * @param map  第三方返回数据
     */

    fun setThirdLoginData(map: Map<String, String>) {

//        var hashMap: HashMap<String, String> = HashMap()
//        hashMap.put("access_token", HashMapUtils().getHashMapValue(map as HashMap<String, String>, "accessToken"))
//        hashMap.put("avatar_url", HashMapUtils().getHashMapValue(map, "iconurl"))
//
//        // 获取当前的登录类型  qq 使用unionid ?: 微博 微信使用uid
//        if (loginType == ThirdLoginTypeEnum.qq.type) {
//            hashMap.put("openid", HashMapUtils().getHashMapValue(map, "unionid"))
//        } else {
//            hashMap.put("openid", HashMapUtils().getHashMapValue(map, "uid"))
//        }
//
//        hashMap.put("expiration", HashMapUtils().getHashMapValue(map, "expiration"))
//        hashMap.put("gender", HashMapUtils().getHashMapValue(map, "gender"))
//        hashMap.put("genre", loginType.toString())
//        hashMap.put("nickname", HashMapUtils().getHashMapValue(map, "name"))
//        hashMap.put("refresh_token", HashMapUtils().getHashMapValue(map, "refreshToken"))

//
//        // 将第三方数据进行适当的保存
//        thirdMap.putAll(hashMap)
//        MyApplication.getInstance().setThirdRegisterMap(thirdMap)
//
//        thirdLogin(hashMap)

    }

    // 第三方登录网络请求
    fun thirdLogin(hashMap: HashMap<String, String>) {
//        HttpUtil().requestThirdLogin(this,hashMap, object : ResponseObject<UserBean> {
//            override fun onSuccess(`object`: UserBean) {
//                // 更新用户的基本信息
//                showToast("登录成功")
//                login_progress_bar.visibility = View.GONE
//                val registerBean: UserBean = `object`
//                DbUtil().userBean = registerBean
//                EventBus.getDefault().post(MessageEvent("login"))
//                finish()
//            }
//
//            override fun onFailure(httpError: HttpError?) {
//                showToast(httpError?.message)
//                login_progress_bar.visibility = View.GONE
//                // 用户未注册
//                if (httpError?.code == 1008)
//                    startActivity(Intent(baseContext, ThirdRegisterActivity::class.java))
//
//            }
//        })
    }


    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)
        // 注册成功
        if (event.loginMessage == "closeLogin") {
            finish()
        }

    }

    // 设置EditText 的hint
    private fun setEditTextHintText(message: String, editText: EditText) {
        val ss = SpannableString(message)
        val ass = AbsoluteSizeSpan(12, true)
        ss.setSpan(ass, 0, ss.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        editText.hint = SpannedString(ss) // 一定要进行转换,否则属性会消失
    }


    //密码登录时页面显示
    private fun setPasswordLogin() {
        login_user_password.text = null
        login_code.visibility = View.VISIBLE
        login_password.visibility = View.GONE
        login_get_code.visibility = View.GONE
        login_user_img.setImageResource(R.mipmap.icon_head)
        setEditTextHintText("请输入您的密码", login_user_password)
        login_user_password.inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD

    }

    //验证码登录时页面显示
    private fun setCodeLogin() {
        login_user_password.text = null
        login_code.visibility = View.GONE
        login_password.visibility = View.VISIBLE
        login_get_code.visibility = View.VISIBLE
        login_user_img.setImageResource(R.mipmap.icon_phone)
        setEditTextHintText("请输入您的验证码", login_user_password)
        login_user_password.inputType = InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD

    }

    // 获取验证码 倒计时开始
    private fun getCode(phone: String, type: Int) {
        if (phone.isEmpty()) {
            showToast("手机号码不能为空")
            return
        }
        // 获取验证码倒计时
        TimeUtil.countDownTimerCode(login_get_code, ColorUtil.getColor(R.color.colorPrimaryDark), ColorUtil.getColor(R.color.grayNine))
        requestGetCode(phone)
    }

//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
//        super.onActivityResult(requestCode, resultCode, data)
////        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data)
//    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterEventBus()
    }

}
