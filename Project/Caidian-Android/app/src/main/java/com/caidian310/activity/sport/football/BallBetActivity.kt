package com.caidian310.activity.sport.football

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.provider.SyncStateContract.Helpers.update
import android.text.Editable
import android.text.Html
import android.text.TextWatcher
import android.view.KeyEvent
import android.view.View
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.football.bet.BetGridViewAdapter
import com.caidian310.adapter.football.bet.BetShowAdapter
import com.caidian310.application.MyApplication
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.BetMatch
import com.caidian310.bean.sport.football.Match
import com.caidian310.presenter.FormatPresenter
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.presenter.TextPresenter
import com.caidian310.presenter.buy.BuyPresenter
import com.caidian310.presenter.user.UserPresenter
import com.caidian310.utils.*
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.callBack.CallPositionListBack
import kotlinx.android.synthetic.main.activity_foot_ball_bet.*
import org.greenrobot.eventbus.EventBus
import org.jetbrains.anko.editText


class BallBetActivity : BaseActivity() {
    private var gridViewAdapter: BetGridViewAdapter? = null
    private var listAdapter: BetShowAdapter? = null               //listView 源数据
    private var gridViewList: ArrayList<Int> = ArrayList()
    private var serializableMap: SerializableMap? = null

    private var betUtil: BetUtil = BetUtil()
    private var betBigCount = 1
    private var fragmentType = BetTypeEnum.spf.key
    private var lotteryTypeId = LotteryIdEnum.jczq.id

    private var multipleMoney: Double = 2.00                           //单注金额
    private var betCount: Int = 0                                      //当前注数
    private var totalMoney: Double = 0.00                              //当前金额
    private var singleBoolean: Boolean = false                         //是否支持单关
    private var betBigCanClickCount: Int = 0                           // 最大的可选中的波胆的个数
    private var serialList: ArrayList<String> = ArrayList()

    private var leagueNameList: ArrayList<BetMatch> = ArrayList()       // 联赛集合

    private var webView: WebView? = null  //用于计算金额


