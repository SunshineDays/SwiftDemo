//
//  UserOpenModel.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation


/// 第三方登录用户信息
struct UserOpenModel {
    
    var thirdType: UserThirdLoginType
    
    var openID: String
    
    /// 昵称
    var nickname: String
    
    /// 性别
    var gender: UserGenderType
    
    /// 头像 url
    var avatarUrl: String?
    
    var accessToken: String
    
    var refreshToken: String?
    
    var expiration: String
    
    init(userInfo: UMSocialUserInfoResponse) {
        
        switch userInfo.platformType {
        case .QQ:
            thirdType = .qq
        case .wechatSession:
            thirdType = .wechat
        case .sina:
            thirdType = .weibo
        default:
            thirdType = .none
        }
        
        
        if thirdType == .qq {
            openID = userInfo.unionId
        } else {
            openID = userInfo.uid
        }
        
        nickname = userInfo.name ?? ""
        gender = UserGenderType(description: userInfo.unionGender ?? "")
        avatarUrl = userInfo.iconurl
        accessToken = userInfo.accessToken ?? ""
        refreshToken = userInfo.refreshToken
        expiration = "\(Int(userInfo.expiration?.timeIntervalSince1970 ?? 0))"
    }
}
