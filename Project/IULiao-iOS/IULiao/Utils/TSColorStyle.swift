//
//  TSColorStyle.swift
//  HuaXia
//
//  Created by tianshui on 15/11/16.
// 
//

import Foundation
import UIKit

/// 文字颜色
enum TSColorStyle {
    
    case `default`
    case success
    case error
    case warning
    case primary
    case info
    case custom(color: UIColor)
    
    var color: UIColor {
        let alpha: CGFloat = 1.0
        var color: UIColor
        switch self {
        case .default:
            color = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: alpha)
        case .success:
            color = UIColor(red: 94 / 255, green: 185 / 255, blue: 94 / 255, alpha: alpha)
        case .primary:
            color = UIColor(red: 14 / 255, green: 144 / 255, blue: 210 / 255, alpha: alpha)
        case .error:
            color = UIColor(red: 221 / 255, green: 81 / 255, blue: 76 / 255, alpha: alpha)
        case .warning:
            color = UIColor(red: 243 / 255, green: 123 / 255, blue: 29 / 255, alpha: alpha)
        case .info:
            color = UIColor(red: 59 / 255, green: 180 / 255, blue: 242 / 255, alpha: alpha)
        case .custom(let c):
            color = c
        }
        return color
    }

}

/// 颜色 静态常量
struct TSColor {
    
    //---------------------------------------------------
    // MARK:- 通用颜色
    //---------------------------------------------------
    
    /// cell的高亮和选中颜色 与系统默认的相同 0xD9D9D9
    static let cellHighlightedBackground = UIColor(hex: 0xD9D9D9)
    
    /// cell的分割线颜色 与系统默认的相同 0xC8C7CC
    static let cellSeparatorBackground = UIColor(hex: 0xC8C7CC)
    
    /// cell隔行变色 0xF2F2F2
    static let cellEachBackgroud = UIColor(hex: 0xF2F2F2)

    /// 灰色 色阶
    static let gray = (
        gamut333333: UIColor(hex: 0x333333),
        gamut444444: UIColor(hex: 0x444444),
        gamut666666: UIColor(hex: 0x666666),
        gamut999999: UIColor(hex: 0x999999),
        gamutCCCCCC: UIColor(hex: 0xCCCCCC)
    )
    
    //---------------------------------------------------
    // MARK:- 项目相关颜色
    //---------------------------------------------------
    
    /// logo的主色调 (橘) 0xF49900
    static let logo = UIColor(hex: 0xF49900)
    
    /// 比赛结果 赛果
    ///
    /// win: (红) 0xE84545
    ///
    /// draw: (绿) 0x6CB601
    ///
    /// lost: (蓝) 0x2AA4DC
    static let matchResult = (
        win: UIColor(hex: 0xE84545),
        draw: UIColor(hex: 0x6CB601),
        lost: UIColor(hex: 0x2AA4DC)
    )
    
    /// 主队的颜色 (棕) 0x801717
    static let homeTeam = UIColor(hex: 0x801717)
    
    
    
}

