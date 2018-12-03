package com.caidian310.activity.user

import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.user.CodeBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.TimeUtil
import kotlinx.android.synthetic.main.activity_user_phone_check.*

class PhoneCheckActivity : BaseActivity() {


    var type: Int = CodeTypeEnum.ForgetPassword.type
    var codeBean: CodeBean ?=null
    var title = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_phone_check)
        initEvent()
        initActionBar(centerTitle = title)
        initListener()
    }


    override fun initEvent() {
        super.initEvent()

        // 初始化参数
        type = intent.getIntExtra("type", CodeTypeEnum.ForgetPassword.type)
        title = intent.getStringExtra("title")

        // 如果是手机号验证 禁止用户修改手机号
        check_phone.setText(DbUtil().getUserBean().phone)
        if (type != CodeTypeEnum.ForgetPassword.type) check_phone.isEnabled = false
    }

    override fun initListener() {
        super.initListener()
        check_get_code.setOnClickListener { requestGetCode(check_phone.text.toString(), type) }
        check_commit.setOnClickListener { jumpCommit(check_phone.text.toString(), check_code.text.toString()) }
    }

    /**
     * 短信验证码
     * @param phone   手机号
     * @param type    类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */

    private fun requestGetCode(phone: String, type: Int) {
        if (TextUtils.isEmpty(check_phone.text)) {
            showToast("手机号码不能为空")
            return
        }

        // 获取验证码 倒计时开始
        TimeUtil.countDownTimerCode(check_get_code, ColorUtil.getColor(R.color.colorPrimaryDark), ColorUtil.getColor(R.color.grayNine))

        UserPresenter.requestGetCode(
                context = this,
                phone = phone,
                type = type,
                onSuccess = {
                    codeBean = it
                },
                onFailure = {})
    }


    /**
     * activity跳转事件
     * @param phone 手机号码
     * @param code  验证码
     */
    private fun jumpCommit(phone: String, code: String) {

        if (code.isEmpty()) {
            showToast("验证码不能为空")
            return
        }
        if (phone.isEmpty()) {
            showToast("手机号码不能为空")
            return
        }

        updateCheckCode(code, phone, type)


    }

    /**
     * 检验完验证码后
     * 根据类型跳转
     */

    private fun startActivityFromCodeType(codeBean: CodeBean) {
        val intent = Intent(this, ForgetPasswordActivity::class.java)
        intent.putExtra("code", codeBean.code)
        intent.putExtra("phone", codeBean.phone)
        intent.putExtra("type", type)

        when (type) {
        // 密码找回
            CodeTypeEnum.ForgetPassword.type -> {
                intent.putExtra("title", "新密码")
                startActivity(intent)
            }
        // 密码修改
            CodeTypeEnum.UpdatePassword.type -> {
                intent.putExtra("title", "修改密码")
                startActivity(intent)

            }
        // 更改手机号码
            CodeTypeEnum.UpdatePhone.type -> {
                startActivity(Intent(baseContext, UpdatePhoneActivity::class.java))
            }
        }
        finish()
    }


    /**
     * 旧手机校验验证码
     * @param code 待验证的验证码
     * @param type 验证码类型
     * @param phone 请求验证码的手机号码
     */
    private fun updateCheckCode(code: String, phone: String, type: Int) {
        UserPresenter.requestCheckCode(
                context = this,
                code = code,
                phone = phone,
                type = type,
                onSuccess = { startActivityFromCodeType(it) },
                onFailure = {}
        )
    }



}
