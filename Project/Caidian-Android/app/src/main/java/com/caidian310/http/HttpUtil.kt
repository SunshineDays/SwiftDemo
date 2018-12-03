package com.caidian310.http

import android.content.Context
import android.text.TextUtils
import com.caidian310.application.MyApplication
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.utils.FileUtil
import com.caidian310.utils.HttpError
import com.caidian310.utils.NetUtil
import com.loopj.android.http.AsyncHttpClient
import com.loopj.android.http.BaseJsonHttpResponseHandler
import com.loopj.android.http.BinaryHttpResponseHandler
import com.loopj.android.http.RequestParams
import cz.msebera.android.httpclient.Header
import org.greenrobot.eventbus.EventBus
import org.json.JSONException
import org.json.JSONObject
import java.io.File
import java.io.FileOutputStream
import java.net.URL


/**
 * 网络请求入口
 * Created by mac on 2017/11/10.
 */
class HttpUtil {


    val requestSuccessCode = 200                // 请求成功
    val requestSuccessNeedLogin = 1001          // 需要登录
    val requestFailureNoNetwork = 20000         // 断网
    val cancleTime = 10000                      //网络超时时间





    companion object {
        var  client = AsyncHttpClient()
        var  networkTime  = 10000

//        var toastLoading: Toast?= null

        /**
         * 取消本次的网络请求
         *
         * @param context 当前网络请求的事例
         */
        fun cancelRequests(context: Context) {
//            toastLoading?.cancel()
            client.cancelRequests(context, true)
        }


    }


    /**
     * 选择网络请求方式 参数签名
     * @param httpParameter  请求参数
     * @param onSuccess 请求成功回调
     * @param onFailure 请求失败回调
     * @param context   上下文
     */

    fun requestWithRouter(context: Context = MyApplication.instance,
                          httpParameter: HttpParameter,
                          onSuccess: (json: String) -> Unit,
                          onFailure: (httpError: HttpError) -> Boolean) {


        val cacheTime = httpParameter.cacheTime                         //缓存时间 0: 不缓存
        val params = SignParams().createSign(httpParameter.hashMap)     // 签名
        val url = Router.baseUrl + httpParameter.path                   //url
        val timeOut = httpParameter.cacheTime

//        toastLoading =   ToastUtil.toastLoading(context = context,duration = 10000 )


        /**
         * 缓存处理  此处的缓存机制是自己写的
         */

        if (cacheTime != 0) {
            val cacheBean = FileUtil.readHttpLocal(url)                 // 缓存文件信息

            // 如果缓存超时 重新请求更新缓存数据
            if (cacheBean.file != null && System.currentTimeMillis() - cacheBean.file!!.lastModified() > cacheTime)
                cacheBean.cacheString = null


            if (!TextUtils.isEmpty(cacheBean.cacheString)) {              // 如果缓存不为空 从本地获取
                onSuccess(cacheBean.cacheString!!)
                return
            }

        }

        /**
         *  检查网络
         */
        if (!NetUtil.isNetworkAvailable(context)) {
            onFailure(HttpError(requestFailureNoNetwork, "网络不可用"))
            return
        }


        if (httpParameter.method == HttpMethod.GET) {

        } else {
            post(context = context, url = url, params = params,timeOut =timeOut,  cacheTime = cacheTime, onSuccess = onSuccess, onFailure = onFailure)
        }


    }


    /**
     * 上传图片
     */

    fun requestFileWithRouter(context: Context = MyApplication.instance,
                              httpParameter: HttpParameter,
                              onSuccess: (json: String) -> Unit,
                              onFailure: (httpError: HttpError) -> Boolean) {
        /**
         *  检查网络
         */
        if (!NetUtil.isNetworkAvailable(context)) {
            onFailure(HttpError(requestFailureNoNetwork, "网络不可用"))
            return
        }

        val params = SignParams().createSign(httpParameter.hashMap)     // 签名
        val url = Router.baseUrl + httpParameter.path                   //url
        params.put("image", httpParameter.file)

        post(context = context, url = url, cacheTime = 0,  params = params, onFailure = onFailure, onSuccess = onSuccess)


    }



    /**
     * post网络请求
     * @param context   此次网络请求的标志
     * @param url       网络请求拼接路径
     * @param params    请求参数
     * @param cacheTime 缓存时间  0: 不缓存
     * @param onSuccess 请求成功回调
     * @param onFailure 请求失败回调
     * @return object
     */

    private fun post(context: Context,
                     url: String,
                     params: RequestParams? = null,
                     cacheTime: Int = 0,
                     timeOut :Int = cancleTime,
                     onSuccess: (json: String) -> Unit,
                     onFailure: (httpError: HttpError) -> Boolean) {


//        toastLoading?.show()
        client.setTimeout(timeOut)
        client.post(context, url, params, object : BaseJsonHttpResponseHandler<String>() {

            override fun onSuccess(p0: Int, p1: Array<out Header>?, p2: String?, p3: String?) {

//                toastLoading?.cancel()
                //解析请求结构
                var jsonObject: JSONObject? = null
                try {
                    jsonObject = JSONObject(p2)
                    val code = jsonObject.getInt("code")
                    val msg = jsonObject.getString("msg")
                    val data = jsonObject.getString("data")

                    //封装请求状态
                    val httpError = HttpError(code, msg)
                    if (code == requestSuccessCode) {
                        if (cacheTime != 0) FileUtil.writeHttpLocal(json = data, path = url)
                        onSuccess(data)
                        return
                    }

                    //用户未登录操作并且需要登录
                    if (code == requestSuccessNeedLogin && onFailure(httpError)) {
                        EventBus.getDefault().post(EventBusBean("needLogin"))
                        return
                    }

                    onFailure(httpError)
                } catch (e: JSONException) {
                    e.printStackTrace()

                }

            }

            override fun onFailure(p0: Int, p1: Array<out Header>?, p2: Throwable?, p3: String?, p4: String?) {
                onFailure(HttpError(p0, p2?.message.toString() ?: "网络链接失败"))
//                toastLoading?.cancel()
            }


            override fun parseResponse(p0: String?, p1: Boolean): String? = null

        })


    }


    /**
     * 文件下载
     * @param   url  URl
     * @param   onSuccess  下载的路径
     * @param   onFailure  下载失败的code
     */
    fun requestDownloadFile(
            url: String,
            file: File,
            onSuccess: (file: File) -> Unit,
            onProgress: (count: Int) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {
        client.get(url, object : BinaryHttpResponseHandler() {
            override fun onSuccess(p0: Int, p1: Array<out Header>?, p2: ByteArray?) {

                val fileName = File(URL(url).file).name
                val newFile = File(file.path + "/" + fileName)
                val stream = FileOutputStream(newFile)
                stream.write(p2)
                stream.flush()
                stream.close()
                onSuccess(newFile)
            }

            override fun onFailure(p0: Int, p1: Array<out Header>?, p2: ByteArray?, p3: Throwable?) {
                onFailure(HttpError(code = p0, message = p3?.message ?: "请检查网络连接"))
            }

            override fun onProgress(bytesWritten: Long, totalSize: Long) {

                val count = if(totalSize==0L) 0 else (bytesWritten * 1.0 / totalSize * 100).toInt()
                onProgress(count)
                super.onProgress(bytesWritten, totalSize)
            }
        })
    }


}

