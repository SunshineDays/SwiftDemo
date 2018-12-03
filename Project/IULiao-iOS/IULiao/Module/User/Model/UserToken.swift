//
//  UserToken.swift
//  IULiao
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 用户免登录令牌
class UserToken: NSObject {

    static let shared = UserToken()
    
    /// 是否是在Appstore测试阶段
    var isText: Bool {
        let isText = UserDefaults.standard.bool(forKey: TSSettingKey.isText)
        return isText
    }
    
    /// 免登录 token
    var token: String? {
        guard let str = UserDefaults.standard.string(forKey: TSSettingKey.token), !str.isEmpty else {
            return nil
        }
        return str
    }
    
    /// 是否登录
    var isLogin: Bool {
        guard let token = token else {
            return false
        }
        return token.count > 0
    }
    
    /// 登录用户信息
    var userInfo: UserInfoModel? {
        guard let json = UserDefaults.standard.string(forKey: TSSettingKey.loginUserInfo) else {
            return nil
        }
        let userInfo = UserInfoModel(json: JSON(parseJSON: json))
        if isLogin && userInfo.id > 0 {
            return userInfo
        }
        return nil
    }
    
    /// 比赛提示设置
    var userNotifictionSetting: [Bool] {
        let setting = UserDefaults.standard.object(forKey: TSSettingKey.settingUserInfo)
        return (setting as? [Bool]) ?? [true, true, true, true, true, true]
    }
    
    /// 是否播放声音
    var isLivePlaySound: Bool {
        return userNotifictionSetting[0]
    }
    
    /// 是否震动
    var isLivePlayVibrate: Bool {
        return userNotifictionSetting[1]
    }
    
    /// 是否显示红牌
    var isLiveShowRed: Bool {
        return userNotifictionSetting[2]
    }
    
    /// 是否显示黄牌
    var isLiveShowYellow: Bool {
        return userNotifictionSetting[3]
    }
    
    /// 是否显示爆料信息
    var isLiveShowLiao: Bool {
        return userNotifictionSetting[4]
    }
    
    /// 是否显示赛中信息
    var isLiveShowInfo: Bool {
        return userNotifictionSetting[5]
    }
    
    private override init() {}
    
    func update(userInfo: UserInfoModel) {
        let json = userInfo.json.description
        UserDefaults.standard.set(json, forKey: TSSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 更新token
    func update(token: String) {
        UserDefaults.standard.set(token, forKey: TSSettingKey.token)
        UserDefaults.standard.synchronize()
    }

    /// 清除token
    func clear() {
        update(token: "")
        UserDefaults.standard.set(nil, forKey: TSSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 比赛提示设置
    func update(setting: [Bool]) {
        UserDefaults.standard.set(setting, forKey: TSSettingKey.settingUserInfo)
        UserDefaults.standard.synchronize()
        
    }
    
}
