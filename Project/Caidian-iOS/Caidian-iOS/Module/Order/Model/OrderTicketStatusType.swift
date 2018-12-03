//
// Created by tianshui on 2018/4/30.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 订单出票状态
enum OrderTicketStatusType: Int {

    /// 未出票
    case none = 0
    /// 出票中
    case inProcess = 1
    /// 出票成功
    case success = 2
    /// 出票失败
    case failed = 3

    var name: String {
        switch self {
        case .none: return "未出票"
        case .inProcess: return "出票中"
        case .success: return "出票成功"
        case .failed: return "出票失败"
        }
    }
}
