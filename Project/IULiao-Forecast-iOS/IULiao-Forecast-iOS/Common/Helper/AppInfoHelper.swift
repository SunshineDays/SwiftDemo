//
//  TSAppInfoHelper.swift
//  HuaXia
//
//  Created by tianshui on 16/3/2.
// 
//

import Foundation

/// app相关的信息
class AppInfoHelper: NSObject {
    
    /// 版本号
    static let appVersion: String = {
        return Bundle.main.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as! String
    }()
    
    /// 引导图版本
    static var guideVersion: String? {
        return UserDefaults.standard.object(forKey: InfoSettingKey.guideViewRunedVersion) as? String
    }
    
    /// 是否是首次运行此版本
    static var isFirstRunningCurrentVersion: Bool {
        return appVersion != guideVersion
    }
    
}
