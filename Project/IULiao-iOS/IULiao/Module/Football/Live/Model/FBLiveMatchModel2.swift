//
//  FBLiveMatchModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球比分赛事model
struct FBLiveMatchModel2: FBBaseMatchModelProtocol {

    var json: JSON

    /// mid 赛事id
    var mid: Int

    /// 主队名
    var home: String

    /// 客队名
    var away: String

    /// 主队得分
    var homeScore: Int?

    var lastHomeScore: Int?

    /// 客队得分
    var awayScore: Int?

    var lastAwayScore: Int?
    
    /// 主队半场比分
    var homeHalfScore: Int?
    
    /// 客队半场比分
    var awayHalfScore: Int?

    /// 联赛信息
    var league: FBBaseLeagueModel

    /// 开赛时间
    var matchTime: TimeInterval

    /// 主队红牌
    var homeRed: Int

    /// 客队红牌
    var awayRed: Int

    /// 开赛时间
    var beginTime: TimeInterval?

    /// 需要交换消息
    var isNeedExchangeMsg: Bool

    /// 状态
    var stateType: FBLiveStateType

    /// 序号
    var serial: String

    /// 是否关注
    var isAttention: Bool

    /// 主队logo
    var homeLogo: String?

    /// 客队logo
    var awayLogo: String?

    /// 主队id
    var homeTid: Int

    /// 客队id
    var awayTid: Int

    /// 主队红牌
    var homeYellow: Int

    /// 客队红牌
    var awayYellow: Int

    /// 主队角球
    var homeCorner: Int

    /// 客队角球
    var awayCorner: Int

    /// 主队点球
    var homePenalty: Int?

    /// 客队点球
    var awayPenalty: Int?

    /// 主队加时
    var homeOverTime: Int?

    /// 客队加时
    var awayOverTime: Int?
    
    /// 主队排名
    var homeRank: Int
    
    /// 客队排名
    var awayRank: Int

    /// 轮次id
    var roundId: Int

    /// 简讯个数
    var briefNewsCount: Int

    /// 推荐个数
    var recommendCount: Int

    /// 伤病个数
    var injuryCount: Int

    /// 动画直播个数
    var liveAnimationCount: Int

    /// 是否展开统计信息
    var isExpandStatisticsView = false

    init(json: JSON) {
        self.json = json

        mid  = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue

        // 接口有可能返回字符串
        let hscore = json["hscore"]
        if hscore.type == Type.string {
            if hscore.stringValue.isEmpty {
                homeScore = nil
            } else {
                homeScore = hscore.intValue
            }
        } else {
            homeScore = hscore.int
        }

        let ascore = json["ascore"]
        if ascore.type == Type.string {
            if ascore.stringValue.isEmpty {
                awayScore = nil
            } else {
                awayScore = ascore.intValue
            }
        } else {
            awayScore = ascore.int
        }

        matchTime = json["mtime"].doubleValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
        homeRed = json["hred"].intValue
        awayRed = json["ared"].intValue
        beginTime = json["ktime"].double
        isNeedExchangeMsg = json["exchange"].boolValue
        stateType = FBLiveStateType(rawValue: json["state"].intValue)
        serial = json["serial"].stringValue
        homeLogo = json["hlogo"].stringValue
        awayLogo = json["alogo"].stringValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        homeHalfScore = json["hhalfscore"].int
        awayHalfScore = json["ahalfscore"].int

        homeYellow = json["hyellow"].intValue
        awayYellow = json["ayellow"].intValue
        homeCorner = json["hcorner"].intValue
        awayCorner = json["acorner"].intValue
        homePenalty = json["hpenalty"].int
        awayPenalty = json["apenalty"].int
        homeOverTime = json["hovertime"].int
        awayOverTime = json["aovertime"].int
        homeRank = json["hrank"].intValue
        awayRank = json["arank"].intValue

        briefNewsCount = json["brief_news"].intValue
        recommendCount = json["recommend"].intValue
        injuryCount = json["injury"].intValue
        liveAnimationCount = json["live_animation"].intValue

        roundId = json["rid"].intValue
        isAttention = json["isattention"].boolValue
    }


}


extension FBLiveMatchModel2 {

    /// 即时比分进行到的时间
    func liveTime() -> Int {

        let current = Date().timeInterval
        let realTime = beginTime ?? matchTime

        var time = (current - realTime) / 60

        if stateType == .uptHalf {
            time = max(0, time)
            time = min(45, time)
        } else if stateType == .downHalf {
            time += 45
            time = max(45, time)
            time = min(90, time)
        }
        return Int(time)
    }
}
