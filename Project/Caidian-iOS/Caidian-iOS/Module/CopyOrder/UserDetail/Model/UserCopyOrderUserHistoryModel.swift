//
//  UserCopyOrderUserHistoryModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 复制跟单 用户历史记录
class UserCopyOrderUserHistoryModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var orderId: Int
    var userId: Int
    
    var userName: String
    var userAvatar: String
    
    var createTime: TimeInterval
    var endTime: TimeInterval
    
    var rate: Double
    var totalMoney: Double
    var oneMoney: Double
    
    var follow: Int
    var followMoney: Double
    var bonus: Double
    
    var reason: String
    var weekStatistics: WeekStatisticsModel
    
    var winStatus : OrderWinStatusType
    
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        
        orderId = json["order_id"].intValue
        userId = json["user_id"].intValue
        
        userName = json["user_name"].stringValue
        userAvatar = json["user_avatar"].stringValue
        
        createTime = TimeInterval(json["create_time"].intValue)
        endTime = TimeInterval(json["end_time"].intValue)
        
        rate = json["rate"].doubleValue
        totalMoney = json["total_money"].doubleValue
        oneMoney = json["one_money"].doubleValue
        
        follow = json["follow"].intValue
        followMoney = json["follow_money"].doubleValue
        bonus = json["bonus"].doubleValue
        
        reason = json["reason"].stringValue
        weekStatistics = WeekStatisticsModel(json: json["week_statistics"])
        
        winStatus = OrderWinStatusType(rawValue: json["win_status"].intValue) ?? .notOpen

    }
    
    struct WeekStatisticsModel: BaseModelProtocol {
        var json: JSON
        
        var nums: Int
        
        var winNums: Int
        
        init(json: JSON) {
            self.json = json
            
            nums = json["nums"].intValue
            winNums = json["winnums"].intValue
        }
        
    }
}
