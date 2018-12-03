//
// Created by tianshui on 2017/10/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 赛事 赛果 大小球
enum FBMatchResultBigSmallType: String {

    /// 大球
    case big = "win"

    /// 走
    case draw = "draw"

    /// 小球
    case small = "small"

    init?(rawValue: String) {
        switch rawValue {
        case "big": self = .big
        case "draw": self = .draw
        case "small": self = .small
        default: return nil
        }
    }
    
    /// 对应的颜色
    var color: UIColor {
        switch self {
        case .big: return TSColor.matchResult.win
        case .draw: return TSColor.matchResult.draw
        case .small: return TSColor.matchResult.lost
        }
    }
}

extension FBMatchResultBigSmallType: CustomStringConvertible {

    var description: String {
        switch self {
        case .big: return "大"
        case .draw: return "走"
        case .small: return "小"
        }
    }
}
