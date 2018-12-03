//
//  FBRecommendDdetailOddsType.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/8.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/**  赔率类型 */
enum RecommendDetailOddsType: Int {
    
    /// 全部
    case all = 0
    
    case competeNotLetBall = 1
    
    case competeLetBall = 2
    
    /// 亚盘
    case asianPlate = 3
    
    /// 大小球ode
    case sizePlate = 4
    
    /// 欧赔
    case europe = 5
    
    /// 足球 包含亚盘，大小，欧赔
    case football = 9
    
    /// 竞彩单关
    case single = 21
    
    /// 竞彩串关
    case serial = 22
    
    /// 竞彩 包含单关和串关
    case jingcai = 29
    
    var message: String {
        switch self {
        case .all: return "全部"
        case .competeNotLetBall: return "竞彩非让球"
        case .competeLetBall: return "竞彩让球"
        case .asianPlate: return "亚盘"
        case .sizePlate: return "大小球"
        case .europe: return "欧赔"
        case .football: return "足球"
        case .single: return "竞彩单关"
        case .serial: return "竞彩串关"
        case .jingcai: return "竞彩"
        }
    }
    
    
    var color: UIColor {
        switch self {
        case .asianPlate: return UIColor(hex: 0xff974b)
        case .sizePlate: return UIColor(hex: 0x4bbdff)
        case .europe: return UIColor(hex: 0xff604b)
        default: return UIColor.black
        }
    }
    
    
    var winTitle: String {
        switch self {
        case .asianPlate: return "主"
        case .sizePlate: return "大球"
        case .europe: return "胜"
        case .jingcai: return "让胜"
        default: return ""
        }
    }
    
    var drawTitle: String {
        switch self {
        case .asianPlate: return ""
        case .sizePlate: return ""
        case .europe: return "平"
        case .jingcai: return "让平"
        default: return ""
        }
    }
    
    var lostTitle: String {
        switch self {
        case .asianPlate: return "客"
        case .sizePlate: return "小球"
        case .europe: return "负"
        case .jingcai: return "让负"
        default: return ""
        }
    }
    
    var rankMessage: String {
        switch self {
        case .single: return "单关"
        case .serial: return "2串1"
        default: return ""
        }
    }
    
}
