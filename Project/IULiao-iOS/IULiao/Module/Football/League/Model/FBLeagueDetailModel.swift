//
//  FBLeagueDetailModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛详情
struct FBLeagueDetailModel: BaseModelProtocol {
    
    var json: JSON

    /// 联赛信息
    var leagueInfo: FBLeagueModel

    /// 赛季信息
    var seasonInfo: FBLeagueSeasonModel

    /// 赛事统计
    var matchStatistics: MatchStatistics

    /// 进球分布
    var goalSpreads = [GoalSpread]()

    init(json: JSON) {
        self.json = json
        let leagueInfoJson = json["league_info"],
            goalSpreadJson = json["goal_spread"]
        leagueInfo = FBLeagueModel(json: leagueInfoJson)
        seasonInfo = FBLeagueSeasonModel(json: leagueInfoJson["season"])
        matchStatistics = MatchStatistics(json: json["match_statistics"])
        
        for key in ["time_01_15", "time_16_30", "time_31_45", "time_46_60", "time_61_75", "time_76_90"] {
            goalSpreads.append(GoalSpread(json: goalSpreadJson[key]))
        }
    }

    /// 进球分布
    struct GoalSpread {

        /// 文字说明
        var time: String

        /// 进球数
        var goal: Int

        /// 百分比
        var percent: Double

        init(json: JSON) {
            time = json["text"].stringValue
            goal = json["goal"].intValue
            percent = json["percent"].doubleValue
        }
    }

    /// 赛事统计
    struct MatchStatistics {

        /// 总比赛场次
        var all: Int

        /// 完场场次
        var over: Int

        /// 胜场次
        var win: Int

        /// 平场次
        var draw: Int

        /// 负场次
        var lost: Int
        
        /// 赢的概率
        var winPercent: Double {
            return Double(win) / Double(max(over, 1))
        }
        
        /// 平的概率
        var drawPercent: Double {
            return Double(draw) / Double(max(over, 1))
        }
        
        /// 输的概率
        var lostPercent: Double {
            return Double(lost) / Double(max(over, 1))
        }

        /// 平均进球
        var avgScore: Double

        /// 主场进球
        var homeScore: Double

        /// 客场进球
        var awayScore: Double

        init(json: JSON) {
            all = json["all"].intValue
            over = json["over"].intValue
            win = json["win"].intValue
            draw = json["draw"].intValue
            lost = json["lost"].intValue
            avgScore = json["avgscore"].doubleValue
            homeScore = json["homescore"].doubleValue
            awayScore = json["awayscore"].doubleValue
        }
    }
}
