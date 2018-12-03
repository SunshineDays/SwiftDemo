package com.caidian310.activity.sport.basketball

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.activity.sport.football.BaseBasketballAdapter
import com.caidian310.adapter.basketball.*
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.baskball.BasketballHelp
import com.caidian310.http.HttpUtil
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.presenter.baskball.BasketBallPresenter
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.Constant
import com.caidian310.view.callBack.CallBack
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.popupWindow.FootBallMoreWindow
import com.caidian310.view.popupWindow.PlayTypeChoseWindow
import kotlinx.android.synthetic.main.activity_foot_ball.*
import org.jetbrains.anko.doAsync


class BasketBallActivity : BaseActivity() {

    private var playTypeChoseWindowTitle = arrayListOf("胜负", "让分胜负", "大小分", "混合投注", "胜分差")


    private var playWindow: PlayTypeChoseWindow? = null    //玩法选择
    private var popMore: FootBallMoreWindow? = null


    private var centerTxtView: TextView? = null

    private var hunHeAdapter: BasketballHunHeAdapter? = null
    private var sfAdapter: BasketballSfAdapter? = null
    private var rfsfAdapter: BasketballRfsfAdapter? = null
    private var dxfAdapter: BasketballDxfAdapter? = null
    private var sfcAdapter: BasketballSfcAdapter? = null

    private var RESULTCODE = 1
    private var currentPosition: Int = 3     //当前的显示器位置指针
    private var adapterListBase: ArrayList<BaseBasketballAdapter> = ArrayList()
    private var oldMapData: LinkedHashMap<String, ArrayList<BasketballBean>> = LinkedHashMap()           //保存元数据

    var hashMap: LinkedHashMap<String, ArrayList<BasketballBean>> = LinkedHashMap()             //接口数据
    private var leagueChoseList: ArrayList<String> = ArrayList()                                //刷选页数据
    private var leagueChoseIndex: Int = 0                                                       // 筛选页停留页面

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerEventBus()
        setContentView(R.layout.activity_foot_ball)
        initActionBar()
        initEvent()

