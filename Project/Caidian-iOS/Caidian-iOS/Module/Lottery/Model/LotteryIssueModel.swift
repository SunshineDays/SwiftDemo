//
// Created by tianshui on 2018/5/14.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 期号
struct LotteryIssueModel: BaseModelProtocol {
    var json: JSON

    var id: Int
    var lottery: LotteryType
    var name: String

    /// 销售截止时间
    var saleEndTime: TimeInterval

    /// 单关截止时间
    var singleEndTime: TimeInterval

    /// 串关截止时间
    var multipleEndTime: TimeInterval

    /// 当前期
    var isCurrent: Bool

    /// 开奖号
    var openCode: String

    init(json: JSON) {
        self.json = json

        id = json["id"].intValue
        lottery = LotteryType(rawValue: json["lottery_id"].intValue) ?? .none
        name = json["name"].stringValue
        saleEndTime = json["sale_end_time"].doubleValue
        singleEndTime = json["single_end_time"].doubleValue
        multipleEndTime = json["multiple_end_time"].doubleValue
        isCurrent = json["is_current"].boolValue
        openCode = json["open_code"].stringValue
    }
}
