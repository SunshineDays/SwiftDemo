//
//  FBPlayerStatisticsModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/14.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 球员统计
struct FBPlayerStatisticsModel: BaseModelProtocol {
    
    var json: JSON

    /// 当前联赛id
    var currentLeagueId: Int

    /// 统计列表
    var statisticList = [Statistic]()


    init(json: JSON) {
        self.json = json
        
        currentLeagueId = json["currentid"].intValue
        statisticList = json["statistics"].arrayValue.map { Statistic(json: $0) }
    }


    /// 统计信息
    struct Statistic {

        /// 联赛信息
        var leagueInfo: FBBaseLeagueModel

        /// 统计 内容
        var payloadList: [Payload]

        init(json: JSON) {
            leagueInfo = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue)
            payloadList = json["seasons"].arrayValue.map { Payload(json: $0) }
        }

        /// 统计实际内容
        struct Payload {
            /// 赛季名
            var seasonName: String

            /// 总场次
            var total: Int

            /// 首发次数
            var first: Int

            /// 上场时间
            var time: Int

            /// 进球
            var goal: Int

            /// 射门
            var shoot: Int

            /// 助攻
            var assist: Int

            /// 关键传球
            var keyPass: Int

            /// 铲球
            var tackle: Int

            /// 断球
            var interception: Int

            /// 带球摆脱
            var breakLoose: Int

            /// 失误 丢球
            var turnover: Int

            /// 犯规
            var foul: Int

            /// 被犯规
            var fouled: Int

            /// 红牌
            var red: Int

            /// 黄牌
            var yellow: Int

            init(json: JSON) {
                seasonName = json["sname"].stringValue
                total = json["total"].intValue
                first = json["first"].intValue
                time = json["time"].intValue
                goal = json["goal"].intValue
                shoot = json["shoot"].intValue
                assist = json["assist"].intValue
                keyPass = json["key_pass"].intValue
                tackle = json["tackle"].intValue
                interception = json["interception"].intValue
                breakLoose = json["break_loose"].intValue
                turnover = json["turnover"].intValue
                foul = json["foul"].intValue
                fouled = json["fouled"].intValue
                red = json["red"].intValue
                yellow = json["yellow"].intValue
            }
        }
    }
}
