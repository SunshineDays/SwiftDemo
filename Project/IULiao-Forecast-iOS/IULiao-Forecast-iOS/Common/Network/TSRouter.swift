import Foundation

let kTSRouterKeyPage = "page"
let kTSRouterKeyPageSize = "pagesize"
let kTSRouterKeyPhone = "phone"
let kTSRouterKeyAuthCode = "code"


///  url路由
enum TSRouter: URLRequestConvertible {

#if DEBUG
    static let baseURLString: String = {
        let urlMode = UserDefaults.standard.string(forKey: InfoSettingKey.debugUrlMode) ?? "offline"
        if urlMode == "online" {
            return "https://i.api.\(kBaseDomain)"
        } else if urlMode == "offline" {
            return "https://i.api.\(kBaseDomain)"
//            return "http://i.api.youliaosport.com"
        } else {
            return "https://i.api.\(kBaseDomain)"
        }
    }()
#else
    static let baseURLString = "https://i.api.\(kBaseDomain)"
#endif

    static private let privateKey = "@(iuliao#@!)@"
    
    
    //---------------------------------------------------
    // MARK:- 预测
    //---------------------------------------------------
    
    /// 预测列表
    case forecastAll(type: Int, page: Int, pageSize: Int)
    
    /// 单场详情
    case forecastDetail(forecastId: Int)
    
    /// 专家详情
    case forecastExpertDetail(userId: Int)
    
    /// 专家历史
    case forecastExpertHistory(userId: Int, page: Int, pageSize: Int)
    
    /// 购买预测
    case forecastBuy(forecastId: Int)
    
    //---------------------------------------------------
    // MARK:- 料豆
    //---------------------------------------------------
    
    /// 充值列表
    case liaoRechargeList
    
    /// 交易流水
    case liaoPayFlow(page: Int, pageSize: Int)

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

    /// 用户 反馈
    case userFeedbackApp(content: String, phone: String?)

    //---------------------------------------------------
    // MARK:- 通用
    //---------------------------------------------------

    /// 上传头像
    case commonUploadAvatar

    /// 用户关注
    case commonAttentionFollow(userId: Int)

    /// 取消关注
    case commonAttentionUnFollow(userId: Int)

