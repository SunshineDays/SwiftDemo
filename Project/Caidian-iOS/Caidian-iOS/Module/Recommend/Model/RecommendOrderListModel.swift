//
//  RecommendOrderListModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/13.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐首页
class RecommendOrderListModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var matchId: Int
    
    var title: String
    
    var reason: String
    
    var playType: Int
    
    var userId: Int
    
    var hits: Int
    
    var updateTime: TimeInterval
    
    var playTypeWord: String
    
    var userInfo: RecommendUserInfoModel
    
    var matchInfo: JczqMatchModel
    
    var order: RecommendOrderModel
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        matchId = json["match_id"].intValue
        title = json["title"].stringValue
        reason = json["reason"].stringValue
        playType = json["play_Type"].intValue
        userId = json["user_id"].intValue
        hits = json["hits"].intValue
        updateTime = json["update_time"].doubleValue
        playTypeWord = json["play_type_word"].stringValue
        userInfo = RecommendUserInfoModel(json: json["user_info"])
        matchInfo = JczqMatchModel(json: json["match_info"])
        order = RecommendOrderModel(json: json["order5"])
    }
}


struct RecommendUserInfoModel {
    var json: JSON
    
    var id: Int
    
    var name: String
    
    var avatar: String
    
    init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        
        name = json["name"].stringValue
        
        avatar = json["avatar"].stringValue
    }
}

struct RecommendOrderModel {
    var json: JSON
    
    var id: Int
    
    var userId: Int
    
    var playType: Int
    
    var regionType: String
    
    var orderCount: Int
    
    var hitRate: Int
    
    var payoff: Double
    
    var payoffPercent: Double
    
    var keepWin: Int
    
    var keepLost: Int
    
    var currentKeepWin: Int
    
    var currentKeepLost: Int
    
    var win: Int
    
    var lost: Int
    
    var results: String
    
    var updateTime: TimeInterval
    
    init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        userId = json["user_id"].intValue
        playType = json["play_type"].intValue
        regionType = json["region_type"].stringValue
        orderCount = json["order_count"].intValue
        hitRate = json["hit_rate"].intValue
        payoff = json["payoff"].doubleValue
        payoffPercent = json["payoff_percent"].doubleValue
        keepWin = json["keep_win"].intValue
        keepLost = json["keep_lost"].intValue
        currentKeepWin = json["current_keep_win"].intValue
        currentKeepLost = json["current_keep_lost"].intValue
        win = json["win"].intValue
        lost = json["lost"].intValue
        results = json["results"].stringValue
        updateTime = json["update_time"].doubleValue
    }
}
