//
// Created by levine on 2018/5/17.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 复制跟单
struct CopyOrderModel: BaseModelProtocol {
    var json: JSON

    var userName: String

    var userAvatar: String

    var id: Int

    var userId: Int

    var endTime: TimeInterval

    /// 跟单人数
    var follow: Int

    /// 回报率
    var rate: Double

    /// 跟单金额
    var followMoney: Double

    /// 近7天统计
    var weekStatistics: WeekStatisticsModel

    /// 总金额
    var totalMoney: Double

    /// 订单id
    var orderId: Int

    /// 单倍金额
    var oneMoney:Double

    init(json: JSON) {
        self.json = json
        self.id = json["id"].intValue
        self.userId = json["user_id"].intValue
        self.userName = json["user_name"].stringValue
        self.userAvatar = json["user_avatar"].stringValue
        self.follow = json["follow"].intValue
        self.rate = json["rate"].doubleValue
        self.followMoney = json["follow_money"].doubleValue
        self.endTime = json["end_time"].doubleValue
        self.weekStatistics = WeekStatisticsModel(json: json["week_statistics"])
        self.totalMoney = json["total_money"].doubleValue
        self.orderId = json["order_id"].intValue
        self.oneMoney = json["one_money"].doubleValue

    }

    struct WeekStatisticsModel: BaseModelProtocol {
        var json: JSON

        /// 发单数
        var orderCount: Int

        /// 命中数
        var winCount: Int

        init(json: JSON) {
            self.json = json
            self.orderCount = json["nums"].intValue
            self.winCount = json["winnums"].intValue
        }
    }
}
