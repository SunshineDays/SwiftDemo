package com.caidian310.http

import java.io.File


/**
 * app 接口路径 管理
 */
object Router {

    /**
     * app统一入口
     */
//    val baseUrl = "https://iapi.caidian310.com/"
    val baseUrl = "http://iapi.bzcp188.com/"

    /**
     * 比分嵌套地址
     */
    var liveUrl = "http://m.hz.caidian310.com/live/home2"


    /**
     * 检查自动更新监测
     * @return
     */
    fun getUpdateCheckParameter() = HttpParameter(path = "app/update/check", hashMap = java.util.HashMap())

    /**
     * 检查服务器时间和本地时间的差值
     * @return
     */
    fun getServerTimeParameter() = HttpParameter(path = "app/server/time", hashMap = java.util.HashMap())

    /**
     *
     * 文件上传
     * @param file 文件路径
     * @return
     */
    fun getUpdateFileParameter(file: File) = HttpParameter(path = "common/upload/avatar", hashMap = java.util.HashMap(), file = file)


    /**
     * 竞彩足球对阵
     * @return
     */
    fun getJingCaiMatchListParameter() = HttpParameter(path = "sale/jingcai/match_list", hashMap = java.util.HashMap())

    /**
     * 短信验证码
     *
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun getCodeParameter(phone: String, type: Int) = HttpParameter(path = "common/sms/send_code", hashMap = hashMapOf("phone" to phone, "type" to type.toString()))


    /**
     * 校验验证码
     *
     * @param phone 手机号
     * @param type  类型1:注册 2:找回密码 3:更换手机 4:验证码登录 5:修改密码
     * @return
     */
    fun getCheckCodeParameter(code: String, phone: String, type: Int) = HttpParameter(path = "common/sms/check_code",
            hashMap = hashMapOf("code" to code, "phone" to phone, "type" to type.toString()))

    /**
     *  更换手机
     *
     * @param phone 手机号
     * @param code  验证码
     * @return
     */
    fun getChangePhoneParameter(code: String, phone: String) = HttpParameter(path = "user/phone/change_phone",
            hashMap = hashMapOf("code" to code, "phone" to phone))


    /**
     * 手机 修改密码
     *
     * @param code     验证码
     * @param password 新密码
     * @param phone    手机号
     * @return
     */
    fun getUpdatePassword(code: String, password: String, phone: String) = HttpParameter(path = "user/phone/change_password",
            hashMap = hashMapOf("code" to code, "password" to password, "phone" to phone))

    /**
     * 手机 找回密码
     *
     * @param code     验证码与password二选一
     * @param password 密码长度必须大于6位且小于16位
     * @return
     */
    fun getSeekPassword(code: String, password: String, phone: String) = HttpParameter(path = "user/phone/get_password",
            hashMap = hashMapOf("code" to code, "password" to password, "phone" to phone))

