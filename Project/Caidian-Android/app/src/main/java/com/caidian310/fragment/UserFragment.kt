package com.caidian310.fragment


import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import com.caidian310.R
import com.caidian310.activity.user.*
import com.caidian310.adapter.user.UserAdapter
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.fragment.base.BaseFragment
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.DbUtil
import com.caidian310.utils.DialogUtil
import com.caidian310.utils.ImageLoaderUtil
import com.caidian310.utils.ImageUtil
import kotlinx.android.synthetic.main.fragment_user.*


/**
 * 用户中心
 * A simple [Fragment] subclass.
 */
class UserFragment : BaseFragment() {


    private var settingList: ArrayList<HashMap<String, Any>> = ArrayList()


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_user, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        initEvent()
        initListener()

    }


    override fun initEvent() {
        super.initEvent()
        registerEventBus()
        my_name.text = DbUtil().getUserBean().nickName
        my_phone.text = DbUtil().getUserBean().phone
        if (TextUtils.isEmpty(DbUtil().getUserBean().token)) userUnLogin()
        else userLogin()

        setSettingData()

    }

    override fun initListener() {
        super.initListener()

        /**
         * 注册
         */
        my_need_register.setOnClickListener { context!!.startActivity(Intent(context, RegisterActivity::class.java)) }

        /**
         * 登录
         */
        my_need_login.setOnClickListener { context!!.startActivity(Intent(context, LoginActivity::class.java)) }

        /**
         * 个人信息
         */
        my_round_head_img.setOnClickListener { if (!TextUtils.isEmpty(DbUtil().getUserBean().token)) startActivity(Intent(activity, UserInfoActivity::class.java)) }

        /**
         * 充值
         */
        my_recharge.setOnClickListener {

            UserPresenter.requestUserDetail(
                    context = context!!,
                    onSuccess = { startActivity(Intent(activity, RechargeActivity::class.java)) },
                    onFailure = {}
            )
        }

        /**
         * 提现  用户是否登录-> 实名认证-> 绑定银行卡 ->  提现
         */
        my_withdrawals.setOnClickListener {

            if (System.currentTimeMillis() - exitTime <  1000) {
                exitTime = System.currentTimeMillis()
                return@setOnClickListener
            }
            UserPresenter.requestUserDetail(context = context!!,
                    onSuccess = { userWithdraw() },
                    onFailure = {
                        exitTime = System.currentTimeMillis()
                    }
            )
        }

    }

    /**
     * 用户提现
     */
    private fun userWithdraw() {

        exitTime = System.currentTimeMillis()

        if (DbUtil().getUserBean().isRealName == 0) {
            showDialog("请先进行实名认证", true)
            return
        }
        if (DbUtil().getUserBean().isBindBank == 0) {
            showDialog("请先绑定银行卡", false)
            return
        }
        startActivity(Intent(activity, WithdrawCashActivity::class.java))
    }

    /**
     * 提示对话框
     */

    private fun showDialog(message: String, isRealNameBoolean: Boolean) {
        DialogUtil.showDialog(
                context = activity!!,
                messageString = message,
                onSure = {
                    if (isRealNameBoolean) startActivity(Intent(activity, RealNameActivity::class.java))
                    if (!isRealNameBoolean) startActivity(Intent(activity, BindBankActivity::class.java))
                    it.dismiss()

                },
                onCancel = {}
        )
    }


    override fun getEventData(event: EventBusBean) {

        // 用户已经登录
        if (event.loginMessage == "login") {
            requestAccountDetail()
            return
        }
        // 用户未登录
        if (event.loginMessage == "outLogin") {
            userUnLogin()
            return
        }

        if (event.loginMessage == "refresh") {
            requestAccountDetail()
            return
        }
        super.getEventData(event)

    }

    override fun onStart() {
        ImageLoaderUtil.displayHeadImg(ImageUtil.imageTailor(DbUtil().getUserBean().avatar, 120, 120), my_round_head_img)
        if (DbUtil().getUserBean().token.isNotEmpty()) requestAccountDetail()
        super.onStart()
    }

    /**
     * 用户详细信息
     */
    private fun requestAccountDetail() {
        UserPresenter.requestUserDetail(context = context!!,
                onSuccess = {
                    userLogin()
                    my_balance.text = it.balance.toString()
                    my_reward.text = it.reward.toString()
                    my_money.text = (it.balance + it.reward).toString()

                },
                onFailure = {
                    userUnLogin()
                    my_balance.text = "0"
                    my_reward.text = "0"
                    my_money.text = "0"
                }
        )
    }


    // 用户登录状态
    private fun userLogin() {

        my_login.visibility = View.VISIBLE
        my_unlogin.visibility = View.GONE

        my_name.text = DbUtil().getUserBean().nickName
        my_phone.text = DbUtil().getUserBean().phone

        // 如果是2  显示女头像 1 显示男头像 2 保密不显示
        my_sex.visibility = View.VISIBLE
        when (DbUtil().getUserBean().gender) {
            "2" -> my_sex.setImageResource(R.mipmap.icon_women)
            "1" -> my_sex.setImageResource(R.mipmap.icon_man)
            else -> my_sex.visibility = View.GONE
        }

    }


    // 用户未登录状态
    private fun userUnLogin() {
        my_login.visibility = View.GONE
        my_unlogin.visibility = View.VISIBLE
        my_balance.text = "-"
        my_money.text = "-"
        my_reward.text = "-"
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterEventBus()
    }


    private fun setSettingData() {

        settingList.clear()
        var m: MutableMap<String, Any>

        m = HashMap()
        m["txt"] = "购彩记录"
        m["state"] = ""
        m["img"] = R.mipmap.ic_btn_search_go
        settingList.add(m)

        m = HashMap()
        m["txt"] = "账户明细"
        m["state"] = ""
        m["img"] = R.mipmap.ic_btn_search_go
        settingList.add(m)

        m = HashMap()
        m["txt"] = "设置"
        m["state"] = ""
        m["img"] = R.mipmap.ic_btn_search_go
        settingList.add(m)

        my_list_view.adapter = UserAdapter(context = context!!, mapList = settingList)
        my_list_view.onItemClickListener = listViewItemClick

    }


    private var exitTime: Long = 0



    private val listViewItemClick = AdapterView.OnItemClickListener { _, _, position, _ ->

        if (System.currentTimeMillis() - exitTime <  1000) {
            exitTime = System.currentTimeMillis()
            return@OnItemClickListener
        }

        /**
         * 设置页面不需要判断是否登录
         */
        if (position == 2) {
            exitTime = System.currentTimeMillis()
            startActivity(Intent(context, SettingActivity::class.java))
            return@OnItemClickListener
        }

        /**
         * 先判断是否登录 再进行跳转
         */
        UserPresenter.requestUserDetail(
                context = context!!,
                onSuccess = {
                    when (position) {

                        0 -> startActivity(Intent(context, BuyListActivity::class.java))
                        1 -> startActivity(Intent(context, PayLogActivity::class.java))
                        else -> { }

                    }
                    exitTime = System.currentTimeMillis()
                },
                onFailure = {
                    exitTime = System.currentTimeMillis()
                }
        )


    }


}
