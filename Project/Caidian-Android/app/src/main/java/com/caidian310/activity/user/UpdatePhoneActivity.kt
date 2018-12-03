package com.caidian310.activity.user

import android.os.Bundle
import android.text.TextUtils
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.bean.enumBean.CodeTypeEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.user.CodeBean
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import com.caidian310.utils.TimeUtil
import kotlinx.android.synthetic.main.activity_user_update_phone.*
import org.greenrobot.eventbus.EventBus

class UpdatePhoneActivity : BaseActivity() {

    var codeBean: CodeBean ?=null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_update_phone)

        initActionBar(centerTitle = "新手机号码绑定")
        initListener()
    }

    override fun initListener() {
        super.initListener()
        update_get_code.setOnClickListener { requestGetCode(update_phone.text.toString(), CodeTypeEnum.UpdatePhone.type) }
        update_commit.setOnClickListener { requestChangePhone(update_code.text.toString(), update_phone.text.toString()) }
    }


    /**
     * 短信验证码
     * @param phone   手机号
     * @param type    类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */

    private fun requestGetCode(phone: String, type: Int) {
        if (TextUtils.isEmpty(update_phone.text)) {
            showToast("手机号码不能为空")
            return
        }
        // 获取验证码 倒计时开始
        TimeUtil.countDownTimerCode(update_get_code, ColorUtil.getColor(R.color.colorPrimaryDark), ColorUtil.getColor(R.color.grayNine))

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
     * 更换新手机网络请求
     * @param code 验证码
     * @param phone 手机号码
     */
    private fun requestChangePhone(code: String, phone: String) {

        UserPresenter.requestChangePhone(
                context = this,
                code = code,
                phone = phone,
                onSuccess = {
                    showToast("手机号码修改成功")
                    DbUtil().setUserBean(it)
                    EventBus.getDefault().post(EventBusBean("login"))
                    finish()
                },
                onFailure = {}
        )

    }
}
