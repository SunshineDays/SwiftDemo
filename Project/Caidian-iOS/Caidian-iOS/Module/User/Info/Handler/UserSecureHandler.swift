//
// Created by tianshui on 2017/6/28.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户安全
class UserSecureHandler: BaseHandler {

    /// 找回密码
    func getPassword(phone: String, authCode: String, password: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userGetPassword(phone: phone, authCode: authCode, password: password)
        defaultRequestManager.request(
            router: router,
                expires: 0,
                success: {
                    (json) in
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

    /// 修改密码
    func changePassword(phone: String, authCode: String, password: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userChangePassword(phone: phone, authCode: authCode, password: password)
        defaultRequestManager.request(
            router: router,
                expires: 0,
                success: {
                    (json) in
                    let userInfo = UserInfoModel(json: json)
                    success(userInfo)
                    
                    UserToken.shared.update(userInfo: userInfo)
                    UserToken.shared.update(token: json["token"].stringValue)
                    
                    NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return true
                })
    }

    /// 修改手机
    func changePhone(phone: String, authCode: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userChangePhone(phone: phone, authCode: authCode)
        defaultRequestManager.request(
            router: router,
                expires: 0,
                success: {
                    (json) in
                    let userInfo = UserInfoModel(json: json)
                    success(userInfo)
                    
                    UserToken.shared.update(userInfo: userInfo)
                    UserToken.shared.update(token: json["token"].stringValue)
                    
                    NotificationCenter.default.post(name: TSNotification.userLoginSuccessful.notification, object: self)
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return true
                })
    }


}
