//
//  UserPlanOrderListModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

import SwiftyJSON

class UserPlanOrderListModel: BaseModelProtocol {
    var json: JSON
    
    var buy: PlanOrderFollowAccountModel
    
    var detail: PlanOrderDetailModel
    
    var plan: PlanModel
    
    required init(json: JSON) {
        self.json = json
        buy = PlanOrderFollowAccountModel(json: json["buy"])
        detail = PlanOrderDetailModel(json: json["detail"])
        plan = PlanModel(json: json["plan"])
    }
    
}

/// 计划单用户购买信息
class UserPlanOrderTotalMoneyModel: BaseModelProtocol {
    var json: JSON
    
    var totalBuyMoney: Double
    
    var totalBonus: Double
    
    required init(json: JSON) {
        self.json = json
        totalBuyMoney = json["total_buy_money"].doubleValue
        totalBonus = json["total_bonus"].doubleValue
    }
    
}
