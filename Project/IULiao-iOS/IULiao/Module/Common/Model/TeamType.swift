//
//  TeamType.swift
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 球队类型
enum TeamType: String {
    
    /// 主队
    case home
    
    /// 客队
    case away
    
    case none
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
        case "home":
            self = .home
        case "away":
            self = .away
        default:
            self = .none
        }
    }
    
}

extension TeamType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .home:
            return "主队"
        case .away:
            return "客队"
        default:
            return ""
        }
    }
}
