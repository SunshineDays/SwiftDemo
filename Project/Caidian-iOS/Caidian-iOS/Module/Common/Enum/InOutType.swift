//
// Created by levine on 2018/5/4.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 资金交易类型
enum InOutType: Int {

    /// 收入
    case tradeIn = 1

    /// 支出
    case tradeOut = -1

    /// 默认
    case none = 0

    var name: String {
        switch self {
        case .tradeIn: return "收入"
        case .tradeOut: return "支出"
        case .none:return "默认"
        }
    }

}

