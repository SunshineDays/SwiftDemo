//
//  PlanOrderAuthorOrderModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class PlanOrderAuthorOrderModel: BaseModelProtocol {
    var json: JSON
    
    var detailID: Int
    
    ///  奖金
    var analogBonus: Double
    
    /// 投注金额
    var analogMoney: Double
    
    /// 日期
    var saleEndTime: TimeInterval
    
    /// 中奖状态
    var winStatus: OrderWinStatusType
    
    required init(json: JSON) {
        self.json = json
        
        detailID = json["detail_id"].intValue
        
        analogBonus = json["analog_bonus"].doubleValue
        analogMoney = json["analog_money"].doubleValue
        saleEndTime = TimeInterval(json["sale_end_time"].intValue)
        winStatus = OrderWinStatusType(rawValue: json["win_status"].intValue) ?? .notOpen
    }
}
