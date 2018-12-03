//
//  OrderBuyType.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 订单购买类型
enum OrderBuyType: Int {
    
    /// 自购
    case normal = 0
    
    /// 发单
    case sponsor = 1
    
    /// 复制跟单
    case copy = 2
    
    /// 追号OrderBuyType
    case chase = 3
    
    /// 合买
    case together = 4

    /// 全部
    case all = -1
    
    var name: String {
        switch self {
        case .normal: return "自购"
        case .sponsor: return "发单"
        case .copy: return "跟单"
        case .chase: return "追号"
        case .together: return "合买"
        case .all: return "全部"
        }
    }
    static let allTabs: [OrderBuyType] = [.all, .normal, .sponsor, .copy]
}

extension OrderBuyType: CustomStringConvertible {
    var description: String {
        return name
    }

}
