//
//  UserPlanOrderBigPlanListModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 我的计划单
class UserPlanOrderBigPlanListModel: BaseModelProtocol {
    var json: JSON
    
    var planModel: PlanOrderBigPlanModel
    
    var statisticModel: PlanOrderUserBuyModel
    
    required init(json: JSON) {
        self.json = json
        
        planModel = PlanOrderBigPlanModel(json: json["plan"])
        statisticModel = PlanOrderUserBuyModel(json: json["statistic"])
    }
    
}

