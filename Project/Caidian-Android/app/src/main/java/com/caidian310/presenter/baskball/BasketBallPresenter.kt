package com.caidian310.presenter.baskball

import android.content.Context
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.baskball.BasketballHelp
import com.caidian310.bean.sport.baskball.RequestBasketballBean
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.http.HttpUtil
import com.caidian310.http.Router
import com.caidian310.utils.CopyUtil
import com.caidian310.utils.HttpError
import com.caidian310.utils.ToastUtil.showToast
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

import org.json.JSONObject

/**
 * icon_types_jclq
 * Created by mac on 2018/1/10.
 */
object BasketBallPresenter {


    val gson: Gson = Gson()

    /**
     * 竞彩篮球对症请求
     */
    fun requestBasketBall(context: Context,
                          onSuccess: (hashMap: LinkedHashMap<String, ArrayList<BasketballBean>>) -> Unit,
                          onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context = context,
                httpParameter = Router.getBaskballMatchListParameter(),
                onSuccess = {
                    val listString = JSONObject(it).getString("list")
                    val list: ArrayList<RequestBasketballBean> = Gson().fromJson(listString, object : TypeToken<ArrayList<RequestBasketballBean>>() {}.type)
                    onSuccess(getIssueList(list = list))

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    false
                })

    }


    /**
     * 数据根据旗号分期
     * @param list 对阵数据
     * @return
     */

    private fun getIssueList(list: ArrayList<RequestBasketballBean>): LinkedHashMap<String, ArrayList<BasketballBean>> {

        val basketBallList: java.util.ArrayList<BasketballBean> = java.util.ArrayList()

        val issueList: ArrayList<String> = ArrayList()
        list.forEach {
            basketBallList.add(BasketballHelp().getBasketBallBean(it))
            if (!issueList.contains(it.issue)) issueList.add(it.issue)
        }

        val hashMap: LinkedHashMap<String, ArrayList<BasketballBean>> = LinkedHashMap()
        issueList.forEach {
            val issueItem = it
            val newsList = basketBallList.filter { issueItem == it.issue } as ArrayList<BasketballBean>
            if (!newsList.isEmpty())
                hashMap.put(issueItem, newsList)
        }

        return hashMap
    }


    /**
     * 删除已选的数据
     * @param list  要删除的数据集合matchId
     * @param choseMap 已经选择的数据
     * @param mapData  源数据
     *
     */
    fun deleteChoseList(list: ArrayList<Int>,
                        choseMap: LinkedHashMap<Match, ArrayList<BetBean>>,
                        mapData: HashMap<String, ArrayList<BasketballBean>>) {
        val keyList = java.util.ArrayList(choseMap.keys)
        list.forEach {
            val item = it
            keyList.forEach { if (it.id == item) choseMap.remove(it) }  //从已选择数据中去除

            //置换源数据的状态
            for ((_, value) in mapData) {
                value.filter { it.id == item }.forEach {
                    BasketballHelp().resetBetBean(it)
                }
            }


        }
    }



    /**
     * map深复制
     */
    fun copyHashMap(map: HashMap<String, java.util.ArrayList<BasketballBean>>): LinkedHashMap<String, java.util.ArrayList<BasketballBean>> {

        val newMap: LinkedHashMap<String, java.util.ArrayList<BasketballBean>> = LinkedHashMap()
        for ((key, value) in map) {
            val newList: java.util.ArrayList<BasketballBean> = java.util.ArrayList()
            value.forEach {
                newList.add(BasketballHelp().copyBasketBallBean(it))
            }
            newMap.put(key = key, value = newList)
        }

        return newMap

    }


}
