//
//  UserToken.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户免登录令牌
class UserToken: NSObject {

    static let shared = UserToken()
    
    /// 免登录 token
    var token: String? {
        guard let str = UserDefaults.standard.string(forKey: InfoSettingKey.token), !str.isEmpty else {
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
        guard let json = UserDefaults.standard.string(forKey: InfoSettingKey.loginUserInfo) else {
            return nil
        }
        let userInfo = UserInfoModel(json: JSON(parseJSON: json))
        if isLogin && userInfo.id > 0 {
            return userInfo
        }
        return nil
    }
    
    private override init() {}
    
    func update(userInfo: UserInfoModel) {
        let json = userInfo.json.description
        UserDefaults.standard.set(json, forKey: InfoSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 更新token
    func update(token: String) {
        UserDefaults.standard.set(token, forKey: InfoSettingKey.token)
        UserDefaults.standard.synchronize()
    }

    /// 清除token
    func clear() {
        update(token: "")
        UserDefaults.standard.set(nil, forKey: InfoSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
}
