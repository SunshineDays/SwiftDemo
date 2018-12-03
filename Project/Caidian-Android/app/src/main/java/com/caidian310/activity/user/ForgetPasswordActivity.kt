package com.caidian310.activity.user

import android.os.Bundle
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.DbUtil
import kotlinx.android.synthetic.main.activity_user_forget_password.*
import org.greenrobot.eventbus.EventBus

class ForgetPasswordActivity : BaseActivity() {

    var number = 1   // 默认并不显示密码 ? 2
    var code = ""
    var phone = ""
    var title = ""
    var type = CodeTypeEnum.ForgetPassword.type
    private var newPassword = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_forget_password)

        initEvent()
        initListener()
    }

    override fun initEvent() {
        super.initEvent()
        code = intent.getStringExtra("code")
        phone = intent.getStringExtra("phone")
        title = intent.getStringExtra("title")
        type = intent.getIntExtra("type", CodeTypeEnum.LoginCode.type)
        initActionBar(centerTitle = title)

    }


    override fun initListener() {
        super.initListener()
        update_check_box.setOnClickListener {
            if (number == 1) {
                // 显示密码
                update_password.transformationMethod = HideReturnsTransformationMethod.getInstance()
                update_check_box.setImageResource(R.mipmap.icon_password_press)

                number = 2
            } else {
                // 不显示密码
                update_password.transformationMethod = PasswordTransformationMethod.getInstance()
                newPassword = update_password.text.toString()
                update_check_box.setImageResource(R.mipmap.icon_password_normal)
                number = 1
            }
            update_password.setSelection(update_password.text.toString().length)
        }

        update_commit.setOnClickListener {
            // 找回密码
            if (type==CodeTypeEnum.ForgetPassword.type) {
                requestForgetPassword(code, update_password.text.toString(), phone)
            } else {
                requestUpdatePassword(code, update_password.text.toString(), phone)
            }
        }
    }

    /**
     * 手机 修改密码
     *
     * @param code     验证码
     * @param password 新密码
     * @param phone    手机号
     * @return
     */
    private fun requestUpdatePassword(code: String, password: String, phone: String) {

        if (code.isEmpty() || phone.isEmpty()) return

        if (password.isEmpty()) {
            showToast("密码不能为空")
            return
        }

        if (password.length>16||password.length<6){
            showToast("请输入6-16的字母或数字组合")
            return
        }

        UserPresenter.requestUpdatePassword(
                context = this,
                code = code,
                password = password,
                phone = phone,
                onSuccess = {
                    DbUtil().setUserBean(it)
                    EventBus.getDefault().post(EventBusBean("login"))
                    EventBus.getDefault().post(EventBusBean("closeLogin"))
                    finish()
                },
                onFailure = {}
        )


    }

    /**
     * 手机 找回密码
     * @param code        验证码
     * @param password   新密码
     * @param phone       手机号码
     */

    private fun requestForgetPassword(code: String, password: String, phone: String) {
        if (code.isEmpty() || phone.isEmpty()) return
        if (password.isEmpty()) {
            showToast("密码不能为空")
            return
        }

        UserPresenter.requestSeekPassword(
                context = this,
                code = code,
                password = password,
                phone = phone,
                onSuccess = {
                    DbUtil().setUserBean(it)
                    EventBus.getDefault().post(EventBusBean("login"))
                    EventBus.getDefault().post(EventBusBean("closeLogin"))
                    finish()
                },
                onFailure = {}
        )

    }


}
