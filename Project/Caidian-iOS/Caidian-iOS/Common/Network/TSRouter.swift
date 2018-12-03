import Foundation
import Alamofire

let kTSRouterKeyPage = "page"
let kTSRouterKeyPageSize = "page_size"
let kTSRouterKeyPhone = "phone"
let kTSRouterKeyAuthCode = "code"


///  url路由
enum TSRouter: URLRequestConvertible {

#if DEBUG
    static let baseURLString: String = {
        let urlMode = UserDefaults.standard.string(forKey: TSSettingKey.debugUrlMode) ?? "online"
        if urlMode == "online" {
            return "http://iapi.\(kBaseDomain)"
//            return "http://iapi.\(kBaseDebug)"
        } else if urlMode == "local" || urlMode == "offline" {
            return "http://iapi.\(kBaseDebug)"
        }
        return  UserToken.shared.router
    }()
#else
    static let baseURLString = "https://iapi.\(kBaseDomain)"
#endif

    static private let privateKey = "@(caidian310#@!)@"

    //---------------------------------------------------
    // MARK:- 用户中心
    //---------------------------------------------------

    /// 注册 普通注册
    case userRegisterNormal(phone: String, authCode: String, password: String, nickname: String)

    /// 注册 第三方注册或绑定
    case userRegisterThird(phone: String, authCode: String, nickname: String, openInfo: UserOpenModel)

    /// 登录 手机号+密码
    case userLoginPassword(phone: String, password: String)

    /// 登录 手机号+验证码
    case userLoginAuthCode(phone: String, authCode: String)

    /// 登录 第三方
    case userLoginThird(openInfo: UserOpenModel)

    /// 登录 退出登录
    case userLogout

    /// 手机 找回密码
    case userGetPassword(phone: String, authCode: String, password: String)

    /// 手机 修改密码
    case userChangePassword(phone: String, authCode: String, password: String)

    /// 手机 更换手机
    case userChangePhone(phone: String, authCode: String)

    /// 信息 详情
    case userInfoDetail

    /// 信息 修改
    case userInfoUpdate(nickname: String?, gender: UserGenderType?)

    /// 银行卡绑定
    case userBindingBank(bankBranch: String, bankCityId: Int, backCode: String, bankId: Int, bankProvinceId: Int)

    /// 银行卡列表
    case userBankList

    /// 用户真实信息
    case userAuthDetail

    /// 用户 反馈
    case userFeedbackApp(content: String, phone: String?)

    /// 支付方式列表
    case userRechargeList

    /// 申请充值
    case userRechargeApply(key: String, money: Double)

    /// 账户详情
    case userAccountDetail

    /// 提现申请
    case userWithDrawApply(money: Double)

    /// 提现记录列表
    case userWithDrawList(page: Int, pageSize: Int)

    /// 实名认证
    case userRealNameInfo(isCard: String, realName: String)

    /// 购买列表
    case userOrderBuyList(buyType: OrderBuyType, page: Int, pageSize: Int, sinceTime: Int?)

    /// 购买详情
    case userOrderDetail(orderBuyId: Int)

    /// 交易日志
    case userAccountPayLog(inOut: InOutType, moneyType: MoneyType, page: Int, pageSize: Int, sinceTime: TimeInterval?)

    //---------------------------------------------------
    // MARK:- 通用
    //---------------------------------------------------

    /// 上传头像
    case commonUploadAvatar

    /// 短信 发送
    case commonSMSSendCode(phone: String, smsType: UserSMSType)

    /// 短信 验证
    case commonSMSCheckCode(phone: String, authCode: String, smsType: UserSMSType)
    
    /// 检查更新
    case commonUpdateCheck

    //---------------------------------------------------
    // MARK:- 资讯
    //---------------------------------------------------

    /// 资讯列表
    case newsList(categoryId: Int?, page: Int, pageSize: Int)

    /// 资讯详情
    case newsDetail(newsId: Int)

    //---------------------------------------------------
    // MARK:- 投注
    //---------------------------------------------------
    


