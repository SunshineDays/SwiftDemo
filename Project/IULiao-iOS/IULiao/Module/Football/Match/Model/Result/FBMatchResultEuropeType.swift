//
// Created by tianshui on 2017/10/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 赛事 赛果 欧赔(胜平负)
enum FBMatchResultEuropeType: String {

    /// 胜
    case win = "win"

    /// 平
    case draw = "draw"

    /// 负
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
    
    /// 根据球队id与比分计算得到一个胜平负关系
    ///
    /// - Parameters:
    ///   - teamId: 当前球队id
    ///   - homeTeamId: 主队id
    ///   - awayTeamId: 客队id
    ///   - homeScore: 主队得分
    ///   - awayScore: 客队得分
    init(teamId: Int, homeTeamId: Int, awayTeamId: Int, homeScore: Int, awayScore: Int) {
        var value = 1
        if teamId == awayTeamId{
            if homeScore > awayScore {
                value = 0
            } else if homeScore < awayScore {
                value = 3
            }
        } else {
            if homeScore > awayScore {
                value = 3
            } else if homeScore < awayScore {
                value = 0
            }
        }
        self.init(intValue: value)!
    }
    
    /// 根据比分计算得到一个胜平负关系(与球队无关)
    ///
    /// - Parameters:
    ///   - teamId: 当前球队id
    ///   - homeTeamId: 主队id
    ///   - awayTeamId: 客队id
    ///   - homeScore: 主队得分
    ///   - awayScore: 客队得分
    init(homeScore: Int, awayScore: Int) {
        var value = 1
        if homeScore > awayScore {
            value = 3
        } else if homeScore < awayScore {
            value = 0
        }
        self.init(intValue: value)!
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

extension FBMatchResultEuropeType: CustomStringConvertible {

    var description: String {
        switch self {
        case .win: return "胜"
        case .draw: return "平"
        case .lost: return "负"
        }
    }
}
