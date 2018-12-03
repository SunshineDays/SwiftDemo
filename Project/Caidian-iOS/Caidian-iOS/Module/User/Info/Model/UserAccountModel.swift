//
// Created by tianshui on 2018/4/29.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户账号信息
struct UserAccountModel: BaseModelProtocol {
    var json: JSON

    var userId: Int

    /// 现金
    var balance: Double

    /// 彩金
    var reward: Double

    /// 总中奖金额
    var bonus: Double

    /// 充值金额
    var recharge: Double

    /// 现金消费
    var balanceCost: Double

    /// 彩金消费
    var rewardCost: Double

    init(json: JSON) {
        self.json = json
        userId = json["user_id"].intValue
        balance = json["balance"].doubleValue
        reward = json["reward"].doubleValue
        bonus = json["bonus"].doubleValue
        recharge = json["recharge"].doubleValue
        balanceCost = json["balance_cost"].doubleValue
        rewardCost = json["reward_cost"].doubleValue
    }
}
