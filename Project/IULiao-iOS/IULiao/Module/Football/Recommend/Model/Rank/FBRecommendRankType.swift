//
//  FBRecommendRankType.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/3.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

enum RecommendRegionType: String {
    
    case all = "all"
    
    case day7 = "day7"
    
    case day30 = "day30"
    
    case order10 = "order10"
    
    var message: String {
        switch self {
        case .all: return "全部"
        case .day7: return "近7天"
        case .day30: return "近30天"
        case .order10: return "近10单"
        }
    }
    
    
}

enum RecommendRankType: String {
    /// 连红榜
    case keepWin = "keepwin"
    /// 明灯榜
    case keepLost = "keeplost"
    /// 新锐榜
    case newBest = "newbest"
    /// 盈利榜
    case payoff = "payoff"
    /// 胜率榜
    case hitPercent = "hitpercent"
    
    var message: String {
        switch self {
        case .keepWin: return "连红榜"
        case .keepLost: return "明灯榜"
        case .newBest: return "新锐榜"
        case .payoff: return "盈利榜"
        case .hitPercent: return "胜率榜"
        }
    }
    
    var show: String {
        switch self {
        case .keepWin: return "最长连红"
        case .keepLost: return "最长连黑"
        case .newBest: return "新锐榜"
        case .payoff: return "盈利率"
        case .hitPercent: return "胜率"
        }
    }
    
    var jingcaiMessage: String {
        switch self {
            case .payoff: return "盈利榜"
            case .hitPercent: return "命中榜"
            default: return ""
        }
    }
    
    var jingcaiShow: String {
        switch self {
        case .payoff: return "盈利率"
        case .hitPercent: return "命中率"
        default: return ""
        }
    }
    
}


enum RecommendBunchType: String {
    /// 单关
    case single = "single"
    /// 2串1
    case serial = "serial"
    
    var message: String {
        switch self {
        case .single: return "单关"
        case .serial: return "2串1"
        }
    }
}

