package com.caidian310.activity.sport.football

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
import com.caidian310.adapter.base.BaseFootballAdapter
import com.caidian310.adapter.football.*
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.http.HttpUtil
import com.caidian310.presenter.StartActivityPresenter
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.Constant
import com.caidian310.utils.CopyUtil
import com.caidian310.view.callBack.CallFootballBeanBack
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.popupWindow.FootBallMoreWindow
import com.caidian310.view.popupWindow.PlayTypeChoseWindow
import kotlinx.android.synthetic.main.activity_foot_ball.*
import org.jetbrains.anko.doAsync


class FootBallActivity : BaseActivity() {

    private var pop: PlayTypeChoseWindow? = null
    private var popMore: FootBallMoreWindow? = null
    private var centerTxtView: TextView? = null

    private var spfAdapter: FootballSpfAdapter? = null
    private var bfAdapter: FootballBfAdapter? = null
    private var jqsAdapter: FootballJqsAdapter? = null
    private var bqcAdapter: FootballBqcAdapter? = null
    private var hunHeAdapter: FootballHunHeAdapter? = null
    private var currentPosition: Int = 1

    private var RESULTCODE = 1

    private var adapterListBase: ArrayList<BaseFootballAdapter> = ArrayList()


    private val fiveLeagueList = arrayListOf("意甲", "英超", "西甲", "德甲", "法甲")
    private var playTypeChoseWindowTitle = arrayListOf("胜平负(让)", "混合投注", "半全场", "比分", "总进球")


    private var oldMapData: LinkedHashMap<String, ArrayList<FootballBean>> = LinkedHashMap()           //保存元数据

    var hashMap: LinkedHashMap<String, ArrayList<FootballBean>> = LinkedHashMap()             //接口数据

    private var leagueChoseList: ArrayList<String> = ArrayList()    //刷选页数据
    private var leagueChoseIndex: Int = 0                           // 筛选页停留页面

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
        foot_ball_delete.setOnClickListener { deleteChose() }

        /**
         * 下一步
         */
        foot_ball_step.setOnClickListener {
            StartActivityPresenter.startBetActivity(
                    context = this,
                    map = adapterListBase[currentPosition].choseMap,
                    playType = adapterListBase[currentPosition].playEnum,
                    lotteryType = LotteryIdEnum.jczq)
        }