    /// 竞彩足球对阵
    case saleJczqMatchList
    
    case saleJczqTeamHistoryInfo(matchId: Int)

    /// 竞彩篮球对阵
    case saleJclqMatchList
    
    /// 北京单场对阵
   case saleBeiDanMatchList
    
    /// 购买
    case saleBuy(json: String)

    /// 销售期号
    case saleIssueList(lottery: LotteryType)

    /// 开奖期号列表
    case saleIssueResult(lottery: LotteryType, page: Int, pageSize: Int)

    /// 期号详情
    case saleIssueDetail(issueId: Int)

    /// 竞彩单关赛事列表
    case saleJcspfSingleMatchList
    
    //---------------------------------------------------
    // MARK:- 专家推荐
    //---------------------------------------------------

    /// 推荐列表
    case recommendList(page: Int, pageSize: Int)
    
    /// 推荐详情
    case recommendDetail(recommendId: Int)
    
    /// 专家历史推荐
    case recommendExpertList(professorId: Int, page: Int, pageSize: Int)
    
    
    //---------------------------------------------------
    // MARK:- 复制跟单
    //---------------------------------------------------

    /// 复制跟单列表
    case copayOrderList(page: Int, pageSize: Int)

    /// 复制跟单详情
    case copyOrderDetail(orderId: Int)

    /// 复制跟单购买
    case copyOrderBuy(orderId: Int, multiple: Int, totalMoney: Double)

    /// 复制跟单用户
    case copyOrderAccount(orderId: Int, page: Int, pageSize: Int)
    
    /// 复制发单用户信息
    case copyUserInfor(userId: Int)
    
    /// 复制发单用户历史发单列表
    case copyUserHistory(userId: Int, page: Int, pageSize: Int)
    

    /// 计划单跟单用户
    case planOrderAccount(planDetailId: Int, page: Int, pageSize: Int)

    /// 计划单详情页
    case planOrderDetail(planDetailId: Int)
    
    /// 计划单购买
    case planOrderBuy(planDetailId: Int,money:Double)
    
    /// 大计划单首页列表
    case planOrderBigPlanList(page: Int, pageSize: Int)
    
    /// 作者计划单列表
    case planOrderHomeList(planId: Int,page:Int,pageSize:Int)
    
    /// 我的计划单
    case planOrderBigPlanBuyList(page: Int, pageSize: Int)
    
    /// 我的计划单(作者)
    case planOrderBuyList(planId: Int, page: Int, pageSize: Int)
    
    /// 计划单作者近30天订单
    case planOrderAuthorOrderList(planId: Int)
    
    /// 首页计划单（热门）
    case planOrderHomeData

    //---------------------------------------------------
    // MARK:- 其他
    //---------------------------------------------------

    /// 首页彩种和轮播图
    case mainHome

    /// 彩种玩法介绍
    case appSettingLotteryIntro(lottery: LotteryType)

    /// 今日热单列表
    case copyHotOrderList(page: Int, pageSize: Int)


    // MARK:- method
    /// 路径与参数
    var pathAndParameters: (path: String, parameters: [String: Any]) {
        var result: (path: String, parameters: [String: Any])
        switch self {

                //---------------------------------------------------
                // MARK:- 新闻资讯
                //---------------------------------------------------

                // 新闻资讯
        case let .newsList(categoryId, page, pageSize):
            result = ("/main/news/lists", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            if let categoryId = categoryId {
                result.parameters.updateValue(categoryId, forKey: "category_id")
            }

                // 资讯详情
        case let .newsDetail(newsId):
            result = ("/main/news/detail", ["news_id": newsId])


                //---------------------------------------------------
                // MARK:- 用户
                //---------------------------------------------------

        case let .userRegisterNormal(phone, authCode, password, nickname):
            result = ("/user/register/normal", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password, "nickname": nickname])

        case let .userRegisterThird(phone, authCode, nickname, open):
            result = ("/user/register/thirdregister", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "nickname": nickname, "openid": open.openID, "gender": open.gender.rawValue, "access_token": open.accessToken, "expiration": open.expiration, "genre": open.thirdType.rawValue])
            if let avatarUrl = open.avatarUrl {
                result.parameters.updateValue(avatarUrl, forKey: "avatar_url")
            }
            if let refreshToken = open.refreshToken {
                result.parameters.updateValue(refreshToken, forKey: "refresh_token")
            }

        case let .userLoginPassword(phone, password):
            result = ("/user/login/normal", [kTSRouterKeyPhone: phone, "password": password])

        case let .userLoginAuthCode(phone, authCode):
            result = ("/user/login/normal", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode])

