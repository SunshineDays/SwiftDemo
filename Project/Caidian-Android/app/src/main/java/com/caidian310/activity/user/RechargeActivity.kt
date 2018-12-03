package com.caidian310.activity.user

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.widget.*
import com.caidain310.activity.sport.football.RechargeTypeAdapter
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.news.NewsUrlActivity
import com.caidian310.adapter.user.UserAdapter
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.user.RechargeBean
import com.caidian310.presenter.TextPresenter
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.ActionBarStyleUtil
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.DbUtil
import kotlinx.android.synthetic.main.activity_buy_send_order.*
import kotlinx.android.synthetic.main.activity_user_recharge.*
import org.greenrobot.eventbus.EventBus


class RechargeActivity : BaseActivity() {


    private var headerView: View? = null
    private var headerMoney: EditText? = null
    private var headerMoney100: TextView? = null
    private var headerMoney200: TextView? = null
    private var headerMoney300: TextView? = null
    private var headerMoney500: TextView? = null

    private var footView: View? = null
    private var footMoreLinear: LinearLayout? = null
    private var footMoreImg: ImageView? = null


    var adapter: RechargeTypeAdapter? = null
    private var isRechargeBoolean: Boolean = false
    private var bigRechargeMoney :Int = 10000           //最大的充值金额  由后台决定
    private var textViewList: ArrayList<TextView> = ArrayList()

