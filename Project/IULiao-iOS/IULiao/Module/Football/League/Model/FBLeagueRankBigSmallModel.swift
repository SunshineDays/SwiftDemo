//
//  FBLeagueRankBigSmallModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛 排行榜 大小
struct FBLeagueRankBigSmallModel: BaseModelProtocol {

    var json: JSON

    var teamId: Int

    /// 球队名
    var teamName: String

    /// 总场次
    var totalCount: Int

    /// 大球 场次
    var bigCount: Int

    /// 走 场次
    var drawCount: Int

    /// 小 场次
    var smallCount: Int

    /// 近期赛果
    var matchResults: [FBMatchResultBigSmallType]

    init(json: JSON) {
        self.json = json
        teamId = json["id"].intValue
        teamName = json["name"].stringValue

        totalCount = json["total"].intValue
        bigCount = json["big"].intValue
        drawCount = json["draw"].intValue
        smallCount = json["small"].intValue

        matchResults = json["match_result"].arrayValue.flatMap {
            FBMatchResultBigSmallType(rawValue: $0.stringValue)
        }
    }
}

/// 大小球数据
struct FBLeagueRankBigSmallDataModel {
    var all: [FBLeagueRankBigSmallModel]
    var home: [FBLeagueRankBigSmallModel]
    var away: [FBLeagueRankBigSmallModel]
}
