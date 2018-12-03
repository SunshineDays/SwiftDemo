//
//  InfoSettingKey.swift
//  HuaXia
//
//  Created by tianshui on 15/10/27.
// 
//

import Foundation

/// info.plist中的key
struct InfoSettingKey {
    
    /// 是否是App Storec审核状态
    static let isText = "IsText"
    
    /// 引导界面运行过的版本
    static let guideViewRunedVersion = "GuideViewRunedVersion"
    
    /// token信息
    static let token = "Token"
    
    /// 登录用户信息
    static let loginUserInfo = "LoginUserInfo"
    
    /// debug url
    static let debugUrlMode = "DebugUrlMode"
    
    /// debug 显示模式
    static let debugDisplayMode = "DebugDisplayMode"

    /// 记录上一次到后台的时间
    static let didEnterBackgroundTime = "didEnterBackgroundTime"
    
    
}
