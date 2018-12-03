//
//  UserSMSHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 短信
class UserSMSHandler: BaseHandler {
    
    /// 发送验证码
    func sendCode(phone: String, smsType: UserSMSType, success: @escaping ((_ phone: String, _ alreadyRegister: Bool, _ authCode: String) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.commonSMSSendCode(phone: phone, smsType: smsType)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                
                let isRegister = json["isuser"].intValue != 0
                success(json["phone"].stringValue, isRegister, json["code"].string ?? "")
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return true
        })
    }
    
    /// 校验验证码
    func checkCode(phone: String, authCode: String, smsType: UserSMSType, success: @escaping ((_ phone: String, _ alreadyRegister: Bool, _ smsType: UserSMSType) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.commonSMSCheckCode(phone: phone, authCode: authCode, smsType: smsType)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) in
                
                let smsType = UserSMSType(rawValue: json["type"].intValue) ?? .none
                let isRegister = json["isuser"].intValue != 0
                success(json["phone"].stringValue, isRegister, smsType)
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return true
        })
    }
    
}
