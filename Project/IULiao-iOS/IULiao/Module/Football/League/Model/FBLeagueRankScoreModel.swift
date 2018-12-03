//
//  FBLeagueRankAsiaModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛 排行榜 积分
struct FBLeagueRankScoreModel: BaseModelProtocol {

    var json: JSON

    var teamId: Int

    /// 球队名
    var teamName: String

    /// 总场次
    var totalCount: Int

    /// 胜 场次
    var winCount: Int

    /// 平 场次
    var drawCount: Int

    /// 负 场次
    var lostCount: Int

    /// 进球
    var goal: Int

    // 失球
    var fumble: Int
    
    /// 积分
    var score: Int

    /// 等级
    var grade: FBLeagueRankGradeModel?

    /// 等级原始数据
    var gradeRawValue: Int

    /// 近期赛果
    var matchResults: [FBMatchResultEuropeType]

    init(json: JSON) {
        self.json = json
        teamId = json["id"].intValue
        teamName = json["name"].stringValue

        totalCount = json["total"].intValue
        winCount = json["win"].intValue
        drawCount = json["draw"].intValue
        lostCount = json["lost"].intValue

        goal = json["goal"].intValue
        fumble = json["fumble"].intValue
        score = json["score"].intValue
        gradeRawValue = json["grade"].intValue

        matchResults = json["match_result"].arrayValue.flatMap { FBMatchResultEuropeType(rawValue: $0.stringValue) }
    }
}

/// 积分等级
struct FBLeagueRankGradeModel: BaseModelProtocol {
    var json: JSON

    var grade: Int
    var text: String
    var color: UIColor

    init(json: JSON) {
        self.json = json

        grade = json["grade"].intValue
        text = json["text"].stringValue
        color = UIColor(rgba: json["color"].stringValue)
    }
}

/// 排行榜 积分数据
struct FBLeagueRankScoreDataModel: BaseModelProtocol {
    
    var json: JSON

    /// 排行榜类型
    var type: RankScoreType

    /// 全部
    var all: [FBLeagueRankScoreModel]
    /// 主场
    var home: [FBLeagueRankScoreModel]
    /// 客场
    var away: [FBLeagueRankScoreModel]
    /// 等级
    var grades: [FBLeagueRankGradeModel]

    /// 分组数据
    var groups: [Section]
    
    /// 单个小组 针对赛事分析中的积分榜
    var section: Section?
    
    init(json: JSON) {
        self.json = json
        type = FBLeagueRankScoreDataModel.RankScoreType(rawValue: json["type"].stringValue) ?? .normal
        let grades = json["grades"].arrayValue.map {
            FBLeagueRankGradeModel(json: $0)
        }
        self.grades = grades
        all = json["all"].arrayValue.map {
            subJson -> FBLeagueRankScoreModel in
            var score = FBLeagueRankScoreModel(json: subJson)
            score.grade = grades.filter({ $0.grade == score.gradeRawValue }).first
            return score
        }
        home = json["home"].arrayValue.map {
            FBLeagueRankScoreModel(json: $0)
        }
        away = json["away"].arrayValue.map {
            FBLeagueRankScoreModel(json: $0)
        }
        groups = json["group_list"].arrayValue.map {
            subJson -> FBLeagueRankScoreDataModel.Section in
            let list = subJson["list"].arrayValue.map { FBLeagueRankScoreModel(json: $0) }
            return FBLeagueRankScoreDataModel.Section(name: subJson["name"].stringValue, list: list)
        }
        let sectionJson = json["section"]
        let list = sectionJson["list"].arrayValue.map { FBLeagueRankScoreModel(json: $0) }
        if !list.isEmpty {
            section = Section(name: sectionJson["name"].stringValue, list: list)
        }
    }

    /// 排行榜类型
    enum RankScoreType: String {
        case normal
        case group
    }
    
    /// 小组 节
    struct Section {
        
        /// 小节名
        var name: String
        
        /// 小节数据
        var list: [FBLeagueRankScoreModel]
    }
    
}
