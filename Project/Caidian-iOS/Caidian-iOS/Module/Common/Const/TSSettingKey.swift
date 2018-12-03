//
//  TSSettingKey.swift
//  HuaXia
//
//  Created by tianshui on 15/10/27.
// 
//

import Foundation

/// info.plist中的key
struct TSSettingKey {
    
    /// 引导界面运行过的版本
    static let guideViewVersion = "GuideViewVersion"
    
    /// token信息
    static let token = "Token"
    
    /// 登录用户信息
    static let loginUserInfo = "LoginUserInfo"
    
    /// 用户账户
    static let userAccount = "UserAccount"
    
    /// 购物车信息
    static let userCartInfo = "UserCartInfo"
    
    /// 购买成功的推荐id
    static let userCartBuySuccessIDs = "UserCartBuySuccessIDs"

    /// debug url
    static let debugUrlMode = "DebugUrlMode"
    
    /// debug 显示模式
    static let debugDisplayMode = "DebugDisplayMode"
    
    
    /// debug 域名切换
    static let debugUpdateRouter = "DebugUpdateRouter"
    
}
