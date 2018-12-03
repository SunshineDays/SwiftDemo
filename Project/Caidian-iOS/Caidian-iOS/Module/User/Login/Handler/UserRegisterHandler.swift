//
//  UserLoginHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户注册
class UserRegisterHandler: BaseHandler {

    /// 普通注册
    func register(phone: String, authCode: String, password: String, nickname: String, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userRegisterNormal(phone: phone, authCode: authCode, password: password, nickname: nickname)
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

    /// 第三方注册
    func registerThird(phone: String, authCode: String, nickname: String, openInfo: UserOpenModel, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userRegisterThird(phone: phone, authCode: authCode, nickname: nickname, openInfo: openInfo)
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

    /// 检查手机号
    static func check(phone: String?) -> (isValid: Bool, msg: String) {
        guard let phone = phone, phone.count != 0 else {
            return (false, "请输入手机号")
            
            
        }

        let pattern = "^1\\d{10}$"
        guard let regexp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return (false, "手机号格式不正确")
        }

        let range = NSRange(location: 0, length: phone.count)
        let num = regexp.numberOfMatches(in: phone, options: .reportProgress, range: range)

        if num <= 0 {
            return (false, "手机号格式不正确")
        }
        return (true, "")
    }

    /// 检查密码
    static func check(password: String?) -> (isValid: Bool, msg: String) {
        guard let password = password, password.count != 0 else {
            return (false, "请输入密码")
        }
        if password.count < 6 || password.count > 16 {
            return (false, "密码长度必须大于6位且小于16位")
        }
        return (true, "")
    }

    /// 检查昵称
    static func check(nickname: String?) -> (isValid: Bool, msg: String) {

        guard let nickname = nickname, nickname.count != 0 else {
            return (false, "请输入昵称")
        }
        if nickname.count < 2 || nickname.count > 16 {
            return (false, "昵称为4至16个字符，支持字母、汉字、数字；一个汉字算2个字符")
        }
        return (true, "")
    }

    /// 检查银行卡
    static func check(bankCard: String?, repeatBankCard: String?) -> (isValid: Bool, msg: String) {

        guard let bankCard = bankCard, bankCard.count != 0 else {
            return (false, "请输入银行卡号")
        }

        if bankCard != repeatBankCard {
            return (false, "银行卡输入不一致")
        }
//        if bankCard.count != 15 || bankCard.count != 18 {
//            return (false, "银行卡长度输入有误")
//        }

        return (true, "")
    }


    /*
     
     * 绑定银行卡
     *
     */

    static func check(
            realName: String?,
            bankId: Int?,
            bankProvinceId: Int?,
            bankCityId: Int?,
            bankBranch: String?,
            bankCard: String?,
            bankRepeatCard: String?
    ) -> (isValid: Bool, msg: String) {

        let nameCheck = UserRegisterHandler.check(nickname: realName)
        if !nameCheck.isValid {
            return nameCheck
        }

        let bankCheck = UserRegisterHandler.check(bankCard: bankCard, repeatBankCard: bankRepeatCard)
        if !bankCheck.isValid {
            return bankCheck
        }

        if bankId == nil  {
            return (false, "银行不能为空")
        }

        if bankBranch == nil || bankBranch!.isEmpty {
            return (false, "银行支行不能为空")
        }

        if (bankProvinceId == nil || bankCityId == nil) {
            return (false, "请选择开户行")
        }

        return (true, "")
    }


}

