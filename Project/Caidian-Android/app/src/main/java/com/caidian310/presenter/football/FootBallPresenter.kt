package com.caidian310.presenter.football

import android.content.Context
import android.text.Html
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.buy.PaySuccessDetailBean
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.sport.football.*
import com.caidian310.http.HttpUtil
import com.caidian310.http.Router
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.CopyUtil
import com.caidian310.utils.CopyUtil.CopyClass
import com.caidian310.utils.HttpError
import com.caidian310.utils.ToastUtil.showToast
import com.caidian310.view.callBack.CallFootballBeanBack
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

import org.json.JSONObject
import java.util.ArrayList
import kotlin.collections.LinkedHashMap
import kotlin.collections.component1
import kotlin.collections.component2

/**
 * 竞彩足球帮助类
 * Created by mac on 2017/12/4.
 */
object FootBallPresenter {

     var toastString = "请至少选择一场单关或任意两场比赛"

    /**
     * 数据个数转化
     *    var mapData: HashMap<String, ArrayList<FootballBean>> = HashMap()
     */
    fun getJczqBean(context: Context,
                    onSuccess: (hashMap: LinkedHashMap<String, ArrayList<FootballBean>>) -> Unit,
                    onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(

                context = context,
                httpParameter = Router.getJingCaiMatchListParameter(),
                onSuccess = { json ->
                    val listString = JSONObject(json).getString("list")
                    val list: ArrayList<RequestFootballBean> = Gson().fromJson(listString, object : TypeToken<ArrayList<RequestFootballBean>>() {}.type)
                    onSuccess(getIssueList(list = list))

                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }


    /**
     * 购买支付网络请求
     * @return
     */
    fun requestFootBallBuyBean(
            context: Context,
            buyBean: BuyBean,
            onSuccess: (paySuccessDetailBean: PaySuccessDetailBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context = context,
                httpParameter = Router.getJingCaiBuyParameter(json = Gson().toJson(buyBean)),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, PaySuccessDetailBean::class.java))
                },
                onFailure = {
                    showToast(it.toString())
                    onFailure(it)
                    true

                })
    }


    /**
     * 数据根据旗号分期
     * @param list 对阵数据
     * @return
     */

    private fun getIssueList(list: ArrayList<RequestFootballBean>): LinkedHashMap<String, ArrayList<FootballBean>> {

        val footballList: ArrayList<FootballBean> = ArrayList()
        val issueList: ArrayList<String> = ArrayList()
        list.forEach {
            footballList.add(FootballHelp().getFootballBean(bean = it))
            if (!issueList.contains(it.issue)) issueList.add(it.issue)
        }
        val hashMap: LinkedHashMap<String, ArrayList<FootballBean>> = LinkedHashMap()


        issueList.forEach {
            val issueItem = it
            hashMap.put(issueItem, footballList.filter { issueItem == it.issue } as ArrayList<FootballBean>)
        }

        return hashMap
    }


    /**
     * map深复制
     */
    fun copyHashMap(map: HashMap<String, ArrayList<FootballBean>>): LinkedHashMap<String, ArrayList<FootballBean>> {

        val newMap: LinkedHashMap<String, ArrayList<FootballBean>> = LinkedHashMap()
        for ((key, value) in map) {
            val newList: ArrayList<FootballBean> = ArrayList()
            value.forEach {
                val newFootballBean = CopyUtil.copyMatchBean(it)
                newList.add(newFootballBean)
            }
            newMap[key] = newList
        }

        return newMap

    }


    /**
     * 设置控件一打开就下是的边框样式
     * @param textView 控件
     * @param jczq 样式选择条件
     * @param edgeBoolean 边框样式
     */
    private fun setOpenTextViewBg(textView: TextView, jczq: BetBean, edgeBoolean: Boolean = false) {

        //选中
        if (jczq.status) {
            textView.setBackgroundResource(R.drawable.select_item)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            return
        }
        textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
        textView.setTextColor(ColorUtil.getColor(R.color.grayThree))
        jczq.status = false


    }


    /**
     * 设置文字两行显示
     * @param view  控件
     * @param jczq 选择项数据
     */

    fun setTwoLineTextString(view: TextView, jczq: BetBean) {
        val colorString = if (jczq.status) "#ffffff" else "#333333"
        val testColorString = if (jczq.status) "#ffffff" else "#666666"

        view.text = Html.fromHtml("<font color='$colorString'>${jczq.jianChen}</font><br /><font color='$testColorString'>${jczq.sp}</font>")
    }

    /**
     * 两行文字显示时的颜色和控件背景色
     */

    fun setTwoLineTextViewStyle(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {
        setOpenTextViewBg(textView = textView, jczq = betBean, edgeBoolean = edgeBoolean)
        setTwoLineTextString(view = textView, jczq = betBean)
    }

    /**
     * 设置控件选择边框
     * @param textView 控件
     * @param jczq 样式选择条件
     * @param edgeBoolean 边框样式
     */
    fun setClickTextViewBackGround(textView: TextView, jczq: BetBean, edgeBoolean: Boolean = false) {

        //选中
        if (!jczq.status) {
            textView.setBackgroundResource(R.drawable.select_item)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            jczq.status = true
            return
        }
        textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
        textView.setTextColor(ColorUtil.getColor(R.color.grayThree))
        jczq.status = false

    }


    /**
     * 点击事件处理 (胜平负,半全场)
     * @param textView 点击的选项
     * @param betBean 场次里面的某项
     * @param footballBean 本场次标记
     * @param edgeBoolean 边框样式
     * @param callFootballBeanBack 回调函数
     * @param choseMap 选择的集合
     */

    fun setOnItemClick(textView: TextView,
                       betBean: BetBean,
                       footballBean: FootballBean,
                       edgeBoolean: Boolean = false,
                       callFootballBeanBack: CallFootballBeanBack,
                       choseMap: LinkedHashMap<Match, ArrayList<BetBean>>,
                       betType: String = BetTypeEnum.hunhe.key
    ) {
        setClickTextViewBackGround(textView = textView, jczq = betBean, edgeBoolean = edgeBoolean)
        addJczq(match = footballBean.getMatchBean(), jczq = betBean, choseMap = choseMap)
        callFootballBeanBack.callObjectBack(type = betType, footballBean = footballBean, map = choseMap)

    }





    /**
     * 删除已选的数据
     * @param list  要删除的数据集合
     * @param choseMap 已经选择的数据
     * @param mapData  源数据
     *
     */
    fun deleteChoseList(list: ArrayList<Int>,
                        choseMap: LinkedHashMap<Match, ArrayList<BetBean>>,
                        mapData: HashMap<String, ArrayList<FootballBean>>) {
        val keyList = ArrayList(choseMap.keys)
        list.forEach {
            val item = it
            keyList.forEach { if (it.id == item) choseMap.remove(it) }  //从已选择数据中去除

            //置换源数据的状态
            for ((_, value) in mapData) {
                value.forEach {
                    if (it.id == item) {
                        it.jczqBeanList.forEach { it.status = false }
                    }
                }
            }
        }


    }


    /**
     * 设置显示选择项的文字
     * @param textView 显示控件
     * @param choseCount 场次个数
     */
    fun setChoseTextString(textView: TextView, choseCount: Int) {
        textView.text = Html.fromHtml("已选择<font color='${if (choseCount > 0) "#FF4081" else "#666666"}'>$choseCount</font>场")

    }


    /**
     * 添加选中项
     * @param bean 本场次标记
     * @param jczq 本场次的某项玩法选择
     * @param choseMap 已选择场次的集合
     *
     */
    fun addJczq(match: Match, jczq: BetBean, choseMap: LinkedHashMap<Match, ArrayList<BetBean>>) {

        // 本场比赛已经添加过
        for ((key, value) in choseMap) {

            if (key.id == match.id) {

                // 查找该选项是否已经存在
                var position = -1
                value.forEachIndexed { index, jczqBean -> if (jczqBean.key == jczq.key) position = index }

                // 该选项已经存在  移除
                if (position != -1) {
                    value.removeAt(position)
                    if (value.size == 0) choseMap.remove(key)  //最后一场比赛
                    return
                }

                value.add(jczq)   // 该选项不存在  添加
                return

            }

        }

        //本场比赛从未添加过
        var inList: ArrayList<BetBean> = ArrayList()
        inList.add(jczq)
        choseMap.put(match, inList)

    }


}