    /**
     * 普通注册
     * @param code 验证码
     * @param nickName 用户名
     * @param phone 手机号
     * @param password 密码
     * @return
     */
    fun getNormalRegisterParameter(code: String, nickName: String, password: String, phone: String): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap.put("nickname", nickName)
        hashMap.put("password", password)
        hashMap.put("phone", phone)
        hashMap.put("code", code)
        return HttpParameter(path = "user/register/normal", hashMap = hashMap)
    }

    /**
     * 登录 手机号+[密码|验证码]
     *
     * @param code     验证码与password二选一
     * @param password 密码长度必须大于6位且小于16位
     * @param phone
     * @return
     */
    fun getNormalLoginParameter(code: String? = null, password: String, phone: String? = null): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap["password"] = password
        if (code != null) hashMap["code"] = code
        if (phone != null) hashMap["phone"] = phone
        return HttpParameter(path = "user/login/normal", hashMap = hashMap)

    }

    /**
     * 退出登录
     * @return
     */
    fun getNormalOutLoginParameter() = HttpParameter(path = "user/login/logout", hashMap = java.util.HashMap())


    /**
     * 购买
     * @return
     */
    fun getJingCaiBuyParameter(json: String): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap["json"] = json
        return HttpParameter(path = "sale/buy", hashMap = hashMap)
    }

    /**
     * 购买详情
     * @return
     */
    fun getOrderDetailParameter(orderId: Int): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap["order_buy_id"] = orderId
        return HttpParameter(path = "user/order/detail", hashMap = hashMap)
    }

    /**
     * 购买列表
     * @param buyType  无:所有 0:代购自购 1:发单 2:复制跟单
     * @param sinceTime 时间筛选
     * @return
     */
    fun getBuyListParameter(buyType: Int? = null, page: Int = 1, pageSize: Int = 20, sinceTime: Long? = null): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        if (buyType != null)
            hashMap["buy_type"] = buyType
        hashMap["page"] = page
        hashMap["page_size"] = pageSize
        if (sinceTime != null)
            hashMap["since_time"] = sinceTime
        return HttpParameter(path = "user/order/buy_list", hashMap = hashMap)
    }

    /**
     * 购买列表
     * @param inOut      交易类型 -1:支出 1:收入 (可选)默认为0
     * @param moneyType  金额类型 1:余额 2:彩金 (可选)默认0
     * @param sinceTime  自从时间戳以来的记录 默认无
     * @return
     */
    fun getPayLogListParameter(inOut: Int = 0, moneyType: Int = 0, page: Int = 1, pageSize: Int = 20, sinceTime: Long? = null): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap["in_out"] = inOut
        hashMap["money_type"] = moneyType
        hashMap["page"] = page
        hashMap["page_size"] = pageSize
        if (sinceTime != null)
            hashMap.put("since_time", sinceTime)
        return HttpParameter(path = "user/account/pay_log", hashMap = hashMap)
    }

    /**
     * 追号购买列表
     * @param lotteryType      彩种类型 1:数字 2:快频
     * @param page  金额类型 1:余额 2:彩金 (可选)默认0
     * @param pageSize  自从时间戳以来的记录 默认无
     * @return
     */
    fun getchaseLogListParameter(lotteryType: Int = 1, page: Int = 1, pageSize: Int = 20): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap.put("lottery_type", lotteryType)
        hashMap.put("page", page)
        hashMap.put("page_size", pageSize)
        return HttpParameter(path = "user/chase/buy_list", hashMap = hashMap)
    }

    /**
     * 追号购买详情
     * @param chaseId     彩种类型 1:竞技彩 (不可用) 2:数字 3:快频
     */
    fun getchaseDetailParameter(chaseId: Int = 1): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        hashMap.put("chase_id", chaseId)

        return HttpParameter(path = "user/chase/detail", hashMap = hashMap)
    }

    /**
     * 账户详情
     * @return
     */
    fun getUserDetailParameter() = HttpParameter(path = "user/account/detail", hashMap = java.util.HashMap())


    /**
     * 竞彩篮球对阵
     * @return
     */
    fun getBaskballMatchListParameter() = HttpParameter(path = "sale/basketball/match_list", hashMap = java.util.HashMap())

    /**
     * 竞彩对阵  lottery 11胜负彩 19任九 16半全场 18四场进球
     * @return
     */
    fun getSportLotteryIdMatchListParameter(lotteryId: Int) = HttpParameter(path = "sale/zucai/match_list", hashMap = hashMapOf("lottery_id" to lotteryId))


    /**
     * 大乐透 历史期
     * @return
     */

    fun getDltHistoryIssueListParameter(lotteryId: Int, page: Int = 1, pageSize: Int = 10) =
            HttpParameter(
                    path = "sale/issue/result_list",
                    hashMap = hashMapOf(
                            "lottery_id" to lotteryId,
                            "page" to page,
                            "page_size" to pageSize)
            )

    /**
     * 大乐透 详情
     * @param issueId 大乐透期号
     * @return
     */

    fun getDltIssueDetailParameter(issueId: Int) = HttpParameter(path = "sale/issue/detail", hashMap = hashMapOf("issue_id" to issueId))

    /**
     * 大乐透 未来期号
     * @param lotteryId 彩种
     * @return
     */

    fun getDltIssueFutureParameter(lotteryId: Int) = HttpParameter(path = "sale/issue", hashMap = hashMapOf("lottery_id" to lotteryId))

    /**
     * 首页轮播及消息推送   默认缓存一天()
     * @return
     */

    fun getMainParameter() = HttpParameter(path = "main/home", hashMap = java.util.HashMap())


    /**
     * 追号取消
     * @param
     */

    fun getChaseCancelParameter(chaseDetailId: Int? = null, chaseId: Int? = null): HttpParameter {
        val hashMap: HashMap<String, Any> = HashMap()
        if (chaseDetailId != null) hashMap["chase_detail_id"] = chaseDetailId
        if (chaseId != null) hashMap["chase_id"] = chaseId
        return HttpParameter(path = "user/chase/cancel", hashMap = hashMap)


    }


    /**
     * 真实信息认证
     * @param realName 真实姓名
     * @param idCard  身份证号码
     * @return
     */

    fun getRealInfoParameter(realName: String, idCard: String) =
            HttpParameter(path = "user/auth/real_name", hashMap = hashMapOf("card_code" to idCard, "real_name" to realName))

    /**
     * 真实信息详情
     * @return
     */

    fun getRealDetailParameter() = HttpParameter(path = "user/auth/detail", hashMap = hashMapOf())

    /**
     * 银行列表
     * @return
     */

    fun getBankListParameter() = HttpParameter(path = "common/bank/lists", hashMap = hashMapOf())

    /**
     * 新闻列表
     * @return
     */

    fun getNewsListParameter(categoryId: Int = -1, page: Int = 0, pageSize: Int = 0): HttpParameter {

        val hashMap: HashMap<String, Any> = HashMap()
        hashMap["page"] = page
        hashMap["page_size"] = pageSize
        if (categoryId != -1) hashMap["category_id"] = categoryId
        return HttpParameter(
                path = "main/news/lists",
                hashMap = hashMap)
    }

    /**
     * 新闻详情
     * @return
     */

    fun getNewsDetailParameter(newsId: Int = 0) = HttpParameter(
            path = "main/news/detail",
            hashMap = hashMapOf("news_id" to newsId))

    /**
     * 绑定银行卡
     * @param bankBranch      银行支行
     * @param bankCityId      市Id
     * @param bankProvinceId  省Id
     * @param bankCode        银行卡号
     * @param bankId          银行Id
     * @return
     */

    fun getBindBankParameter(bankBranch: String, bankCityId: Int, bankCode: String, bankId: Int, bankProvinceId: Int) = HttpParameter(
            path = "user/auth/bind_bank",
            hashMap = hashMapOf(
                    "bank_branch" to bankBranch,
                    "bank_city" to bankCityId,
                    "bank_code" to bankCode,
                    "bank_id" to bankId,
                    "bank_province" to bankProvinceId
            )
    )

    /**
     * 提现申请
     * @param money   金额
     * @return
     */

    fun getApplyWithdrawParameter(money: String) = HttpParameter(
            path = "user/withdraw/apply",
            hashMap = hashMapOf("money" to money))

    /**
     * 提现列表
     * @return
     */

    fun getApplyWithdrawListParameter(page: Int, pageSize: Int) = HttpParameter(
            path = "user/withdraw/lists",
            hashMap = hashMapOf("page" to page, "page_size" to pageSize))


    /**
     * 充值列表
     * @return
     */

    fun getRechargeTypeListParameter() = HttpParameter(
            path = "user/recharge/lists",
            hashMap = hashMapOf())

    /**
     * 充值
     * @return
     */

    fun getRechargeTypeListParameter(key: String, money: Double) = HttpParameter(
            path = "user/recharge/apply",
            hashMap = hashMapOf("key" to key, "money" to money))


    /**
     * 复制跟单列表
     */
    fun getCopyOrderListParameter(page: Int, pageSize: Int) = HttpParameter(
            path = "copy/copyorder/lists",
            hashMap = hashMapOf("page" to page, "page_size" to pageSize)
    )

    /**
     * 今日热单列表
     */
    fun getHotOrderListParameter(page: Int, pageSize: Int) = HttpParameter(
            path = "copy/copyorder/hot_order_list",
            hashMap = hashMapOf("page" to page, "page_size" to pageSize)
    )

    /**
     * 复制跟单详情
     * @param id orderId
     */
    fun getCopyOrderDetailParameter(id: Int) = HttpParameter(
            path = "copy/copyorder/detail",
            hashMap = hashMapOf("order_id" to id)
    )
    /**
     * 复制跟单购买
     * @param id orderId
     */
    fun getCopyOrderBuyParameter(orderId: Int,multiple:Int,totalMoney:Double) = HttpParameter(
            path = "copy/copyorder/buy",
            hashMap = hashMapOf("order_id" to orderId,"multiple" to multiple, "total_money" to totalMoney)
    )

    /**
     * 复制跟单人
     * @param id orderId
     */
    fun getCopyOrderPersonParameter(orderId: Int,page: Int, pageSize: Int) = HttpParameter(
            path = "copy/copyorder/copy_list",
            hashMap = hashMapOf("order_id" to orderId,"page" to page, "page_size" to pageSize)
    )

   /**
     * 竞彩单关赛事
     */
    fun getSingleMatchListParameter() = HttpParameter(
            path = "sale/jingcai/spf_single_match_list",
            hashMap = hashMapOf()
   )


    /**
     * 玩法协议请求
     * @param lotteryId  彩种
     */

    fun getAgreeMentStringParmeter(lotteryId: Int) = HttpParameter(
            path = "app/setting/lottery_intro",
            hashMap = hashMapOf("lottery_id" to lotteryId)
    )



}