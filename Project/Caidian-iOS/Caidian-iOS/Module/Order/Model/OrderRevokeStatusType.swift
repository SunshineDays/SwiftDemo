//
// Created by tianshui on 2018/4/30.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 订单撤单状态
enum OrderRevokeStatusType: Int {

    /// 正常 未撤单
    case normal = 0
    /// 发起人撤单
    case userRevoke = 1
    /// 系统撤单
    case systemRevoke = 2

    var name: String {
        switch self {
        case .normal: return "未撤单"
        case .userRevoke: return "发起人撤单"
        case .systemRevoke: return "系统撤单"
        }
    }
}
