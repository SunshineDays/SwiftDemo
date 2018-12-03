//
//  PlanOrderDetailModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PlanOrderDetailModel : BaseModelProtocol {
    
    
    var  json :JSON
    
    // 计划详情id
    var  id:Int
    
    //计划id
    var planId :Int
    
    //标题
    var title:String
    
    // 彩种
    var lotteryId :Int
    
    // 跟单人数
    var followUser :Int
    
    // 跟单金额
    var followMoney :Int
    
    /// 奖金
    var bonus :Double
    
    /// sp
    var sp: String
    
    ///陪送奖金
    var sendPrize :Double
    
    ///截止时间
    var saleEndTime : TimeInterval
    
    /// 票
    var ticketImgs : [String]
    
    ///状态
    var winStatus : OrderWinStatusType

    /// 描述
    var remark :String?

    /// 彩种民称
    var lotteryName :String

    ///
    var createTime :TimeInterval

    var updateTime :TimeInterval
    
    
    ///购买情况
    var  buyList : [PlanOrderFollowAccountModel]


    init(json :JSON){
        self.json = json

        self.id = json["id"].intValue
        self.planId = json["plan_id"].intValue
        self.lotteryId = json["lottery_id"].intValue
        self.title = json["title"].stringValue
        self.bonus = json["bonus"].doubleValue
        self.sp = json["sp"].stringValue
        self.followUser = json["follow_user"].intValue
        self.followMoney = json["follow_money"].intValue
        self.sendPrize = json["send_prize"].doubleValue
        self.saleEndTime = json["sale_end_time"].doubleValue
        self.remark = json["remark"].stringValue
        self.ticketImgs =  json["ticket_imgs"].arrayValue.map{
           return $0.stringValue
        }
        self.lotteryName = json["lottery_name"].stringValue
        self.createTime = json["create_time"].doubleValue
        self.updateTime = json["update_time"].doubleValue
        self.winStatus = OrderWinStatusType(rawValue: json["win_status"].intValue) ?? .notOpen
        self.buyList = json["buy_list"].arrayValue.map{ return PlanOrderFollowAccountModel(json: $0)}
    }
}
