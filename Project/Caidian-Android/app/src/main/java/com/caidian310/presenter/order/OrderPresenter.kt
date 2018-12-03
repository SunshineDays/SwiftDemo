package com.caidian310.presenter.order

import android.content.Context
import com.caidian310.bean.PageInfo
import com.caidian310.bean.buy.PaySuccessDetailBean
import com.caidian310.bean.sport.order.CopyOrderBean
import com.caidian310.bean.user.CopyOrderDetailBean
import com.caidian310.bean.user.CopyOrderPersonBean
import com.caidian310.http.HttpUtil
import com.caidian310.http.Router
import com.caidian310.utils.HttpError
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import org.json.JSONObject


/**
 * 订单 复制
 */
object OrderPresenter {

    /**
     * 复制跟单列表
     * @return
     */
    fun requestCopyOrderLists(
            context: Context,
            page: Int = 1,
            pageSize: Int = 20,
            onSuccess: (copyOrderBeanList: ArrayList<CopyOrderBean>, pageInfo: PageInfo) -> Unit,
            onFailure: (HttpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getCopyOrderListParameter(page = page, pageSize = pageSize),
                onSuccess = {

                    val listString = JSONObject(it).getString("list")
                    val pageString = JSONObject(it).getString("page_info")
                    val pageInfo = Gson().fromJson(pageString, PageInfo::class.java)
                    val list: java.util.ArrayList<CopyOrderBean> = Gson().fromJson(listString, object : TypeToken<ArrayList<CopyOrderBean>>() {}.type)
                    onSuccess(list, pageInfo)

                },
                onFailure = {
                    onFailure(it)
                    false
                }

        )

    }

    /**
     * 复制跟单详情
     * @param id 订单id
     *
     */
    fun requestCopyOrderDetail(
            context: Context,
            id: Int,
            onSuccess: (copyOrderDetailBean: CopyOrderDetailBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getCopyOrderDetailParameter(id = id),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, CopyOrderDetailBean::class.java))
                },
                onFailure = {
                    onFailure(it)
                    true
                }
        )
    }

    /**
     * 复制跟单购买
     * @param id 订单id
     * onSuccess: (copyOrderDetailBean:CopyOrderDetailBean) -> Unit,
    onFailure: (httpError :HttpError) -> Unit
     */
    fun requestCopyOrderBuy(
            context: Context,
            orderId: Int,
            totalMoney: Double,
            multiple: Int,
            onSuccess: (paySuccessDetailBean: PaySuccessDetailBean) -> Unit,
            onFailure: (httpError :HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getCopyOrderBuyParameter(orderId = orderId, multiple = multiple, totalMoney = totalMoney),
                onSuccess = {
                  onSuccess(Gson().fromJson(it, PaySuccessDetailBean::class.java))
                },
                onFailure = {
                    onFailure(it)
                    true
                }
        )
    }

    /**
     * 复制跟单人员
     * @param id 订单id
     */
    fun requestCopyOrderPerson(
            context: Context,
            orderId: Int,
            page: Int,
            pageSize: Int = 20,
            onSuccess: (copyOrderPersonBean:CopyOrderPersonBean) -> Unit,
            onFailure: (HttpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getCopyOrderPersonParameter(orderId = orderId,page = page ,pageSize = pageSize),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, CopyOrderPersonBean::class.java))
                },
                onFailure = {
                    onFailure(it)
                    true
                }
        )
    }

    /**
     * 今日热单 列表
     * @return
     */

    fun requestHotOrderList(
        context: Context,
        page: Int = 1,
        pageSize: Int = 20,
        onSuccess: (copyOrderBeanList: ArrayList<CopyOrderBean>, pageInfo: PageInfo) -> Unit,
        onFailure: (HttpError: HttpError) -> Unit
    ) {
            HttpUtil().requestWithRouter(
                    context = context,
                    httpParameter = Router.getHotOrderListParameter(page = page, pageSize = pageSize),
                    onSuccess = {

                        val listString = JSONObject(it).getString("list")
                        val pageString = JSONObject(it).getString("page_info")
                        val pageInfo = Gson().fromJson(pageString, PageInfo::class.java)
                        val list: java.util.ArrayList<CopyOrderBean> = Gson().fromJson(listString, object : TypeToken<ArrayList<CopyOrderBean>>() {}.type)
                        onSuccess(list, pageInfo)

                    },
                    onFailure = {
                        onFailure(it)
                        false
                    }

            )
    }

}