    var RESULTCODE = 10

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_foot_ball_bet)
        initActionBar(centerTitle = "竞彩足球")

        initView()
        initEvent()
        initListener()

    }

    override fun initView() {
        super.initView()
        icon_add.setColorFilter(ColorUtil.getColor(R.color.colorPrimaryDark))
        icon_delete_red.setColorFilter(ColorUtil.getColor(R.color.colorPrimaryDark))
    }


    override fun initEvent() {
        super.initEvent()
        registerEventBus()

        val bundle: Bundle = intent.extras
        fragmentType = bundle.getString("playType")
        lotteryTypeId = bundle.getInt("lotteryTypeId")
        serializableMap = bundle.get("choseMap") as SerializableMap

        initActionBar(centerTitle = LotteryIdEnum.jczq.getLotteryEnumFromId(lotteryTypeId).lotteryName)

        // 适配数据
        listAdapter = BetShowAdapter(context = this, map = serializableMap!!.map, lotteryId = lotteryTypeId)
        bet_list_view.adapter = listAdapter
        listAdapter?.setCallPotionBack(callDeletePositionBack)


        //串适配器
        gridViewAdapter = BetGridViewAdapter(context = this, list = gridViewList)

        initViewBetCount()
        bet_grid_view.adapter = gridViewAdapter
        gridViewAdapter?.setCallBack(gridViewCallBack)
        gridViewAdapter?.notifyDataSetChanged()

        initWebView()


    }


    /**
     * 初始化计算金额的参数
     */

    private fun initWebView() {

        webView = betUtil.getWebView(this)

        //设置本地调用对象及其接口
        webView?.addJavascriptInterface(this, "AndroidWebView")
        webView?.loadUrl("file:///android_asset/betMoney/JcBonus.html")

        webView!!.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView?, url: String?) {
                setBetMoney()
                super.onPageFinished(view, url)
            }
        }

    }

    /**
     * 添加和减少倍数  最少1倍
     * @param addBoolean 是否添加 true 添加 false 减少
     */

    private fun updateBetNumber(addBoolean: Boolean = true) {
        val content = bet_number_all.text.toString()
        var number = if (content.isNullOrEmpty()) 0 else content.toInt()
        if (addBoolean) number++                   //倍数 +
        if (!addBoolean && number > 1) number--    //倍数 －
        bet_number_all.setText(number.toString())
        setBetMoney()
    }

    override fun initListener() {
        super.initListener()

        //倍数 －
        bet_number_reduce.setOnClickListener { updateBetNumber(addBoolean = false) }

        //倍数 +
        bet_number_add.setOnClickListener { updateBetNumber() }


        /**
         * 倍数
         */
        bet_number_all.addTextChangedListener(
                TextPresenter.setEditCount(
                        editText = bet_number_all,
                        onChange = {
                            setBetString(list = gridViewAdapter!!.chosePositionList)
                        }
                ))

        //选项展开  默认展开
        bet_type_linear.setOnClickListener { if (bet_type_linear.tag == null) showBetGridView() else hintBetGridView() }

        //添加比赛
        bet_add.setOnClickListener { finish(false) }

        //清空比赛
        bet_delete.setOnClickListener { deleteAllMatch() }

        //点击事件
        bet_list_view.setOnItemClickListener { _, _, _, _ -> null }

        //下一步
        bet_step.setOnClickListener { step() }

    }

    /**
     * 下一步
     */
    private fun step() {

        if (serializableMap!!.map.size == 0) {
            showToast("请至少选择一场单关或任意两场比赛")
            return
        }

        if (serialList.size == 0) {
            showToast("请至少选择一种串关方式")
            return
        }

        if (bet_number_all.text.toString().isNullOrEmpty()) {
            showToast("投注倍数至少选择一倍")
            return
        }

        UserPresenter.requestUserDetail(
                context = this,
                onSuccess = {
                    getChoseLeagueName()
                    StartActivityPresenter.startBuyActivity(
                            context = this,
                            buyBean = getBuyBean(),
                            leagueNameList = leagueNameList
                    )
                },
                onFailure = {}
        )

    }


    //玩法收起
    private fun hintBetGridView() {
        bet_grid_view.visibility = View.GONE
        bet_type_img.rotation = 180f
        bet_type_linear.tag = null
    }

    //玩法展开
    private fun showBetGridView() {
        bet_grid_view.visibility = View.VISIBLE
        bet_type_img.rotation = 0f
        bet_type_linear.tag = "已展开"

    }


    /**
     * 获取购买的参数
     */

    private fun getBuyBean() = BuyPresenter.getBetBuyBean(
            lotteryId = lotteryTypeId,
            orderTypeId = OrderTypeEnum.Purchasing.id,
            isSecret = 0,
            playId = PlayIdEnum.hunhe.getPlayEnumFromType(fragmentType).id,
            serialList = serialList,
            map = serializableMap!!.map,
            multiple = bet_number_all.text.toString().toInt(),
            totalMoney = totalMoney,
            betCount = betCount,
            issue = getMinIssue()

    )


    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)
        if (event.loginMessage == "paySuccess") {
            finish()
        }
    }


    private var gridViewCallBack: CallPositionListBack = object : CallPositionListBack {
        override fun onClickListener(positionList: ArrayList<Int>) {

            setBetString(list = positionList)
            gridViewWave(choseList = positionList)
        }
    }


    /**
     * 获取所选项的联赛名
     */
    private fun getChoseLeagueName() {
        leagueNameList.clear()
        for ((key, _) in serializableMap!!.map) {
            if (leagueNameList.none { it.name == key.leagueName }) leagueNameList.add(BetMatch(name = key.leagueName, color = key.color))
        }

    }


    /**
     * 修改map.key中的波胆点击状态  此处修改不能修改map的地址值
     * @param waveBoolean 是否支持波胆
     * @param clickWaveBoolean 是否点击了波胆
     */

    private fun copyHashMap(waveBoolean: Boolean = true, clickWaveBoolean: Boolean = false) {

        val newMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
        for ((key, value) in serializableMap!!.map) {
            key.wave = waveBoolean
            key.clickWave = clickWaveBoolean
            newMap[key] = value

        }
        serializableMap?.map?.clear()
        serializableMap?.map?.putAll(newMap)

    }

    /**
     * 波胆显示的条件 串关方式-1 + 一点击的项数
     * 每次点击 都按最大的串关方式计算波胆
     */
    fun gridViewWave(choseList: ArrayList<Int>) {

        //没有串关方式||最大的支持项||单关  不可点击波胆
        if (choseList.size == 0 || betBigCount == choseList.max()) {
            copyHashMap(waveBoolean = false)
            betBigCanClickCount = 0
        } else {
            betBigCanClickCount = choseList.min()!!.toInt() - 1
            copyHashMap(waveBoolean = true)

        }

        listAdapter?.notifyDataSetChange(betBigCanClickCount = betBigCanClickCount)
        setBetMoney()

    }


    /**
     * 选项删除的回调函数
     * 已经选择的串项 全部清空  默认选组最后一条
     */

    private var callDeletePositionBack: CallPositionBack = object : CallPositionBack {
        override fun callPositionBack(position: Int, describe: String) {
            if (describe == "delete") {
                deletePositionBack(position)
                return
            }
            if (describe == "update") {
                finish(false)
                return
            }
            //点击波胆之后的计算注数
            setBetString(list = gridViewAdapter!!.chosePositionList)
        }
    }


    /**
     * 串关文字
     * @param list 已选中的项
     */
    fun setBetString(list: ArrayList<Int>) {
        list.sort()
        serialList.clear()
        if (list.size == 0) {
            betCount = 0
            bet_type.text = "投注方式(必选)"
            setBetMoney()
            return
        }
        var typeString = ""
        list.forEach {
            typeString += if (it == 1) "单关," else "${it}串1,"
            serialList.add("${it}串1")
        }
        bet_type.text = typeString.substring(0, typeString.length - 1)
        setBetMoney()


    }

    /**
     * 初始化 计算串关参数
     */

    private fun initViewBetCount() {

        gridViewList.clear()
        serialList.clear()

        betBigCount = if (serializableMap!!.map.size != 0) betUtil.getBetOnLastCount(map = serializableMap!!.map) else 0   //本次选择支持的最大的串数
        singleBoolean = betUtil.judgeSingle(map = serializableMap!!.map)        // 是否支持单关

        val minCount = if (singleBoolean) 1 else 2                                  //本次选择支持的最小的串数
        for (i in minCount..betBigCount) gridViewList.add(i)                        //串数的组合


        if (!singleBoolean && gridViewList.size == 0) {

            bet_type.text = "投注方式(必选)"

        } else {
            serialList.add(betBigCount.toString() + "串1")
            gridViewAdapter?.chosePositionList?.add(betBigCount)
            bet_type.text = if (betBigCount == 1) "单关" else betBigCount.toString() + "串1"
        }

        gridViewAdapter?.notifyDataSetChanged()

    }


    /**
     * listView  删除本条选项回调函数处理
     * @param deletePosition 删除的match.id
     *
     */
    fun deletePositionBack(deletePosition: Int) {

        val keyList = ArrayList(serializableMap!!.map.keys)
        keyList.forEach { if (it.id == deletePosition) serializableMap!!.map.remove(it) }  //删除选中数据中的本条数据

        gridViewAdapter!!.chosePositionList.clear()     //清空串关的选中项

        initViewBetCount()
        setBetString(list = gridViewAdapter!!.chosePositionList)

        if (serializableMap!!.map.size==0)  finish(true)

        // 没有玩法  默认收起
        if (gridViewList.size == 0) hintBetGridView()

    }


    /**
     * 获取多期选择中的最小期 -> 距离当前最近的期号
     * @return 最近期号
     */

    private fun getMinIssue(): String {
        val keyList = ArrayList(serializableMap!!.map.keys)
        return keyList.minBy { it.issue }!!.issue
    }

    /**
     * 清空比赛 将左右的比赛添加到带删除的集合中
     */

    private fun deleteAllMatch() {
        for ((key, _) in serializableMap!!.map) {
            listAdapter!!.deletePositionList.add(key.id)
        }

        finish(isClearBoolean = true)
    }


    fun finish(isClearBoolean: Boolean = false) {

        if (isClearBoolean) postEvent(EventBusBean(loginMessage = Constant.dltClear))
        else postEvent(EventBusBean(fragmentType, listAdapter!!.deletePositionList))
        listAdapter!!.deletePositionList.clear()
        finish()
    }


    override fun onClick(v: View?) {
        if (v?.id == R.id.bar_back) {
            showDiaLog()
            return
        }
        super.onClick(v)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            showDiaLog()
            return false
        }
        return super.onKeyDown(keyCode, event)
    }

    /**
     * 是否返回对话框
     */

    private fun showDiaLog() {
        DialogUtil.showDialog(
                context = this,
                messageString = "确定清空所有信息 ? ",
                onSure = {
                    it.dismiss()
                    finish(isClearBoolean = true)
                },
                onCancel = {}
        )
    }


    override fun onDestroy() {
        super.onDestroy()
        unregisterEventBus()
    }

    /**
     * 设置总共多少钱 默认单注为2元*倍数
     */
    private fun setBetMoney() {

        val newBetCount = if (bet_number_all.text.isNullOrEmpty()) 0 else bet_number_all.text.toString().toInt()
        totalMoney = betCount * multipleMoney * newBetCount.toDouble()

        //计算预估金额
        if (newBetCount == 0) {
            bet_count_and_money.text = Html.fromHtml("<font color='#FF4422'>0</font>注,共<font color='#FF4422'>0</font>元")
            bet_estimate_money.text = Html.fromHtml("预估奖金<font color='#FF4422'>0.00~0.00</font>元")
            return
        }

        betUtil.getBetMoney(webView = webView!!, choseMap = serializableMap!!.map, typeList = serialList, mutil = newBetCount, lotteryId = lotteryTypeId)
    }

    @JavascriptInterface
    fun getBetMoneyFromJs(minMoney: Double, maxMoney: Double, codeCount: Int) {   //提供给js调用的方法

        runOnUiThread {
            betCount = codeCount
            val newMutable = if (bet_number_all.text.toString().isNullOrEmpty()) 0.0 else bet_number_all.text.toString().toDouble()
            totalMoney = betCount.toDouble() * newMutable * 2.0
            bet_estimate_money.text = Html.fromHtml("预估奖金<font color='#FF4422'>${FormatPresenter.getBigDecimalString(minMoney)}~${FormatPresenter.getBigDecimalString(maxMoney)}</font>元")
            bet_count_and_money.text = Html.fromHtml("<font color='#FF4422'>$codeCount</font>注,共<font color='#FF4422'>${FormatPresenter.getBigDecimalString(totalMoney)}</font>元")

        }

    }

}





