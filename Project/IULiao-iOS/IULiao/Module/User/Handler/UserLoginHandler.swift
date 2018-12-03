//
//  UserLoginHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户登录
class UserLoginHandler: BaseHandler {
    
    /// 用户三方登录的信息
    static var userOpenInfo: UserOpenModel?
    
    /// 登录 手机 + 密码
    func login(phone: String, password: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.userLoginPassword(phone: phone, password: password)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                self.login_success(json: json, success: success)
                let userInfo = UserInfoModel(json: json)
                success(userInfo)
                
                UserToken.shared.update(userInfo: userInfo)
                UserToken.shared.update(token: json["token"].stringValue)
                
                NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }
    
    /// 登录 手机 + 验证码
    func login(phone: String, authCode: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.userLoginAuthCode(phone: phone, authCode: authCode)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                self.login_success(json: json, success: success)
                let userInfo = UserInfoModel(json: json)
                success(userInfo)
                
                UserToken.shared.update(userInfo: userInfo)
                UserToken.shared.update(token: json["token"].stringValue)
                
                NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

    /// 第三方登录
    func loginThird(openInfo: UserOpenModel, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.userLoginThird(openInfo: openInfo)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                self.login_success(json: json, success: success)
                let userInfo = UserInfoModel(json: json)
                success(userInfo)
                
                UserToken.shared.update(userInfo: userInfo)
                UserToken.shared.update(token: json["token"].stringValue)
                
                NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }
    
    /// 登录成功
    private func login_success(json: JSON, success: @escaping ((UserInfoModel) -> Void)) {
        
        let userInfo = UserInfoModel(json: json)
        success(userInfo)
        
        UserToken.shared.update(userInfo: userInfo)
        UserToken.shared.update(token: json["token"].stringValue)
        // 注册极光别名
        let seq = random(min: 10_000_000, max: 99_999_999)
        JPUSHService.setAlias("\(userInfo.id)", completion: {
            (iResCode, iAlias, seq) in
            log.info("注册别名成功")
        }, seq: seq)
        NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
    }
    
    /// 退出登录
    func logout(success: @escaping (() -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.userLogout
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                
                /// 删除极光别名
                let seq = random(min: 10_000_000, max: 99_999_999)
                JPUSHService.deleteAlias({
                    (iResCode, iAlias, seq) in
                    log.info("删除别名成功")
                }, seq: seq)
                
                UserToken.shared.clear()
                success()
                
                NotificationCenter.default.post(name: TSNotification.userLogoutSuccessful.notification, object: self)
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

}

