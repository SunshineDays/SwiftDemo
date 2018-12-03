package com.caidian310.presenter.user

import android.app.Activity
import android.content.Context
import android.text.TextUtils
import com.caidian310.application.MyApplication
import com.caidian310.bean.AppUpdateBean
import com.caidian310.bean.PageInfo
import com.caidian310.bean.UserBean
import com.caidian310.bean.buy.ChaseBean
import com.caidian310.bean.buy.PayDetailBean
import com.caidian310.bean.buy.PayLogBean
import com.caidian310.bean.eventBean.EventBusBean
import com.caidian310.bean.new.NewsDetailBean
import com.caidian310.bean.new.NewsItem
import com.caidian310.bean.sport.football.RequestFootballBean
import com.caidian310.bean.user.*
import com.caidian310.http.HttpUtil
import com.caidian310.http.Router
import com.caidian310.utils.DbUtil
import com.caidian310.utils.HttpError
import com.caidian310.utils.TimeUtil
import com.caidian310.utils.ToastUtil.showToast
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import org.greenrobot.eventbus.EventBus
import org.json.JSONObject
import java.io.File


/**
 *
 * 用户中心帮助类
 * Created by mac on 2017/12/23.
 */

object UserPresenter {


    /**
     * 检查服务器时间和本地时间的差值
     * @return
     */
    fun requestServerTime(context: Context) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getServerTimeParameter(),
                onSuccess = {
                    val serverTime = JSONObject(it).getLong("server_time")
                    MyApplication.getInstance().differenceTime = System.currentTimeMillis() - serverTime
                },
                onFailure = {
                    false
                }

        )

    }




    /**
     * 短信验证码
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun requestGetCode(
            context: Context,
            phone: String,
            type: Int,
            onSuccess: (codeBean: CodeBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        if (phone.isEmpty() || phone.length > 11) {
            showToast("手机号码格式不正确")
            return
        }

        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getCodeParameter(phone, type),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, CodeBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }

    /**
     * 短信验证码校验
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun requestCheckCode(
            context: Context,
            code: String,
            phone: String,
            type: Int,
            onSuccess: (codeBean: CodeBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getCheckCodeParameter(code, phone, type),
                onSuccess = { json ->
                    onSuccess(Gson().fromJson(json, CodeBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }


    /**
     * 修改手机
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun requestChangePhone(
            context: Context,
            code: String,
            phone: String,
            onSuccess: (userBean: UserBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getChangePhoneParameter(code, phone),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }

    /**
     * 手机 修改密码
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun requestUpdatePassword(
            context: Context,
            code: String,
            password: String,
            phone: String,
            onSuccess: (userBean: UserBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getUpdatePassword(code, password, phone),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }

    /**
     * 手机 找回密码
     * @param code           验证码
     * @param password       新密码
     * @param phone          手机号码
     */
    fun requestSeekPassword(
            context: Context,
            code: String,
            password: String,
            phone: String,
            onSuccess: (userBean: UserBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getSeekPassword(code, password, phone),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    onFailure(httpError)
                    true
                }
        )
    }

    /**
     * 普通注册
     *
     * @param code           短信验证码
     * @param nickname       昵称为4至16个字符，支持字母、汉字、数字；一个汉字算2个字符
     * @param password       密码长度必须大于6位且小于16位
     * @param phone          手机号
     */
    fun requestNormalRegister(
            context: Context,
            code: String,
            nickname: String,
            password: String,
            phone: String,
            onSuccess: (userBean: UserBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {


        if (phone.isEmpty()) {
            showToast("手机号码不能为空")
            return
        }
        if (phone.isEmpty() || phone.length > 11) {
            showToast("手机号码格式错误")
            return
        }
        if (code.isEmpty()) {
            showToast("验证码不能为空")
            return
        }
        if (nickname.isEmpty()) {
            showToast("用户名不能为空")
            return
        }
        if (nickname.length > 10) {
            showToast("用户名格式错误,请重新输入")
            return
        }
        if (password.isEmpty()) {
            showToast("登录密码")
            return
        }
        if (password.length < 6 || password.length > 16) {
            showToast("密码格式错误,请重新输入")
            return
        }


        HttpUtil().requestWithRouter(context = context,
                httpParameter = Router.getNormalRegisterParameter(code, nickname, password, phone),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = {
                    onFailure(it)
                    true
                }
        )
    }


    /**
     * 文件上传
     * @param file 文件路径
     * @return
     */
    fun requestUpdateFile(
            context: Context,
            file: File,
            onSuccess: (userBean: UserBean) -> Unit
    ) {


        HttpUtil().requestFileWithRouter(context,
                httpParameter = Router.getUpdateFileParameter(file),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = { httpError ->
                    showToast(httpError.message)
                    true
                }
        )
    }


    /**
     * 登录 手机号+[密码|验证码]
     *
     * @param code     验证码与password二选一
     * @param password 密码长度必须大于6位且小于16位
     * @param phone    手机号码
     * @return
     */
    fun requestNormalLogin(context: Context, code: String, password: String, phone: String,
                           onSuccess: (userBean: UserBean) -> Unit,
                           onFailure: (httpError: HttpError) -> Unit) {

        if (TextUtils.isEmpty(phone)) {
            showToast("请输入您的手机号码")
            return

        }

        if (code.isEmpty() && password.isEmpty()) {
            showToast("请输入密码或验证码")
            return
        }


        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getNormalLoginParameter(code, password, phone),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, UserBean::class.java))
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                })

    }


    /**
     * 退出登录
     * @return
     */
    fun requestNormalOutLogin(context: Activity, onSuccess: () -> Unit) {

        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getNormalOutLoginParameter(),
                onSuccess = {
                    outLoginSuccess()
                    showToast("用户已退出")
                    onSuccess()
                },
                onFailure = {
                    outLoginSuccess()
                    showToast(it.message)
                    true
                })

    }

    /**
     * 账号退出成功操作
     */

    fun outLoginSuccess() {
        // UMShareAPI.get(baseContext).deleteOauth(this@SettingActivity, SHARE_MEDIA.QQ, null)
        // UMShareAPI.get(baseContext).deleteOauth(this@SettingActivity, SHARE_MEDIA.WEIXIN, null)
        // UMShareAPI.get(baseContext).deleteOauth(this@SettingActivity, SHARE_MEDIA.SINA, null)
        DbUtil().clearDb()
        EventBus.getDefault().post(EventBusBean("outLogin"))

    }


    /**
     * 账户详情
     */

    fun requestUserDetail(context: Context,
                          onSuccess: (accountDetailBean: AccountDetailBean) -> Unit,
                          onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getUserDetailParameter(),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, AccountDetailBean::class.java))

                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                })
    }

    /**
     * 购买列表 - > 投注记录
     * @param buyType   buyType  无:所有 0:代购自购 1:发单 2:复制跟单
     * @param context   实例
     * @param page      页数
     * @param pageSize  每个个数
     * @param sinceTime 时间戳  //当前时间 - 需要的时间戳
     */

    fun requestBuyList(context: Context,
                       buyType: Int? = null,
                       pageSize: Int = 20,
                       page: Int = 1,
                       sinceTime: Long?,
                       onSuccess: (buyRecordBean: BuyRecordBean) -> Unit,
                       onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getBuyListParameter(buyType = buyType, page = page, pageSize = pageSize, sinceTime = sinceTime),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, BuyRecordBean::class.java))

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                })
    }


    /**
     * 交易日志 - > 用户记录
     * @param context 实例
     * @param page 页数
     * @param pageSize 每个个数
     * @param sinceTime 时间戳  //当前时间 - 需要的时间戳
     * @param inOut     交易类型 -1:支出 1:收入 (可选)默认为0
     * @param moneyType  金额类型 1:余额 2:彩金 (可选)默认0
     * @param sinceTime  自从时间戳以来的记录 默认无
     */

    fun requestPayLogList(context: Context,
                          inOut: Int = 0,
                          moneyType: Int = 0,
                          pageSize: Int = 20,
                          page: Int = 1,
                          sinceTime: Long? = null,
                          onSuccess: (payLogBean: PayLogBean) -> Unit,
                          onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getPayLogListParameter(inOut = inOut, moneyType = moneyType, page = page, pageSize = pageSize, sinceTime = sinceTime),
                onSuccess = {

                    onSuccess(Gson().fromJson(it, PayLogBean::class.java))

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                })
    }


    /**
     * 购买详情 - > 代购记录
     * @param context 实例
     * @param orderBuyId 认购的id
     */
    fun requestOrderDetailList(context: Context,
                               orderBuyId: Int,
                               onSuccess: (PayDetailBean: PayDetailBean) -> Unit,
                               onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getOrderDetailParameter(orderId = orderBuyId),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, PayDetailBean::class.java))

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                })
    }


    /**
     * 追号列表
     * @param context     实例
     * @param page        页数
     * @param pageSize    每个个数
     * @param lotteryType 彩种
     */

    fun requestChaseList(context: Context,
                         lotteryType: Int = 0,
                         pageSize: Int = 20,
                         page: Int = 1,
                         onSuccess: (chaseList: ArrayList<ChaseBean>, pageInfo: PageInfo) -> Unit,
                         onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getchaseLogListParameter(lotteryType = lotteryType, page = page, pageSize = pageSize),
                onSuccess = {

                    val listString = JSONObject(it).getString("list")
                    val pageString = JSONObject(it).getString("page_info")
                    val pageInfo = Gson().fromJson(pageString, PageInfo::class.java)
                    val list: java.util.ArrayList<ChaseBean> = Gson().fromJson(listString, object : TypeToken<ArrayList<ChaseBean>>() {}.type)
                    onSuccess(list, pageInfo)

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                })
    }


    /**
     * 追号详情
     * @param context     实例
     * @param chaseId     追号Id
     */
    fun requestChaseDetail(context: Context,
                           chaseId: Int = 0,
                           onSuccess: (chaseDetailBean: ChaseDetailBean) -> Unit,
                           onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getchaseDetailParameter(chaseId = chaseId),
                onSuccess = {

                    onSuccess(Gson().fromJson(it, ChaseDetailBean::class.java))

                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                })
    }

    /**
     * 首页详情 -> 断网
     */
    fun requestMain(context: Context,
                    onSuccess: (newDetailBean: NewsDetailBean) -> Unit,
                    onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(context,
                httpParameter = Router.getMainParameter(),
                onSuccess = {


                    onSuccess(Gson().fromJson(it, NewsDetailBean::class.java))

                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                })
    }

    /**
     * 撤单详情 -> 追号记录
     */

    fun requestChaseCancel(context: Context,
                           chaseDetailId: Int? = null,
                           chaseId: Int? = null,
                           onSuccess: (onSuccessBoolean: Boolean) -> Unit,
                           onFailure: (httpError: HttpError) -> Unit) {
        if (chaseDetailId != null && chaseId != null) {
            showToast("撤销和整个追号撤销不能重复")
            return
        }
        if (chaseDetailId == null && chaseId == null) {
            return
        }

        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getChaseCancelParameter(chaseDetailId = chaseDetailId, chaseId = chaseId),
                onSuccess = {
                    onSuccess(true)
                },
                onFailure = {
                    onFailure(it)
                    true
                }
        )
    }


    /**
     * 真实信息认证
     * @param idCard      身份证号码
     * @param idCardTwo   重复身份证号码
     * @param realName    真实姓名
     */
    fun requestRealInfo(
            context: Context,
            idCard: String? = null,
            idCardTwo: String? = null,
            realName: String? = null,
            onSuccess: (realAuthBean: RealAuthBean) -> Unit) {

        if (realName == null) {
            showToast("用户名不能为空")
            return
        }

        if (realName.length < 2 || realName.length > 11) {
            showToast("请输入2~11位有效字符")
            return
        }

        if (idCard == null) {
            showToast("身份证号码不能为空")
            return
        }


        if (idCard.length != 15 && idCard.length != 18) {
            showToast("请输入有效的身份证号码")
            return
        }

        if (idCard != idCardTwo) {
            showToast("身份证号输入不一致,请重新输入")
            return
        }


        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getRealInfoParameter(realName = realName, idCard = idCard),
                onSuccess = {
                    val realString = JSONObject(it).getString("auth")
                    onSuccess(Gson().fromJson(realString, RealAuthBean::class.java))
                },
                onFailure = {
                    showToast(it.message)
                    true
                }

        )

    }


    /**
     * 实名详情
     */
    fun requestRealDetail(
            context: Context,
            onSuccess: (realAuthBean: RealAuthBean) -> Unit) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getRealDetailParameter(),
                onSuccess = {
                    val realString = JSONObject(it).getString("auth")
                    onSuccess(Gson().fromJson(realString, RealAuthBean::class.java))
                },
                onFailure = {
                    showToast(it.message)
                    true
                }
        )
    }


    /**
     * 银行列表
     */

    fun requestBankList(
            context: Context,
            onSuccess: (bankList: ArrayList<CityBean>) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getBankListParameter(),
                onSuccess = {
                    val listString = JSONObject(it).getString("list")
                    onSuccess(Gson().fromJson(listString, object : TypeToken<ArrayList<CityBean>>() {}.type))
                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                }
        )


    }


    /**
     * 绑定银行卡
     */
    fun requestBindBank(
            context: Context,
            bankBranch: String,
            bankCityId: Int,
            backCode: String,
            bankId: Int,
            bankProvinceId: Int,
            onSuccess: (realAuthBean: RealAuthBean) -> Unit
    ) {

        if (bankBranch.isNullOrEmpty()) {
            showToast("银行支行不能为空")
            return
        }

        if (bankId == -1) {
            showToast("请选择银行")
            return
        }

        if (bankProvinceId == -1) {
            showToast("请选择地址")
        }

        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getBindBankParameter(bankBranch, bankCityId, backCode, bankId, bankProvinceId),
                onSuccess = {
                    val realString = JSONObject(it).getString("auth")
                    onSuccess(Gson().fromJson(realString, RealAuthBean::class.java))
                },
                onFailure = {
                    showToast(it.message)
                    true
                }
        )
    }


    /**
     * 检查更新
     */

    fun requestUpdateCheckData(
            context: Context,
            onSuccess: (appUpdateBean: AppUpdateBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getUpdateCheckParameter(),
                onSuccess = {
                    onSuccess(Gson().fromJson(it, AppUpdateBean::class.java))
                },
                onFailure = {
                    onFailure(it)
                    false
                }
        )

    }


    /**
     * 新闻列表
     */

    fun requestNewsLists(
            context: Context,
            categoryId: Int = -1,
            page: Int = 1,
            pageSize: Int = 1,
            onSuccess: (pageInfo: PageInfo, list: ArrayList<NewsItem>) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getNewsListParameter(categoryId = categoryId, pageSize = pageSize, page = page),
                onSuccess = {
                    val listString = JSONObject(it).getString("list")
                    val pageString = JSONObject(it).getString("page_info")

                    val pageInfo = Gson().fromJson(pageString, PageInfo::class.java)
                    val newsItemList = Gson().fromJson<ArrayList<NewsItem>>(listString, object : TypeToken<ArrayList<NewsItem>>() {}.type)

                    onSuccess(pageInfo, newsItemList)
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    false
                }
        )

    }

    /**
     * 新闻详情
     */

    fun requestNewsDetail(
            context: Context,
            id: Int,
            onSuccess: (newsItem: NewsItem) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getNewsDetailParameter(newsId = id),
                onSuccess = {

                    val newsItem = Gson().fromJson(it, NewsItem::class.java)
                    newsItem.timeString = TimeUtil.getIntelligenceTime(newsItem.createTime)

                    onSuccess(newsItem)
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    false
                }
        )

    }

    /**
     * 提现列表
     */
    fun requestApplyWithdrawList(
            context: Context,
            page: Int,
            pageSize: Int = 20,
            onSuccess: (pageInfo: PageInfo, list: ArrayList<WithdrawBean>) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getApplyWithdrawListParameter(page = page, pageSize = pageSize),
                onSuccess = {
                    val listString = JSONObject(it).getString("list")
                    val pageString = JSONObject(it).getString("page_info")

                    val pageInfo = Gson().fromJson(pageString, PageInfo::class.java)
                    val newsItemList = Gson().fromJson<ArrayList<WithdrawBean>>(listString, object : TypeToken<ArrayList<WithdrawBean>>() {}.type)

                    onSuccess(pageInfo, newsItemList)
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                }
        )
    }


    /**
     * 提现申请
     * @param money  提现金额
     */

    fun requestApplyWithdraw(
            context: Context,
            money: String,
            onSuccess: (accountDetailBean: AccountDetailBean) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getApplyWithdrawParameter(money = money),
                onSuccess = {
                    val accountDetailBean = Gson().fromJson(it, AccountDetailBean::class.java)
                    onSuccess(accountDetailBean)
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                }
        )
    }


    /**
     * 充值方式列表
     */

    fun requestRechargeType(
            context: Context,
            onSuccess: (typeList: ArrayList<RechargeBean>) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getRechargeTypeListParameter(),
                onSuccess = {
                    val list = Gson().fromJson<ArrayList<RechargeBean>>(it, object : TypeToken<ArrayList<RechargeBean>>() {}.type)
                    onSuccess(list)
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                }
        )

    }

    /**
     * 充值
     */
    fun requestRecharge(
            context: Context,
            key:String,
            money:Double,
            onSuccess: (url: String) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
    ) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getRechargeTypeListParameter(key,money),
                onSuccess = {
                    onSuccess(JSONObject(it).getString("url"))
                },
                onFailure = {
                    showToast(it.message)
                    onFailure(it)
                    true
                }
        )

    }


    /**
     * 竞彩单关赛事列表
     */

    fun requestSingleMatchList(
            context: Context,
            onSuccess: (bankList: ArrayList<RequestFootballBean>) -> Unit,
            onFailure: (httpError: HttpError) -> Unit) {
        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getSingleMatchListParameter(),
                onSuccess = {
                    val listString = JSONObject(it).getString("list")
                    onSuccess(Gson().fromJson(listString, object : TypeToken<ArrayList<RequestFootballBean>>() {}.type))
                },
                onFailure = {
                    onFailure(it)
                    showToast(it.message)
                    true
                }
        )


    }

    /**
     * 协议网路请求
     */
    fun requestIntro(
            context: Context,
            lotteryId:Int,
            onSuccess: (bankList: String) -> Unit,
            onFailure: (httpError: HttpError) -> Unit
            ){

        HttpUtil().requestWithRouter(
                context = context,
                httpParameter = Router.getAgreeMentStringParmeter(lotteryId = lotteryId),
                onSuccess = {
                    val message = JSONObject(it).getString("intro")

                    onSuccess(message)

                },
                onFailure = {
                    onFailure(it)
                    false
                }
        )

    }




}
