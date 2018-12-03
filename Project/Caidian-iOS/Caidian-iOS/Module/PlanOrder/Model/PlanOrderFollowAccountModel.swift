//
//  PlanOrderFollowAccountModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON


struct PlanOrderFollowAccountModel :BaseModelProtocol {
    
    
    /// 购买金额
    var buyMoney : Int
    
    ///奖金
    var bonus :Double
    
    ///配送金额
    var sendPrize :Double
    
    ///跟单用户
    var nickName : String
    
    /// 计划单Id
    var planDetailId :Int
    
    //计划id
    var planId :Int
    
    ///用户Id
    var userId :Int
    
    /// 订单号
    var orderNum :String
    
    /// 跟单时间
    var createdTime: TimeInterval
    
    var json: JSON
    
    
    init(json:JSON) {
        self.json = json
        self.buyMoney      = json["buy_money"].intValue
        self.nickName      = json["nickname"].stringValue
        self.createdTime   = json["create_time"].doubleValue
        self.userId        = json["user_id"].intValue
        self.orderNum      = json["order_num"].stringValue
        self.planId        = json["plan_id"].intValue
        self.sendPrize     = json["send_prize"].doubleValue
        self.bonus         = json["bonus"].doubleValue
        self.planDetailId  = json["plan_detail_id"].intValue
    }
    
    
}
