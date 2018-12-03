//
//  UserThirdLoginType.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 第三方登录类型
enum UserThirdLoginType: Int, CustomStringConvertible {
    
    /// 微信
    case wechat = 1
    
    /// qq
    case qq = 2
    
    /// 微博
    case weibo = 3
    
    /// 其他
    case none = 0
    
    init(rawValue: Int) {
        switch rawValue {
        case 1: self = .wechat
        case 2: self = .qq
        case 3: self = .weibo
        default: self = .none
        }
    }
    /*
    init(umSocialPlatformType: UMSocialPlatformType) {
        switch umSocialPlatformType {
        case .QQ, .qzone:
            self = .qq
        case .wechatSession, .wechatFavorite, .wechatTimeLine:
            self = .wechat
        case .sina:
            self = .weibo
        default:
            self = .none
        }
    }
    
    var umSocialPlatformType: UMSocialPlatformType {
        switch self {
        case .qq:
            return .QQ
        case .wechat:
            return .wechatSession
        case .weibo:
            return .sina
        default:
            return .unKnown
        }
    }
 */
    
    var description: String {
        switch self {
        case .qq:
            return "QQ"
        case .wechat:
            return "微信"
        case .weibo:
            return "微博"
        default:
            return "未知"
        }
    }
}
