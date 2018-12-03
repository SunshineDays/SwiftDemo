//
//  PlanOrderBigPlanModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 大计划
class PlanOrderBigPlanModel: BaseModelProtocol {
    var json: JSON
    /// plan id
    var planID: Int
    /// 计划名
    var title: String
    /// 作者名
    var author: String
    /// 计划头像
    var avatar: String
    
    var genre: Int
    /// 类型
    var genreName: String
    
    /// 计划总中奖
    var totalBonus: Double
    /// 参与人次
    var followUser: Int
    /// 跟单金额
    var followMoney: Double
    
    var detailCount: Int
    
    var createTime: TimeInterval
    
    var updateTime: TimeInterval
    /// 是否可以投注
    var canBet: Bool
    /// 登录用户购买信息
    var buyModel: PlanOrderUserBuyModel
    
    
    required init(json: JSON) {
        self.json = json
        
        planID = json["id"].intValue
        title = json["title"].stringValue
        author = json["author"].stringValue
        avatar = json["avatar"].stringValue
        genre = json["genre"].intValue
        genreName = json["genre_name"].stringValue
        totalBonus = json["total_bonus"].doubleValue
        followUser = json["follow_user"].intValue
        followMoney = json["follow_money"].doubleValue
        detailCount = json["detail_count"].intValue
        createTime = TimeInterval(json["create_time"].intValue)
        updateTime = TimeInterval(json["update_time"].intValue)
        canBet = json["can_bet"].intValue != 0
        buyModel = PlanOrderUserBuyModel(json: json["buy_list"])
    }
}

/// 用户购买的计划信息
class PlanOrderUserBuyModel: BaseModelProtocol {
    var json: JSON
    /// 购买次数
    var buyCount: Int
    /// 奖金
    var bonus: Double
    /// planID
    var planID: Int
    
    required init(json: JSON) {
        self.json = json
        buyCount = json["buy_count"].intValue
        bonus = json["bonus"].doubleValue
        planID = json["plan_id"].intValue
    }
}
