//
// Created by levine on 2018/5/4.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 金额类型
enum MoneyType: Int {
    /// 余额
    case balance = 1
    /// 彩金
    case reward = 2
    /// 默认
    case none = 0

    var name: String {
        switch self {
        case .balance: return "余额"
        case .reward:return "彩金"
        case .none:return "默认"
        }
    }
}
