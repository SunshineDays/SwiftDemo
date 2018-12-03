//
//  UserInfoModel.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

class UserInfoTotalModel: BaseModelProtocol {
    var json: JSON
    
    var user: UserInfoModel
    
    var account: UserAccountModel
    
    required init(json: JSON) {
        self.json = json
        user = UserInfoModel(json: json["user"])
        account = UserAccountModel(json: json["account"])
    }
}

/// 用户信息
class UserInfoModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 用户id
    var id: Int
    
    /// 昵称
    var nickname: String
    
    /// 手机
    var phone: String
    
    /// 中间加 * 号的手机号
    var secretPhone: String {
        return phone[0..<3] + "****" + phone[7..<11]
    }
    
    /// 性别
    var gender: UserGenderType
    
    /// 头像
    var avatar: String?
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        nickname = json["nickname"].stringValue
        phone = json["phone"].stringValue
        gender = UserGenderType(rawValue: json["gender"].intValue) ?? .none
        avatar = json["avatar"].stringValue
    }
    
    struct UserModel: BaseModelProtocol {
        var json: JSON
        
        init(json: JSON) {
            self.json = json
        }
    }
}

/// 用户账户信息
class UserAccountModel: BaseModelProtocol {
    var json: JSON
    
    var userId: Int
    /// 料豆数量
    var coin: Int
    /// 料豆总消费
    var cost: Int
    /// 充值总金额
    var recharge: Double
    
    required init(json: JSON) {
        self.json = json
        userId = json["user_id"].intValue
        coin = json["coin"].intValue
        recharge = json["recharge"].doubleValue
        cost = json["cost"].intValue
    }
}

/// 用户性别
enum UserGenderType: Int, CustomStringConvertible{
    
    case male = 1
    
    case female = 2
    
    case none = 0
    
    var description: String {
        switch self {
        case .male: return "男"
        case .female: return "女"
        default: return "保密"
        }
    }
    
    init(description: String) {
        switch description {
        case "男":
            self = .male
        case "女":
            self = .female
        default:
            self = .none
        }
    }
}
