//
// Created by tianshui on 2018/5/2.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 订单
struct OrderModel: BaseModelProtocol {
    var json: JSON

    var id: Int
    var userId: Int
    
    ///发单用户
    var nickName :String

    /// 编号
    var orderNum: String
    /// 彩种
    var lottery: LotteryType
    /// 玩法
    var play: PlayType
    /// 期号
    var issue: String
    /// 订单类型
    var orderBuyType: OrderBuyType
    /// 倍数
    var multiple: Int
    /// 注数
    var betCount: Int
    /// 总金额
    var totalMoney: Double
    /// 单注金额
    var singleMoney: Double
    /// 串关方式
    var serialList: [SLSerialType]
    /// 出票状态
    var ticketStatus: OrderTicketStatusType
    /// 撤单状态
    var revokeStatus: OrderRevokeStatusType
    /// 中奖状态
    var winStatus: OrderWinStatusType
    /// 奖金派发状态
    var sendPrize: OrderSendPrizeType

    /// 是否可见
    var isSecret :Int
    /// 奖金
    var bonus: Double
    /// 毛利润
    var margin: Double
    /// 创建时间
    var createTime: TimeInterval

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userId = json["user_id"].intValue
        nickName = json["nickname"].stringValue
        orderNum = json["order_num"].stringValue
        lottery = LotteryType(rawValue: json["lottery_id"].intValue) ?? .jczq
        play = PlayType(rawValue: json["play_id"].intValue) ?? .none
        issue = json["issue"].stringValue
        orderBuyType = OrderBuyType(rawValue: json["order_type"].intValue) ?? .normal
        multiple = json["multiple"].intValue
        betCount = json["bet_count"].intValue
        totalMoney = json["total_money"].doubleValue
        singleMoney = json["single_money"].doubleValue
        serialList = json["series"].stringValue.split(separator: ",").compactMap { SLSerialType(rawValue: String($0)) }
        bonus = json["bonus"].doubleValue
        margin = json["margin"].doubleValue
        createTime = json["create_time"].doubleValue
        isSecret = json["is_secret"].intValue

        ticketStatus = OrderTicketStatusType(rawValue: json["ticket_status"].intValue) ?? .none
        revokeStatus = OrderRevokeStatusType(rawValue: json["revoke_status"].intValue) ?? .normal
        winStatus = OrderWinStatusType(rawValue: json["win_status"].intValue) ?? .notOpen
        sendPrize = OrderSendPrizeType(rawValue: json["send_prize"].intValue) ?? .notSend
    }

}