    private var oldList: ArrayList<RechargeBean> = ArrayList()
    private var mList: ArrayList<RechargeBean> = ArrayList()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_recharge)

        initActionBar(centerTitle = "充值",rightTitle = "帮助")

        initView()
        initEvent()
        initListener()


    }

    override fun initView() {
        super.initView()
        headerView = LayoutInflater.from(this).inflate(R.layout.layout_recharge_header, null)
        headerMoney = headerView!!.findViewById(R.id.item_recharge_money)
        headerMoney100 = headerView!!.findViewById(R.id.item_recharge_money100)
        headerMoney200 = headerView!!.findViewById(R.id.item_recharge_money200)
        headerMoney300 = headerView!!.findViewById(R.id.item_recharge_money300)
        headerMoney500 = headerView!!.findViewById(R.id.item_recharge_money500)

        footView = LayoutInflater.from(this).inflate(R.layout.item_recharge_foot, null)
        footMoreLinear = footView!!.findViewById(R.id.item_recharge_foot_more)
        footMoreImg = footView!!.findViewById(R.id.item_recharge_foot_img_down)
        footMoreImg?.setColorFilter(ColorUtil.getColor(R.color.graySix))

        recharge_list_view.addHeaderView(headerView)

        val userBean = DbUtil().getUserBean()
        recharge_name.text = userBean.nickName

    }


    override fun initEvent() {
        super.initEvent()


        textViewList.add(headerMoney100!!)
        textViewList.add(headerMoney200!!)
        textViewList.add(headerMoney300!!)
        textViewList.add(headerMoney500!!)

        adapter = RechargeTypeAdapter(context = this, payList = mList)
        recharge_list_view.adapter = adapter

        requestRechargeType()

    }


    override fun onStart() {
        super.onStart()

        requestUserDetail()

    }

    override fun initListener() {
        headerMoney100?.setOnClickListener { clickRecharge(0, true) }
        headerMoney200?.setOnClickListener { clickRecharge(1, true) }
        headerMoney300?.setOnClickListener { clickRecharge(2, true) }
        headerMoney500?.setOnClickListener { clickRecharge(3, true) }


        /**
         * 充值格式限制
         */
        headerMoney!!.addTextChangedListener(TextPresenter.setEditCount(
                editText = headerMoney!!,
                bigCount = bigRechargeMoney,
                onChange = {
                    var position = 4
                    textViewList.forEachIndexed { index, textView ->
                        if (textView.text == headerMoney!!.text.toString() + "元") position = index
                    }
                    clickRecharge(position = position)
                }
        ))


        /**
         * 展开更多充值列表
         */
        footMoreLinear?.setOnClickListener {
            if (oldList.size > 3) {
                mList.clear()
                mList.addAll(oldList)
                footMoreLinear?.visibility = View.GONE
                adapter?.notifyDataSetChanged()
            }

        }

        /**
         * 充值
         */
        recharge_sure.setOnClickListener { requestRecharge() }

        /**
         * 帮助
         */
        rightTxt?.setOnClickListener {
            startActivity(Intent(this,RechargeHelpActivity::class.java))
        }
    }




    /**
     * 充值金额点击事件
     */
    private fun clickRecharge(position: Int, clickBoolean: Boolean = false) {

        textViewList.forEachIndexed { index, textView ->
            textView.setBackgroundResource(if (index == position) R.drawable.angle_color_text_view_select else R.drawable.angle_color_text_view_normal)
            textView.setTextColor(ColorUtil.getColor(if (index == position) R.color.red else R.color.grayThree))
        }
        val content = when (position) {
            0 -> "100"
            1 -> "200"
            2 -> "300"
            3 -> "500"
            else -> ""
        }

        if (clickBoolean) headerMoney!!.setText(content)


    }


    /**
     * 充值列表请求
     */
    private fun requestRechargeType() {
        UserPresenter.requestRechargeType(
                context = this,
                onSuccess = {
                    if (it.isEmpty()) return@requestRechargeType
                    oldList.addAll(it)
                    mList.clear()
                    if (oldList.size > 3) {
                        footMoreLinear?.visibility = View.VISIBLE
                        mList.addAll(oldList.take(3))
                    } else {
                        footMoreLinear?.visibility = View.GONE
                        mList.addAll(it)
                    }
                    adapter?.notifyDataSetChanged()

                    recharge_list_view.addFooterView(footView)

                },
                onFailure = {}
        )
    }

    /**
     * 用户详情
     */
    private fun requestUserDetail() {
        UserPresenter.requestUserDetail(
                context = this,
                onSuccess = {

                    if (!isRechargeBoolean) recharge_balance.text = it.balance.toString() ?: ""

                    val money = headerMoney?.text.toString() ?: headerMoney?.hint.toString()

                    if (isRechargeBoolean && !recharge_balance.text.toString().isNullOrEmpty() && !money.isNullOrEmpty()) {
                        val newBalance = recharge_balance.text.toString().toDouble() + money.toDouble()
                        if (it.balance == newBalance) {
                            showToast("充值成功")
                            if (isRechargeBoolean)  EventBus.getDefault().post(EventBusBean("refresh"))
                        }
                        recharge_balance.text = it.balance.toString() ?: ""
                        isRechargeBoolean = false
                    }

                    recharge_root.visibility = View.VISIBLE
                    recharge_progress_bar.visibility = View.GONE

                },
                onFailure = {
                    recharge_root.visibility = View.VISIBLE
                    recharge_progress_bar.visibility = View.GONE
                }
        )
    }

    /**
     * 充值
     */
    private fun requestRecharge() {

        val key = mList.first { it.isRecommend == 1 }.key

        val money = if (!headerMoney?.text.toString().isNullOrEmpty()) headerMoney?.text.toString() else headerMoney?.hint.toString()


        if (money.isNullOrEmpty()) {
            showToast("请输入充值金额")
            return
        }

        if (money.toDouble()<10){
            showToast("充值金额不能小于10元")
            return
        }

        val bean = mList.first { it.isRecommend == 1 }
        if (money.toDouble() > bean.maxAmount.toDouble()){
            showToast("${bean.name}单次充值金额不能超过${bean.maxAmount}(元)")
            return
        }


        recharge_sure.isClickable= false
        loadingView?.show()

        UserPresenter.requestRecharge(
                context = this,
                key = key,
                money = money.toDouble(),
                onSuccess = {
                    recharge_sure.isClickable= true
                    openUrl(it)
                    loadingView?.hint()
                },
                onFailure = {
                    loadingView?.hint()
                    recharge_sure.isClickable= true
                }
        )
    }


    /**
     * 充值申请之后 后台返回Url  具体充值在浏览器打开之后在Url中操作
     */
    private fun openUrl(url: String) {

        val uri = Uri.parse(url)
        val intent = Intent(Intent.ACTION_VIEW, uri)
        startActivity(intent)

        isRechargeBoolean = true
        loadingView?.hint()

    }
}
