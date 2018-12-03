//
// Created by tianshui on 2017/10/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 赛事 赛果 亚盘
enum FBMatchResultAsiaType: String {

    /// 赢
    case win = "win"

    /// 走
    case draw = "draw"

    /// 输
    case lost = "lost"

    init?(rawValue: String) {
        switch rawValue {
        case "win", "3": self = .win
        case "draw", "1": self = .draw
        case "lost", "0": self = .lost
        default: return nil
        }
    }

    /// 以数字初始化 3,1,0
    init?(intValue: Int) {
        switch intValue {
        case 3: self = .win
        case 1: self = .draw
        case 0: self = .lost
        default: return nil
        }
    }
    
    /// 对应的数字表示 3, 1, 0
    var intValue: Int {
        switch self {
        case .win: return 3
        case .draw: return 1
        case .lost: return 0
        }
    }
    
    /// 对应的颜色
    var color: UIColor {
        switch self {
        case .win: return TSColor.matchResult.win
        case .draw: return TSColor.matchResult.draw
        case .lost: return TSColor.matchResult.lost
        }
    }
    
}

extension FBMatchResultAsiaType: CustomStringConvertible {

    var description: String {
        switch self {
        case .win: return "赢"
        case .draw: return "走"
        case .lost: return "输"
        }
    }
}
