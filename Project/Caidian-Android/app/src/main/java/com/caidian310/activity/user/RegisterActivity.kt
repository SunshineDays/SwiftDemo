package com.caidian310.activity.user

import android.os.Bundle
import android.os.CountDownTimer
import android.text.TextUtils

import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.utils.TimeUtil.countDownTimerCode
import com.caidian310.utils.ToastUtil
import kotlinx.android.synthetic.main.activity_user_phone_check.*

import kotlinx.android.synthetic.main.activity_user_register.*
import org.greenrobot.eventbus.EventBus

class RegisterActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_register)

        initActionBar(centerTitle = "注册")

        initListener()
    }


    override fun initListener() {
        super.initListener()
        register_get_code.setOnClickListener {

            if (TextUtils.isEmpty(register_phone.text)) {
                showToast("手机号码不能为空")
                return@setOnClickListener
            }

            // 获取验证码 倒计时开始
            TimeUtil.countDownTimerCode(register_get_code, ColorUtil.getColor(R.color.colorPrimaryDark), ColorUtil.getColor(R.color.grayNine))

            UserPresenter.requestGetCode(context = this,
                    phone = register_phone.text.toString(),
                    type = CodeTypeEnum.Register.type,
                    onSuccess = {
                        if (it.isUser == 1) showToast("用户已注册,请登录")
                        else showToast("验证码发送成功")

                    },
                    onFailure = {})

        }
        register_commit.setOnClickListener {
            requestNormalRegister(
                    code = register_code.text.toString(),
                    nickname = register_user.text.toString(),
                    password = register_password.text.toString(),
                    phone = register_phone.text.toString())
        }
    }


    /**
     * 注册请求
     * @param phone 手机号
     * @param code  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */

    private fun requestNormalRegister(code: String, nickname: String, password: String, phone: String) {



        UserPresenter.requestNormalRegister(context = this,
                code = code,
                nickname = nickname,
                password = password,
                phone = phone,
                onSuccess = {
                    DbUtil().setUserBean(userBean = it)
                    showToast("注册成功")
                    EventBus.getDefault().post(EventBusBean("closeLogin"))
                    EventBus.getDefault().post(EventBusBean("login"))
                    finish()


                },
                onFailure = { showToast(it.message) })

    }


}
