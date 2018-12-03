//
//  TSRequestManager.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
// 
//


let kJSONResponseMsg  = "msg"
let kJSONResponseData = "data"
let kJSONResponseCode = "code"

/// 请求码 逻辑正确 其余均属逻辑错误
let kTSRequestManagerLogicSuccessCode = 200

/// 请求码 需要登录
let kTSRequestManagerShouldLoginCode = 1001

/// 请求码 手机号已存在
let kTSRequestManagerPhoneAlreadyExistCode = 1006

/// 请求码 第三方用户需要注册或绑定
let kTSRequestManagerUserThirdNeedRegisterCode = 1008


/// 请求管理代理
protocol TSRequestManagerDelegate: class {
    
    /**
    请求成功 并且业务逻辑是正确的
    - parameter manager: manager
    - parameter data:    数据为json["data"]的json格式
    */
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON)
    
    /**
    请求错误 包含请求失败(网络错误)和逻辑错误(密码错误,需要登录)
    - parameter manager:  manager
    - parameter error:    错误信息
    - returns: 返回true则需要登录会自动弹出
    */
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool
    
}

/// 实现请求错误方法 这样实现此接口时此方法就为可选了
extension TSRequestManagerDelegate {
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        print(error)
        return true
    }
}

/// 请求管理基类
class TSRequestManager: NSObject {
    
    typealias SuccessedBlock = (_ json: SwiftyJSON.JSON) -> Void
    
    /// 返回true则会在需要登录时自动弹窗
    typealias FailedBlock = (_ error: NSError) -> Bool
    
    /// 代理
    weak var delegate: TSRequestManagerDelegate?
    
    /// 请求对象
    private (set) var requestHandler: Request?
    
    /// 是否正在请求中
    private (set) var isRequesting = false {
        willSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    
    /**
    发起请求 闭包优先级高于代理
    - parameter router:     TSRouter
    - parameter expires:    缓存过期秒数 0为不缓存
    - parameter success:    成功闭包
    - parameter failed:     失败闭包
    */
    @discardableResult
    func requestWithRouter(_ router: TSRouter, expires: TimeInterval = 0, success: SuccessedBlock? = nil, failed: FailedBlock? = nil) -> Request? {
        
        
        guard let routerRequest = try? router.asURLRequest() else {
            log.error("请求的是无效链接")
            return nil
        }
        
        
        log.debug(routerRequest.debugDescription)
        
        isRequesting = true

        // 读取缓存
        let cacheKey = router.md5
        
        // debug时不走缓存
#if !DEBUG
        if expires > 0 {
            do {
                let cache = try Cache<NSString>(name: "requestcache")
                if let result = cache[cacheKey] {
                    
                    isRequesting = false
                    
                    let json = JSON(parseJSON: result as String)
                    if let success = success {
                        success(json)
                    } else {
                        delegate?.requestManager(self, didReceiveData: json)
                    }
                    return requestHandler
                }
            } catch _ {
                log.error("缓存\(cacheKey) 读取失败")
            }
        }
#endif
        
        /// 请求
        requestHandler = Alamofire.request(routerRequest).response {
            r in
            let data = r.data
            let error = r.error
            let response = r.response
            
            self.isRequesting = false
            
            // ------ 响应失败 服务器错误等
            if let response = response {
                guard response.statusCode == 200 else {
                    let userinfo = [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)]
                    let e = NSError(domain: routerRequest.url?.absoluteString ?? "", code: response.statusCode, userInfo: userinfo)
                    self.requstedFailed(e, failed: failed)
                    return
                }
            }
            
            // ------ 请求失败 网络错误等
            if let error = error {
                self.requstedFailed(error as NSError, failed: failed)
                return
            }

            // ------ 请求成功 服务器正确响应(但可能存在业务错误)
            let json = try! JSON(data: data ?? Data())
            let code = json[kJSONResponseCode].intValue
            
            if code == kTSRequestManagerLogicSuccessCode {
                // 业务成功
                if let success = success {
                    success(json[kJSONResponseData])
                } else {
                    self.delegate?.requestManager(self, didReceiveData: json[kJSONResponseData])
                }
                // 写入缓存
                if expires > 0 {
                    do {
                        let cache = try Cache<NSString>(name: "requestcache")
                        if let string = json[kJSONResponseData].rawString() {
                            cache.setObject(string as NSString, forKey: cacheKey, expires: .seconds(expires))
                        }
                    } catch _ {
                        log.error("缓存\(cacheKey) 写入失败")
                    }
                }
                
            } else {
                
                // 业务错误
                let userinfo = [NSLocalizedDescriptionKey: json[kJSONResponseMsg].string ?? "未知错误"]
                let e = NSError(domain: routerRequest.url?.absoluteString ?? "", code: code, userInfo: userinfo)
                let isAutoLogin = self.requstedFailed(e, failed: failed)
                
                if isAutoLogin && code == kTSRequestManagerShouldLoginCode {
                    
                    UserToken.shared.clear()
                    // 发送需要登录的通知
                    NotificationCenter.default.post(name: UserNotification.userShouldLogin.notification, object: self)
                    
                    /// 删除极光别名
                    let seq = random(min: 10_000_000, max: 99_999_999)
                    JPUSHService.deleteAlias({ (isResCode, iAlias, seq) in
                        log.info("删除别名成功")
                    }, seq: seq)
                }
            }
          
        }
        
        return requestHandler
    }
    
    /// 请求错误错误处理
    @discardableResult
    private func requstedFailed(_ error: NSError, failed: FailedBlock?) -> Bool {
        if let failed = failed {
            return failed(error)
        } else {
            return delegate?.requestManager(self, didFailed: error) ?? true
        }
    }
    
    deinit {
        requestHandler?.cancel()
        requestHandler = nil
    }
}
