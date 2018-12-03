//
//  FBLiveStateType.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

enum FBColorType: String {
    
    case red = "red"
    case blue = "blue"
    case green = "green"
    case normal = "black"
    
    var color: UIColor {
        switch self {
        case .red: return UIColor(r: 0xff, g: 0x00, b: 0x00)
        case .blue: return UIColor(r: 0x00, g: 0x00, b: 0xff)
        case .green: return UIColor(r: 0x06, g: 0x7f, b: 0x14)
        default:
            return UIColor.black
        }

    }
    
    init(num: Double) {
        if num > 0 {
            self = .red
        } else if num < 0 {
            self = .green
        } else {
            self = .normal
        }
    }

    init(num: Int) {
        if num > 0 {
            self = .red
        } else if num < 0 {
            self = .green
        } else {
            self = .normal
        }
    }
}

// 比赛状态
enum FBLiveStateType: Int {
    /// 未开始
    case notStarted = 0
    /// 上半场
    case uptHalf = 1
    /// 中场
    case halfTime = 2
    /// 下半场
    case downHalf = 3
    /// 完场
    case over = 4
    /// 取消
    case cancel = 6
    /// 延期
    case delaye = 13
    /// 中断
    case pause = 5
    
    
    init(rawValue: Int) {
        switch rawValue {
        case 1: self = .uptHalf
        case 2: self = .halfTime
        case 3: self = .downHalf
        case 6: self = .cancel
        case 4, 7, 8, 9, 10, 11: self = .over
        case 5, 14: self = .pause
        case 13, 15: self = .delaye
        default: self = .notStarted
        }
    }
    
    /// 对应的颜色
    var color: UIColor {
        
        switch self {
        case .uptHalf: fallthrough
        case .downHalf: fallthrough
        case .halfTime: fallthrough
        case .pause:
            return FBColorType.green.color
        case .over:
            return FBColorType.red.color
        default:
            return TSColor.gray.gamut444444
        }
    }
    
    var name: String {
        switch self {
        case .notStarted: return "未"
        case .uptHalf: return "上"
        case .halfTime: return "中"
        case .downHalf: return "下"
        case .over: return "完"
        case .cancel: return "取"
        case .delaye: return "延"
        case .pause: return "断"
        }
    }
}

