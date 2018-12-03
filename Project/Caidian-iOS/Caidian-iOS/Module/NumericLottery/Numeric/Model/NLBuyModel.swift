//
// Created by tianshui on 2018/5/15.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 数字彩 购买model
struct NLBuyModel: BuyModelProtocol {

    var lottery = LotteryType.none
    var play = PlayType.none
    var betCount: Int = 0
    var singleMoney: Double = 2
    var orderBuyType = OrderBuyType.normal
    var totalMoney: Double {
        return Double(betCount) * singleMoney * Double(totalMultiple)
    }

    /// 所有追号加在一起倍数
    private var totalMultiple: Int {
        return chaseList.reduce(0) { $0 + $1.multiple }
    }

    /// 追号 中奖停止
    var isHitStop = true

    /// 追号列表 最少一个元素 大于一个元素则为追号
    var chaseList = [Chase]()

    /// 投注
    var betList = [[NLBallType: Section]]()

    /// 追号
    struct Chase {
        /// 期号
        var issue: String
        /// 倍数
        var multiple: Int
    }

    /// 节
    struct Section {
        /// 球类型
        var ballType: NLBallType
        /// 普通球 与胆球互斥
        var normalBallList: [NLBallKey]
        /// 胆球
        var mustBallList: [NLBallKey]
    }
}

extension NLBuyModel {
    var toJsonString: String {
        return ""
    }
}