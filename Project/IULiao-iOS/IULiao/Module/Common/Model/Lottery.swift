//
//  Lottery.swift
//  IULiao
//
//  Created by tianshui on 16/7/21.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 彩种
enum Lottery: String {
    
    /// 北单
    case beidan = "beidan"
    /// 竞彩
    case jingcai = "jingcai"
    /// 胜负彩
    case sfc = "sfc"
    /// 六场进球
    case lcbq = "lcbq"
    /// 四场半全
    case scjq = "scjq"
    /// 全比分
    case all = ""
    
    /// 彩种id
    var lotyid: Int {
        switch self {
        case .beidan: return 5
        case .jingcai: return 6
        case .sfc: return 1
        case .lcbq: return 4
        case .scjq: return 3
        case .all: return 0
        }
    }
    
    /// 中文名
    var name: String {
        switch self {
        case .beidan: return "北京单场"
        case .jingcai: return "竞彩足球"
        case .sfc: return "胜负彩"
        case .lcbq: return "六场半全"
        case .scjq: return "四场进球"
        case .all: return "全部赛事"
        }
    }
    
    init(lotyid: Int) {
        switch lotyid {
        case 1: self = .sfc
        case 3: self = .scjq
        case 4: self = .lcbq
        case 5: self = .beidan
        case 6: self = .jingcai
        default: self = .all
        }
    }

}

extension Lottery: CustomStringConvertible {
    var description: String {
        return "\(self.rawValue) lotyid=\(self.lotyid)"
    }
}
