package com.caidian310.activity.user

import android.os.Bundle
import android.view.View
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.DbUtil
import kotlinx.android.synthetic.main.activity_user_real_name.*

class RealNameActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_user_real_name)
        initActionBar(centerTitle = "实名认证")

        initEvent()
    }



    override fun initEvent() {
        super.initEvent()

        if (DbUtil().getUserBean().isRealName == 1) {
            viewReal()
            requestRealDetail()

        } else {
            viewNoReal()
        }

        real_sure.setOnClickListener { requestRealInfo() }

    }

    /**
     * UI 已认证状态
     */

    private fun viewReal() {
        real_card_two_linear.visibility = View.GONE
        real_sure.isEnabled = false
        real_name.isEnabled = false
        real_card.isEnabled = false

        real_sure.text = " 已 认 证"
    }

    /**
     * UI 未 认证状态
     */

    private fun viewNoReal() {
        real_card_two_linear.visibility = View.VISIBLE
        real_name.isEnabled = true
        real_sure.isEnabled = true
        real_card.isEnabled = true
        real_sure.text =   "认  证"
    }

    /**
     * 获取真实信息
     */

    private fun requestRealDetail() {
        UserPresenter.requestRealDetail(
                context = this,
                onSuccess = {
                    real_card.setText(it.cardCode)
                    real_name.setText(it.realName)
                }
        )
    }

    /**
     * 验证正式姓名 || 身份证号码 == 重复身份证号码
     */

    private fun requestRealInfo() {
        UserPresenter.requestRealInfo(
                context = this,
                idCard = real_card.text.toString(),
                idCardTwo = real_card_two.text.toString(),
                realName = real_name.text.toString(),
                onSuccess = {
                    showToast("实名认证成功")
                    viewReal()
                    val userBean = DbUtil().getUserBean()
                    userBean.isRealName = 1
                    DbUtil().setUserBean(userBean)
                }
        )

    }
}
