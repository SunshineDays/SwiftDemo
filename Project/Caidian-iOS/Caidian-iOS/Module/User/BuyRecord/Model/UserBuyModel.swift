//
// Created by tianshui on 2018/4/30.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户认购
struct UserBuyModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    var userId: Int
    /// 订单id
    var orderId: Int
    /// 购买注数
    var buyCount: Int
    /// 总金额 包含彩金
    var buyMoney: Double
    /// 购买时间
    var buyTime: TimeInterval
    /// 购买类型
    var buyType: OrderBuyType
    /// 奖金
    var bonus: Double
    /// 奖金派送
    var sendPrize: OrderSendPrizeType
    /// 撤单状态
    var revokeStatus: OrderRevokeStatusType
    /// 彩金消费
    var rewardMoney: Double

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userId = json["user_id"].intValue
        orderId = json["order_id"].intValue
        buyCount = json["buy_count"].intValue
        buyMoney = json["buy_money"].doubleValue
        buyTime = json["buy_time"].doubleValue
        buyType = OrderBuyType(rawValue: json["buy_type"].intValue) ?? .normal
        bonus = json["bonus"].doubleValue
        sendPrize = OrderSendPrizeType(rawValue: json["send_prize"].intValue) ?? .notSend
        revokeStatus = OrderRevokeStatusType(rawValue: json["revoke_status"].intValue) ?? .normal
        rewardMoney = json["reward_money"].doubleValue
    }
}
