//
//  FBLeagueRankAsiaModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛 排行榜 亚盘
struct FBLeagueRankAsiaModel: BaseModelProtocol {

    var json: JSON

    var teamId: Int

    /// 球队名
    var teamName: String

    /// 总场次
    var totalCount: Int

    /// 赢 场次
    var winCount: Int

    /// 走 场次
    var drawCount: Int

    /// 输 场次
    var lostCount: Int

    /// 近期赛果
    var matchResults: [FBMatchResultAsiaType]

    init(json: JSON) {
        self.json = json
        teamId = json["id"].intValue
        teamName = json["name"].stringValue

        totalCount = json["total"].intValue
        winCount = json["win"].intValue
        drawCount = json["draw"].intValue
        lostCount = json["lost"].intValue

        matchResults = json["match_result"].arrayValue.flatMap {
            FBMatchResultAsiaType(rawValue: $0.stringValue)
        }
    }
}

/// 亚盘数据
struct FBLeagueRankAsiaDataModel {
    var all: [FBLeagueRankAsiaModel]
    var home: [FBLeagueRankAsiaModel]
    var away: [FBLeagueRankAsiaModel]
}
