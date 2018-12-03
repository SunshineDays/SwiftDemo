//
//  TSNotificationHelper.swift
//  HuaXia
//
//  Created by tianshui on 16/3/10.
// 
//

import Foundation
import UIKit

/// 推送
class TSNotificationHelper: NSObject {
    
    var userInfo: [AnyHashable: Any]
    
    /// 是否是通过 didFinishLaunchingWithOptions方法
    var isLaunched: Bool {
        if let b = userInfo["_is_launched"] as? Bool {
            return b
        }
        return false
    }
    
    /// app获得通知时的状态
    var applicationState: UIApplicationState {
        if let i = userInfo["_application_state"] as? Int {
            return UIApplicationState(rawValue: i) ?? .active        }
        return .active
    }
    
    /// 通知类型
    var target: String? {
        return userInfo["target"] as? String
    }
    
    /// id
    var targetID: Int? {
        if let i = userInfo["targetid"] as? Int {
            return i
        }
        if let s = userInfo["targetid"] as? String {
            return Int(s)
        }
        return nil
    }
    
    /// 原始链接
    var sourceURL: String? {
        if let s = userInfo["url"] as? String {
            return s
        }
        return nil
    }
    
    /// 对应appUrl
    var appURL: String? {
        if target != nil && targetID != nil {
            return "\(target!)://\(targetID!)"
        }
        return nil
    }
    
    /// 消息内容
    var alertMessage: String {
        let aps = userInfo["aps"] as? [AnyHashable: Any]
        let alert = aps?["alert"] as? String
        return alert ?? ""
    }
    
    init(apnsUserInfo: [AnyHashable: Any]) {
        self.userInfo = apnsUserInfo
        super.init()
    }
    
}
