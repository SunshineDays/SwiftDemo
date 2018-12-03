//
// Created by tianshui on 2018/5/15.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 数字彩 球类型
enum NLBallType: String {

    case none = ""

    // --------------------------------------------------
    // 双色球,大乐透
    // --------------------------------------------------

    /// 红球
    case red = "red"

    /// 蓝球
    case blue = "blue"

    // --------------------------------------------------
    // 星彩,11运夺金,广东11选5,新11选5 部分玩法
    // --------------------------------------------------

    /// 第一位
    case position_1 = "p_1"

    /// 第二位
    case position_2 = "p_2"

    /// 第三位
    case position_3 = "p_3"

    /// 第四位
    case position_4 = "p_4"

    /// 第五位
    case position_5 = "p_5"

    /// 第六位
    case position_6 = "p_6"

    /// 第七位
    case position_7 = "p_7"

    // --------------------------------------------------
    // 3d,排三,排五,时时彩 部分玩法
    // --------------------------------------------------

    /// 个位
    case unit_1 = "u_1"

    /// 十位
    case unit_10 = "u_10"

    /// 百位
    case unit_100 = "u_100"

    /// 千位
    case unit_1000 = "u_1000"

    /// 万位
    case unit_10000 = "u_10000"

    // --------------------------------------------------
    // 快三 二不同号
    // --------------------------------------------------

    /// 相同号码
    case codeSame = "code_same"

    /// 不同号码
    case codeDifferent = "code_different"

    var name: String {
        switch self {
        case .red: return "红球"
        case .blue: return "篮球"

        case .position_1: return "第一位"
        case .position_2: return "第二位"
        case .position_3: return "第三位"
        case .position_4: return "第四位"
        case .position_5: return "第五位"
        case .position_6: return "第六位"
        case .position_7: return "第七位"

        case .unit_1: return "个位"
        case .unit_10: return "十位"
        case .unit_100: return "百位"
        case .unit_1000: return "千位"
        case .unit_10000: return "万位"

        case .codeSame: return "同号"
        case .codeDifferent: return "不同号"

        case .none: return ""
        }
    }
}