        /**
         * 无网络  再次请求
         */
        foot_ball_bg_img.setOnClickListener { requestData() }


    }


    override fun initEvent() {
        super.initEvent()


        spfAdapter = FootballSpfAdapter(this, hashMap)
        hunHeAdapter = FootballHunHeAdapter(this, hashMap)
        bqcAdapter = FootballBqcAdapter(this, hashMap)
        bfAdapter = FootballBfAdapter(this, hashMap)
        jqsAdapter = FootballJqsAdapter(this, hashMap)


        adapterListBase.add(spfAdapter!!)
        adapterListBase.add(hunHeAdapter!!)
        adapterListBase.add(bqcAdapter!!)
        adapterListBase.add(bfAdapter!!)
        adapterListBase.add(jqsAdapter!!)

        adapterListBase.forEach { it.setCallBack(callFootballAdapterBack) }

        foot_ball_list.setAdapter(adapterListBase[currentPosition])

        foot_ball_list.setOnChildClickListener(null)
        foot_ball_list.setGroupIndicator(null)     //去掉默认箭头

        requestData()


    }


    private fun requestData() {



        foot_ball_relative.visibility = View.GONE
        foot_ball_progress_bar.visibility = View.VISIBLE
        foot_ball_bg_img.visibility = View.GONE

        FootBallPresenter.getJczqBean(context = this,
                onSuccess = {

                    doAsync { oldMapData = (FootBallPresenter.copyHashMap(map = it)) }

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
                    if (it.code == HttpUtil().requestFailureNoNetwork) foot_ball_bg_img.visibility = View.VISIBLE
                })
    }


    private fun initActionBar() {

        currentPosition = intent.getIntExtra("currentPosition",1)
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

        centerTxtView?.text = playTypeChoseWindowTitle[currentPosition]

        pop = PlayTypeChoseWindow(this, downImg, currentPosition, playTypeChoseWindowTitle)
        backImg.setOnClickListener(this)
        chooseImg.setOnClickListener(this)
        moreImg.setOnClickListener { popMore?.show(moreImg) }
        centerRelative.setOnClickListener { pop?.show(view) }

        pop?.setCallPositionBack(callBack)
        popMore = FootBallMoreWindow(this, lotteryId = LotteryIdEnum.jczq.id)

        initActionBarView(view)
    }


    // 清除选择
    private fun deleteChose() {
        clearStatueHashMap()
        adapterListBase[currentPosition].choseMap.clear()
        adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, 0)
        adapterListBase[currentPosition].notifyDataSetChanged()

    }

    override fun onDataSynEvent(event: EventBusBean) {
        super.onDataSynEvent(event)
        if (event.loginMessage == Constant.dltClear || event.loginMessage == "paySuccess") {
            //状态重置
            resetActivity()
            return

        }
        //响应投注项显示页面的删除操作
        if (event.jczqTypeString == adapterListBase[currentPosition].playEnum.type) {
            FootBallPresenter.deleteChoseList(list = event.jczqDeleteList, choseMap = adapterListBase[currentPosition].choseMap, mapData = hashMap)
            adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)
            adapterListBase[currentPosition].notifyDataSetChanged()
            if (adapterListBase[currentPosition].choseMap.isEmpty()) resetActivity()
        }


    }


    /**
     * 购买成功之后状态重置
     */

    private fun resetActivity() {


        adapterListBase.forEach { it.choseMap.clear() }

        leagueChose(leagueChoseList = leagueChoseList)

        foot_ball_list.setAdapter(adapterListBase[currentPosition])
        adapterListBase[currentPosition].notifyDataSetChanged()
        if (hashMap.size > 0) foot_ball_list.expandGroup(0)

        adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)
    }


    override fun onClick(v: View?) {
        super.onClick(v)
        when (v?.id) {
            R.id.bar_back -> {

                finish()
            }
            R.id.bar_foot_img_more -> {

            }

            R.id.bar_foot_img_choose -> {
                val intent = Intent(this, LeagueChoseActivity::class.java)
                intent.putExtra("leagueList", getAllLeagueName())
                intent.putExtra("leagueChoseList", leagueChoseList)
                intent.putExtra("leagueChoseIndex", leagueChoseIndex)
                startActivityForResult(intent, RESULTCODE)
            }

        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (data == null || requestCode != RESULTCODE) return
        if (resultCode == Activity.RESULT_OK) {
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

            //五大联赛
            if (leagueChoseIndex == 1) {
                for ((key, value) in oldMapData) {
                    val newList: ArrayList<FootballBean> = ArrayList()
                    value.forEach {
                        if (fiveLeagueList.contains(it.leagueName))
                            newList.add(CopyUtil.copyMatchBean(it))  //是否包含该项
                    }
                    if (newList.size > 0) hashMap[key] = newList
                }
            }else{
                hashMap.putAll(FootBallPresenter.copyHashMap(oldMapData))
            }
        } else {

            for ((key, value) in oldMapData) {
                val newList: ArrayList<FootballBean> = ArrayList()
                value.forEach {
                    if (leagueChoseList.contains(it.leagueName))
                        newList.add(CopyUtil.copyMatchBean(it))  //是否包含该项
                }
                if (newList.size > 0) hashMap[key] = newList
            }
        }

        adapterListBase[currentPosition].notifyDataSetChanged()
        if (hashMap.size > 0) foot_ball_list.expandGroup(0)
        adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)

    }


    /**
     * 获取所有的联赛名集合
     */
    private fun getAllLeagueName(): ArrayList<String> {

        val pairList: ArrayList<String> = ArrayList()
        for ((_, value) in oldMapData) {
            value.forEach {
                if (!pairList.contains(it.leagueName)) pairList.add(it.leagueName)
            }

        }
        return pairList
    }

    /**
     * adapter点击项回调
     */

    private var callFootballAdapterBack: CallFootballBeanBack = object : CallFootballBeanBack {
        override fun callObjectBack(type: String, footballBean: FootballBean, map: LinkedHashMap<Match, ArrayList<BetBean>>) {
            adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)
        }

    }


    // 选中的玩法
    var callBack: CallPositionBack = object : CallPositionBack {
        override fun callPositionBack(position: Int, describe: String) {

            clearStatueHashMap()
            centerTxtView?.text = describe
            currentPosition = position
            adapterListBase[currentPosition].choseMap.clear()
            foot_ball_list.setAdapter(adapterListBase[currentPosition])
            adapterListBase[currentPosition].notifyDataSetChanged()
            adapterListBase[currentPosition].setChoseTextString(foot_ball_chose_count, adapterListBase[currentPosition].choseMap.size)
            if (hashMap.isNotEmpty()) foot_ball_list.expandGroup(0)
            if (hashMap.isEmpty()) requestData()

        }
    }

    /**
     * 切换玩法事  左右的状态置换为初始状态
     * 此处只能置换 不能修改hashMap的地址值
     */
    fun clearStatueHashMap() {
        for ((_, value) in hashMap) {
            value.forEach { it.jczqBeanList.forEach { it.status = false } }
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        leagueChoseList.clear()
    }


}