    /// 评论列表
    case commonCommentList(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 发表评论
    case commonCommentPost(resourceId: Int, module: ModuleAttentionType, content: String, parentId: Int?)

    /// 获取关注 列表
    case commonAttentionList(module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 短信 发送
    case commonSMSSendCode(phone: String, smsType: UserSMSType)

    /// 短信 验证
    case commonSMSCheckCode(phone: String, authCode: String, smsType: UserSMSType)

    /// 浏览 用户
    case commonVisitUser(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 投票 赞踩
    case commonPollVote(resourceId: Int, module: ModuleAttentionType, score: Int)


    //---------------------------------------------------
    // MARK:- 广场 资讯
    //---------------------------------------------------
    
    /// 资讯列表
    case newsList(taxonomyId: Int?, sport: Int?, page: Int, pageSize: Int)
    
    /// 资讯焦点图
    case newsTopList(limit: Int?)
    
    /// 资讯详情
    case newsDetail(newsId: Int)
    
    
    // MARK:- method
    /// 路径与参数
    var pathAndParameters: (path: String, parameters: [String: Any]) {
        var result: (path: String, parameters: [String: Any])
        switch self {

        //---------------------------------------------------
        // MARK:- 预测
        //---------------------------------------------------
            
        /// 预测列表
        case let .forecastAll(type, page, pageSize):
            result = ("/forecast/home/list", ["page": page, "pageSize": pageSize, "type": type])
            
        /// 单场详情
        case let .forecastDetail(forecastId):
            result = ("/forecast/detail", ["forecast_id": forecastId])
            
        /// 专家详情
        case let .forecastExpertDetail(userId):
            result = ("/forecast/professor", ["user_id": userId])
            
        /// 专家历史
        case let .forecastExpertHistory(userId, page, pageSize):
            result = ("/forecast/professor/history", ["user_id": userId, "page": page, "pagesize": pageSize])
            
        /// 购买预测
        case let  .forecastBuy(forecastId):
            result = ("/forecast/sale/buy", ["forecast_id": forecastId])
            
            
        //---------------------------------------------------
        // MARK:- 料豆
        //---------------------------------------------------
            
        /// 料豆充值列表
        case .liaoRechargeList:
            result = ("/user/recharge/price_list", [:])
            
        /// 交易流水
        case let .liaoPayFlow(page, pageSize):
            result = ("/user/account/pay_log", ["page": page, "pagesize": pageSize])
            
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
            result = ("/user/phone/getpassword", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePassword(phone, authCode, password):
            result = ("/user/phone/changepassword", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePhone(phone, authCode):
            result = ("/user/phone/changephone", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode])

        case let .userFeedbackApp(content, phone):
            result = ("/user/feedback/app", ["content": content])
            if let phone = phone {
                result.parameters.updateValue(phone, forKey: kTSRouterKeyPhone)
            }

        case .userInfoDetail:
            result = ("/user/account/detail", [:])

        case let .userInfoUpdate(nickname, gender):
            result = ("/user/info/update", [:])
            if let nickname = nickname {
                result.parameters.updateValue(nickname, forKey: "nickname")
            }
            if let gender = gender {
                result.parameters.updateValue(gender.rawValue, forKey: "gender")
            }

        //---------------------------------------------------
        // MARK:- 通用
        //---------------------------------------------------

        // 关注 添加
        case let .commonAttentionFollow(userId):
            result = ("/common/attention/follow", ["sid": userId, "module": "recommend_statistic"])

        // 关注 取消
        case let .commonAttentionUnFollow(userId):
            result = ("/common/attention/unfollow", ["sid": userId, "module": "recommend_statistic"])

        // 关注 列表
        case let .commonAttentionList(module, page, pageSize):
            result = ("/common/attention/lists", ["module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        // 评论 列表
        case let .commonCommentList(resourceId, module, page, pageSize):
            result = ("/common/comment/lists", ["sid": resourceId, "module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        // 评论 发起
        case let .commonCommentPost(resourceId, module, content, parentId):
            result = ("/common/comment/post", ["sid": resourceId, "module": module.rawValue, "content": content, "parentid": parentId ?? 0])

        // 短信 发送
        case let .commonSMSSendCode(phone, smsType):
            result = ("/common/sms/sendcode", [kTSRouterKeyPhone: phone, "type": smsType.rawValue])

        // 短信 校验
        case let .commonSMSCheckCode(phone, authCode, smsType):
            result = ("/common/sms/checkcode", [kTSRouterKeyPhone: phone, "type": smsType.rawValue, kTSRouterKeyAuthCode: authCode])

        // 上传 头像
        case .commonUploadAvatar:
            result = ("/common/upload/avatar", [:])

        // 用户浏览
        case let .commonVisitUser(resourceId, module, page, pageSize):
            result = ("/common/visit/user", ["sid": resourceId, "module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            
        // 投票赞踩
        case let .commonPollVote(resourceId, module, score):
            result = ("/common/poll/vote", ["sid": resourceId, "module": module.rawValue, "score": score])
            
            
        //---------------------------------------------------
        // MARK:- 广场 资讯
        //---------------------------------------------------
            
        // 新闻资讯
        case let .newsList(taxonomyId, sport, page, pageSize):
            result = ("/main/news/lists", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            if let taxonomyId = taxonomyId {
                result.parameters.updateValue(taxonomyId, forKey: "taxonomyid")
            }
            if let sport = sport {
                result.parameters.updateValue(sport, forKey: "sport")
            }
            
        // 资讯预测
        case let .newsTopList(limit):
            result = ("/main/news/tops", ["limit": limit ?? 6])
            
        // 资讯详情
        case let .newsDetail(newsId):
            result = ("/main/news/detail", ["id": newsId])

        }
        

        //统一添加 版本 token 时间戳 随机字符串
        let version = AppInfoHelper.appVersion
        let time = Int(Foundation.Date().timeIntervalSince1970)
        let random = Utils.randomString(8)

        result.parameters.updateValue(version, forKey: "v")
        result.parameters.updateValue(time, forKey: "t")
        result.parameters.updateValue(random, forKey: "r")
        result.parameters.updateValue("i", forKey: "p")
        result.parameters.updateValue("forecast", forKey: "a")

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

