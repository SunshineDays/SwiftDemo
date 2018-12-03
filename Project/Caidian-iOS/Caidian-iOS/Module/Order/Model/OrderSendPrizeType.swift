//
// Created by tianshui on 2018/4/30.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 订单派奖情况
enum OrderSendPrizeType: Int {
    
    /// 未派奖
    case notSend = 0
    
    /// 已派奖
    case alreadySend = 1

    var name: String {
        switch self {
            case .notSend: return "未派奖"
            case .alreadySend: return "已派奖"
        }
    }
}
