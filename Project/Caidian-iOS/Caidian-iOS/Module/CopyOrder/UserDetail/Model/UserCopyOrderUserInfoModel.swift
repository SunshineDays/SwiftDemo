//
//  UserCopyOrderUserInfoModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 复制跟单 发单人信息
class UserCopyOrderUserInfoModel: BaseModelProtocol {
    var json: JSON
    
    var user: UserModel
    var rankAll: RankAllModele
    
    required init(json: JSON) {
        self.json = json
        user = UserModel(json: json["user"])
        rankAll = RankAllModele(json: json["rank_all"])
    }
    
    
    struct UserModel: BaseModelProtocol {
        var json: JSON
        
        var id: Int
        var nickname: String
        var avatar: String
        
        init(json: JSON) {
            self.json = json
            id = json["id"].intValue
            nickname = json["nickname"].stringValue
            avatar = json["avatar"].stringValue
        }
    }
    
    struct RankAllModele: BaseModelProtocol {
        var json: JSON
        
        var id: Int
        var userId: Int
        
        var region: String
        var orderCount: Int
        var win: Int
        var lost: Int
        
        var copyCount: Int
        var copyMoney: Double
        var copyBonus: Double
        var selfBonus: Double
        
        var totalBonus: Double
        
        var results: String
        var updateTime: TimeInterval
        
        init(json: JSON) {
            self.json = json
            
            id = json["id"].intValue
            userId = json["user_id"].intValue
            
            region = json["region"].stringValue
            orderCount = json["order_count"].intValue
            win = json["win"].intValue
            lost = json["lost"].intValue
            
            copyCount = json["copy_count"].intValue
            copyMoney = json["copy_money"].doubleValue
            copyBonus = json["copy_bonus"].doubleValue
            selfBonus = json["self_bonus"].doubleValue
            
            totalBonus = json["total_bonus"].doubleValue
            
            results = json["results"].stringValue
            updateTime = TimeInterval(json["update_time"].intValue)
        }
    }
    
    
}