        case let .userLoginThird(open):
            result = ("/user/login/thirdlogin", ["nickname": open.nickname, "openid": open.openID, "gender": open.gender.rawValue, "access_token": open.accessToken, "expiration": open.expiration, "genre": open.thirdType.rawValue])
            if let avatarUrl = open.avatarUrl {
                result.parameters.updateValue(avatarUrl, forKey: "avatar_url")
            }
            if let refreshToken = open.refreshToken {
                result.parameters.updateValue(refreshToken, forKey: "refresh_token")
            }

        case .userLogout:
            result = ("/user/login/logout", [:])

        case let .userGetPassword(phone, authCode, password):
            result = ("/user/phone/get_password", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePassword(phone, authCode, password):
            result = ("/user/phone/change_password", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePhone(phone, authCode):
            result = ("/user/phone/change_phone", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode])

        case let .userFeedbackApp(content, phone):
            result = ("/user/feedback/app", ["content": content])
            if let phone = phone {
                result.parameters.updateValue(phone, forKey: kTSRouterKeyPhone)
            }

        case .userInfoDetail:
            result = ("/user/info/detail", [:])

                /// 用户详情
        case .userAuthDetail:
            result = ("user/auth/detail", [:])
                /// 实名认证
        case let .userRealNameInfo(isCard, realName):
            result = ("user/auth/real_name", ["card_code": isCard, "real_name": realName])

                /// 银行卡列表
        case .userBankList:
            result = ("/common/bank/lists", [:])

        case let .userBindingBank(bankBranch, bankCityId, bankCode, bankId, bankProvinceId):
            result = ("user/auth/bind_bank", ["bank_branch": bankBranch, "bank_city": bankCityId, "bank_code": bankCode, "bank_id": bankId, "bank_province": bankProvinceId])

        case let .userInfoUpdate(nickname, gender):
            result = ("/user/info/update", [:])
            if let nickname = nickname {
                result.parameters.updateValue(nickname, forKey: "nickname")
            }
            if let gender = gender {
                result.parameters.updateValue(gender.rawValue, forKey: "gender")
            }
                /// 支付方式列表
        case .userRechargeList:
            result = ("/user/recharge/lists", [:])

                /// 申请充值
        case let .userRechargeApply(key, money):
            result = ("/user/recharge/apply", ["key": key, "money": "\(money)"])

                /// 账户详情
        case .userAccountDetail:
            result = ("/user/account/detail", [:])

                /// 提现申请
        case let .userWithDrawApply(money):
            result = ("/user/withdraw/apply", ["money": "\(money)"])

                /// 提现记录列表
        case let .userWithDrawList(page, pageSize):
            result = ("/user/withdraw/lists", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

                /// 购买列表
        case let .userOrderBuyList(buyType, page, pageSize, sinceTime):
            result = ("/user/order/buy_list", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            if buyType != OrderBuyType.all {
                result.parameters.updateValue(buyType.rawValue, forKey: "buy_type")
            }
            if let sinceTime = sinceTime {
                result.parameters.updateValue(sinceTime.description, forKey: "since_time")
            }

                /// 购买详情
        case let .userOrderDetail(orderBuyId):
            result = ("/user/order/detail", ["order_buy_id": orderBuyId])

                /// 交易日志
        case let .userAccountPayLog(inOut, moneyType, page, pageSize, sinceTime):
            result = ("/user/account/pay_log", ["in_out": inOut.rawValue, "money_type": moneyType.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            if let sinceTime = sinceTime {
                result.parameters.updateValue(sinceTime.description, forKey: "since_time")
            }

                //---------------------------------------------------
                // MARK:- 通用
                //---------------------------------------------------

                // 短信 发送
        case let .commonSMSSendCode(phone, smsType):
            result = ("/common/sms/send_code", [kTSRouterKeyPhone: phone, "type": smsType.rawValue])

                // 短信 校验
        case let .commonSMSCheckCode(phone, authCode, smsType):
            result = ("/common/sms/check_code", [kTSRouterKeyPhone: phone, "type": smsType.rawValue, kTSRouterKeyAuthCode: authCode])

                // 上传 头像
        case .commonUploadAvatar:
            result = ("/common/upload/avatar", [:])
            
            // 检查更新
        case .commonUpdateCheck:
            result = ("app/update/check", [:])

                //---------------------------------------------------
                // MARK:- 投注
                //---------------------------------------------------


                /// 竞彩足球对阵
        case .saleJczqMatchList:
            result = ("/sale/jingcai/match_list", [:])
            
        case let .saleJczqTeamHistoryInfo(matchId):
            result = ("/sale/jingcai/match_info", ["match_id": matchId])

                /// 竞彩篮球对阵
        case .saleJclqMatchList:
            result = ("/sale/basketball/match_list", [:])
            
                /// 北京单场
        case .saleBeiDanMatchList :
            result = ("/sale/beidan/match_list",[:])

                /// 购买
        case let .saleBuy(json):
            result = ("/sale/buy", ["json": json])

                /// 销售期号
        case let .saleIssueList(lottery):
            result = ("/sale/issue", ["lottery_id": lottery.rawValue])

                /// 开奖期号
        case let .saleIssueResult(lottery, page, pageSize):
            result = ("/sale/issue/result_list", ["lottery_id": lottery.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

                /// 期号详情
        case let .saleIssueDetail(issueId):
            result = ("/sale/issue", ["issue_id": issueId])


                /// 竞彩单关赛事列表
        case .saleJcspfSingleMatchList:
            result = ("/sale/jingcai/spf_single_match_list", [:])
            
            
        //---------------------------------------------------
        // MARK:- 专家推荐
        //---------------------------------------------------
            
        /// 推荐列表
        case  let .recommendList(page, pageSize):
            result = ("/recommend/home/lists", ["page": page, "page_size": pageSize])
            
        /// 推荐详情
        case let .recommendDetail(recommendId):
            result = ("/recommend/detail/index", ["recommend_id": recommendId])
            
        /// 专家历史推荐
        case let .recommendExpertList(professorId, page, pageSize):
            result = ("/recommend/professor/index", ["professor_id": professorId, "page": page, "page_size": pageSize])
            

        //---------------------------------------------------
        // MARK:- 复制跟单
        //---------------------------------------------------

                /// 复制跟单列表
        case let .copayOrderList(page, pageSize):
            result = ("/copy/copyorder/lists", ["page": page, "page_size": pageSize])

                /// 复制跟单详情
        case let .copyOrderDetail(orderId):
            result = ("/copy/copyorder/detail", ["order_id": orderId])

                /// 复制跟单购买
        case let .copyOrderBuy(orderId, multiple, totalMoney):
            result = ("/copy/copyorder/buy", ["order_id": orderId, "multiple": multiple, "total_money": "\(totalMoney)"])

                /// 复制跟单用户
        case let .copyOrderAccount(orderId, page, pageSize):
            result = ("/copy/copyorder/copy_list", ["order_id": orderId, "page": page, "page_size": pageSize])
            
            
        /// 复制发单用户信息
        case let .copyUserInfor(userId):
            result = ("/copy/sponsor/detail", ["user_id": userId])

        /// 复制发单用户历史发单列表
        case let .copyUserHistory(userId, page, pageSize):
            result = ("/copy/sponsor/order_list", ["user_id": userId, "page": page, "page_size": pageSize])

              /// 计划单跟单用户
        case let .planOrderAccount(planDetailId, page, pageSize):
            result = ("/plan/detail/follow_list", ["detail_id": planDetailId, "page": page, "page_size": pageSize])

                /// 计划单详情页
        case let .planOrderDetail(planDetailId):
            result = ("/plan/detail", ["detail_id": planDetailId])
            
        /// 首页大计划单列表
        case let .planOrderBigPlanList(page, pageSize):
            result = ("/plan/home/lists", ["page": page, "pageSize": pageSize])
            
            /// 首页计划单列表
        case let .planOrderHomeList(planId,page,pageSize) :
            result = ("/plan/home/detail_list",["plan_id" : planId,"page" : page, "page_size" : pageSize])
            
        /// 我的计划单
        case let .planOrderBigPlanBuyList(page, pageSize):
            result = ("/plan/buy/plan_list",["page" : page, "page_size" : pageSize])
            
        /// 计划单购买记录（作者）
        case let .planOrderBuyList(planId, page, pageSize):
            result = ("/plan/buy/lists", ["plan_id" : planId, "page": page, "pageSize": pageSize])
            
            /// 计划单作者近30天订单
        case let .planOrderAuthorOrderList(planId):
            result = ("/plan/home/analog", ["plan_id": planId])
            
        /// 计划单 购买
        case let  .planOrderBuy(planDetailId,money):
            result = ("/plan/buy", ["detail_id": planDetailId,"money":"\(money)"])

        /// 首页计划单（热门）
        case .planOrderHomeData:
            result = ("/plan/home/detail_hot", [:])
                //---------------------------------------------------
                // MARK:- 其他
                //---------------------------------------------------

                /// 彩种接口和轮播图
        case .mainHome:
            result = ("/main/home", [:])

                /// 彩种玩法介绍
        case let .appSettingLotteryIntro(lottery):
            result = ("/app/setting/lottery_intro", ["lottery_id": lottery.rawValue])

                /// 今日热单列表
        case let .copyHotOrderList(page, pageSize):
            result = ("/copy/copyorder/hot_order_list", ["page": page, "page_size": pageSize])

        }

        // 统一添加 版本 token 时间戳 随机字符串
        let version = TSAppInfoHelper.appVersion
        let time = Int(Foundation.Date().timeIntervalSince1970)
        let random = TSUtils.randomString(length: 8)

        result.parameters.updateValue(version, forKey: "v")
        result.parameters.updateValue(time, forKey: "t")
        result.parameters.updateValue(random, forKey: "r")
        result.parameters.updateValue("i", forKey: "p")

        if let token = UserToken.shared.token {
            result.parameters.updateValue(token, forKey: "token")
        }

        return result
    }

    // url request  配置请求参数 以及URLRequest、类型
    func asURLRequest() throws -> URLRequest {
        var (path, parameters) = pathAndParameters
        let signStr = sign(parameters)
        // 添加签名 加密操作
        parameters.updateValue(signStr, forKey: "sign")

        let url = try TSRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        let request = try URLEncoding.default.encode(urlRequest, with: parameters)

        return request
    }

    // 请求方法
    private var method: HTTPMethod {
#if DEBUG
        return .get
#else
        return .post
#endif
    }

    // 签名规则 所有参数key按字典序排列 key + privateKey + value 最后md5
    func sign(_ parameters: [String: Any]) -> String {
        var keys = Array(parameters.keys)
        keys.sort()

        var str = ""
        for key in keys {
            if let value = parameters[key] {
                str += "\(key)\(TSRouter.privateKey)\(value)"
            }
        }
        return str.md5

    }

    // 每个请求根据path 和 parameters算出来的md5(不包含时间t和随机数，签名sign)
    var md5: String {
        var (path, parameters) = pathAndParameters
        parameters.removeValue(forKey: "t")
        parameters.removeValue(forKey: "sign")
        parameters.removeValue(forKey: "r")
        return (path + parameters.description).md5
    }

}