        initListener()

    }

    override fun initListener() {
        super.initListener()


        /**
         * 清除
         */
        foot_ball_delete.setOnClickListener { deleteAllChose() }


        /**
         * 下一步
         */
        foot_ball_step.setOnClickListener {
            val playType = when (currentPosition) {
                0 -> PlayIdEnum.sf
                1 -> PlayIdEnum.rfsf
                2 -> PlayIdEnum.dxf
                3 -> PlayIdEnum.hunhe
                else -> PlayIdEnum.sfc
            }
            StartActivityPresenter.startBetActivity(context = this, map = adapterListBase[currentPosition].choseMap, playType = playType, lotteryType = LotteryIdEnum.jclq)

        }



        /**
         * 无网络  再次请求
         */
        foot_ball_bg_img.setOnClickListener { requestData() }

    }


    override fun initEvent() {
        super.initEvent()


        hunHeAdapter = BasketballHunHeAdapter(this, hashMap)
        sfAdapter = BasketballSfAdapter(this, hashMap)
        rfsfAdapter = BasketballRfsfAdapter(this, hashMap)
        dxfAdapter = BasketballDxfAdapter(this, hashMap)
        sfcAdapter = BasketballSfcAdapter(this, hashMap)

        adapterListBase.add(sfAdapter!!)
        adapterListBase.add(rfsfAdapter!!)
        adapterListBase.add(dxfAdapter!!)
        adapterListBase.add(hunHeAdapter!!)
        adapterListBase.add(sfcAdapter!!)


        foot_ball_list.setAdapter(adapterListBase[currentPosition])

        adapterListBase.forEach { it.setCallBack(callBack = callAdapterBack) }

        foot_ball_list.setOnChildClickListener(null)
        foot_ball_list.setGroupIndicator(null)     //去掉默认箭头

        requestData()




    }


    private fun requestData() {
        foot_ball_relative.visibility = View.GONE
        foot_ball_progress_bar.visibility = View.VISIBLE
        foot_ball_bg_img.visibility = View.GONE
        BasketBallPresenter.requestBasketBall(context = this,
                onSuccess = {


                    doAsync { oldMapData = (BasketBallPresenter.copyHashMap(map = it)) }

                    hashMap.clear()
                    hashMap.putAll(it)

                    Handler().postDelayed(
                            {
                                foot_ball_relative.visibility = View.VISIBLE
                                foot_ball_progress_bar.visibility = View.GONE
                            }, 1000)


                    adapterListBase[currentPosition].notifyDataSetChanged()
                    if (hashMap.isNotEmpty()) foot_ball_list.expandGroup(0)

                },
                onFailure = {
                    showToast(it.message)
                    foot_ball_progress_bar.visibility = View.GONE
                    if (it.code== HttpUtil().requestFailureNoNetwork) foot_ball_bg_img.visibility = View.VISIBLE


                })
    }


    private fun initActionBar() {

        val view: View = LayoutInflater.from(baseContext).inflate(R.layout.bar_foot_ball_activity, null)
        val centerRelative: RelativeLayout = view.findViewById(R.id.bar_foot_center_relative)
        val downImg: ImageView = view.findViewById(R.id.bar_foot_img_down)
        val chooseImg: ImageView = view.findViewById(R.id.bar_foot_img_choose)
        val moreImg: ImageView = view.findViewById(R.id.bar_foot_img_more)
        val backImg: ImageView = view.findViewById(R.id.bar_back)
        centerTxtView = view.findViewById(R.id.bar_foot_center)

        downImg.setColorFilter(Color.WHITE)
        chooseImg.setColorFilter(Color.WHITE)
        moreImg.setColorFilter(Color.WHITE)
        backImg.setColorFilter(Color.WHITE)

        initActionBarView(view)

        playWindow = PlayTypeChoseWindow(this, downImg, 3, playTypeChoseWindowTitle)
        backImg.setOnClickListener(this)
        chooseImg.setOnClickListener(this)
        moreImg.setOnClickListener { popMore?.show(moreImg) }
        centerRelative.setOnClickListener { playWindow?.show(centerTxtView!!) }

        playWindow?.setCallPositionBack(callPopWindowBack)
        popMore = FootBallMoreWindow(this, LotteryIdEnum.jclq.id)


    }


    // 清空选择
    private fun deleteAllChose() {
        clearStatueHashMap()
        adapterListBase[currentPosition].choseMap.clear()
        FootBallPresenter.setChoseTextString(foot_ball_chose_count, 0)
        adapterListBase[currentPosition].notifyDataSetChanged()

    }

    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)

        //状态重置
        if (event.loginMessage == Constant.dltClear||event.loginMessage == "paySuccess") {

            resetActivity()
            return
        }


        //响应投注项显示页面的删除操作
        BasketBallPresenter.deleteChoseList(list = event.jczqDeleteList, choseMap = adapterListBase[currentPosition].choseMap, mapData = hashMap)
        FootBallPresenter.setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)
        adapterListBase[currentPosition].notifyDataSetChanged()

    }


    /**
     * 购买成功之后状态重置
     */

    private fun resetActivity() {
        adapterListBase.forEach { it.choseMap.clear() }
        centerTxtView?.text = playTypeChoseWindowTitle[currentPosition]

        leagueChose(leagueChoseList = leagueChoseList)

        foot_ball_list.setAdapter(adapterListBase[currentPosition])
        adapterListBase[currentPosition].notifyDataSetChanged()
        if (hashMap.size > 0) foot_ball_list.expandGroup(0)
    }


    override fun onClick(v: View?) {
        super.onClick(v)
        when (v?.id) {

            R.id.bar_back -> { finish() }

            R.id.bar_foot_img_more -> { }

            R.id.bar_foot_img_choose -> {
                val intent = Intent(this, BasketballChoseActivity::class.java)
                intent.putExtra("leagueList", getAllLeagueName())
                intent.putExtra("leagueChoseList", leagueChoseList)
                intent.putExtra("leagueChoseIndex", leagueChoseIndex)
                startActivityForResult(intent, RESULTCODE)
            }

        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (data == null) return
        if (requestCode == RESULTCODE && resultCode == Activity.RESULT_OK) {
            val list = data.getStringArrayListExtra("leagueChoseList")
            leagueChoseIndex = data.getIntExtra("leagueChoseIndex", 0)
            leagueChoseList.clear()
            leagueChoseList.addAll(list)
            leagueChose(leagueChoseList = leagueChoseList)

        }
    }


    /**
     * 筛选页面回调之后刷新
     * @param leagueChoseList 需要筛选的数据
     */

    private fun leagueChose(leagueChoseList: ArrayList<String>) {

        hashMap.clear()
        adapterListBase[currentPosition].choseMap.clear()

        if (leagueChoseList.isEmpty()) {

            if (leagueChoseIndex == 1) {
                for ((key, value) in oldMapData) {
                    val newList: ArrayList<BasketballBean> = ArrayList()
                    value.forEach {
                        if (it.leagueName == "NBA" || it.leagueName == "美职篮")
                            newList.add(BasketballHelp().copyBasketBallBean(it))  //是否包含该项
                    }
                    if (newList.size > 0) hashMap[key] = newList
                }
            } else {
                hashMap.putAll(BasketBallPresenter.copyHashMap(oldMapData))
            }

        }else{

            for ((key, value) in oldMapData) {
                val newList: ArrayList<BasketballBean> = ArrayList()
                value.forEach {
                    if (leagueChoseList.contains(it.leagueName))
                        newList.add(BasketballHelp().copyBasketBallBean(it))  //是否包含该项
                }
                if (newList.size > 0) hashMap[key]= newList
            }
        }


        adapterListBase[currentPosition].notifyDataSetChanged()
        if (hashMap.size > 0) foot_ball_list.expandGroup(0)
        FootBallPresenter.setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)


    }


    /**
     * 获取所有的联赛名集合
     */
    private fun getAllLeagueName(): ArrayList<String> {

        val pairList: ArrayList<String> = ArrayList()
        for ((_, value) in oldMapData) {
            value.forEach { if (!pairList.contains(it.leagueName)) pairList.add(it.leagueName) }
        }
        return pairList
    }

    /**
     * adapter点击项回调
     * 显示当前的已选择项
     */

    private var callAdapterBack: CallBack = CallBack {
        FootBallPresenter.setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)

    }


    // popupWindow的玩法
    private var callPopWindowBack: CallPositionBack = object : CallPositionBack {
        override fun callPositionBack(position: Int, describe: String) {
            clearStatueHashMap()
            centerTxtView?.text = describe
            currentPosition = position
            adapterListBase[currentPosition].choseMap.clear()
            foot_ball_list.setAdapter(adapterListBase[currentPosition])
            adapterListBase[currentPosition].notifyDataSetChanged()
            FootBallPresenter.setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)

            if (hashMap.size != 0) foot_ball_list.expandGroup(0)
            if (hashMap.isEmpty()) requestData()

        }
    }

    /**
     * 切换玩法事  左右的状态置换为初始状态
     * 此处只能置换 不能修改hashMap的地址值
     */
    fun clearStatueHashMap() {
        for ((_, value) in hashMap) {
            value.forEach { BasketballHelp().resetBetBean(it) }
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        leagueChoseList.clear()
    }


}