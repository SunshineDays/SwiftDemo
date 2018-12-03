//
// Created by tianshui on 2017/12/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 交锋
struct FBMatchWarModel: FBBaseMatchModelProtocol {

    var json: JSON

    /// mid
    var mid: Int

    /// 主队名
    var home: String

    /// 客队名
    var away: String

    /// 主队得分
    var homeScore: Int?

    /// 客队得分
    var awayScore: Int?

    /// 联赛信息
    var league: FBBaseLeagueModel

    /// 开赛时间
    var matchTime: TimeInterval

    /// 主队id
    var homeTid: Int

    /// 客队id
    var awayTid: Int

    /// 主队半场得分
    var homeHalfScore: Int?

    /// 客队半场得分
    var awayHalfScore: Int?

    /// 亚盘
    var asia: FBOddsAsiaModel?

    init(json: JSON) {
        self.json = json
        mid  = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeScore = json["hscore"].int
        awayScore = json["ascore"].int
        matchTime = json["mtime"].doubleValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        homeHalfScore = json["hhalfscore"].int
        awayHalfScore = json["ahalfscore"].int

        asia = FBOddsAsiaModel(json: json["asia"])
    }
}

