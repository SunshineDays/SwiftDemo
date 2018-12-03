//
// Created by tianshui on 2017/11/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 球队 详情model
struct FBTeamDetailModel: BaseModelProtocol {

    var json: JSON

    /// 球队信息
    var teamInfo: FBTeamModel

    /// 历史战绩
    var historyMatchList: [FBLiveMatchModel]

    /// 即将进行的比赛
    var nextMatch: FBLiveMatchModel?

    /// 进球分布
    var goalSpreads = [GoalSpread]()

    /// 荣誉
    var gloryList: [Glory]

    /// 总进球
    var goalTotal: Int

    /// 总失球
    var fumbleTotal: Int

    /// 总比赛次数
    var matchCount: Int

    init(json: JSON) {
        self.json = json

        teamInfo = FBTeamModel(json: json["team_info"])
        historyMatchList = json["history_matchs"].arrayValue.map { FBLiveMatchModel(json: $0) }
        let nextMatchJson = json["next_match"]
        nextMatch = nextMatchJson.isEmpty ? nil : FBLiveMatchModel(json: nextMatchJson)

        gloryList = json["glorys"].arrayValue.map { Glory(json: $0) }

        let goalSpreadJson = json["goal_spread"]
        for key in ["time_01_15", "time_16_30", "time_31_45", "time_46_60", "time_61_75", "time_76_90"] {
            goalSpreads.append(GoalSpread(json: goalSpreadJson[key]))
        }
        goalTotal = goalSpreadJson["all"]["goal"].intValue
        fumbleTotal = goalSpreadJson["all"]["fumble"].intValue
        matchCount = goalSpreadJson["matchcount"].intValue
    }

    /// 进球分布
    struct GoalSpread {

        /// 文字说明
        var time: String

        /// 进球数
        var goal: Int

        /// 失球数
        var fumble: Int

        init(json: JSON) {
            time = json["text"].stringValue
            goal = json["goal"].intValue
            fumble = json["fumble"].intValue
        }
    }

    /// 荣誉
    struct Glory {

        /// 荣誉名
        var name: String

        /// 获取的赛季
        var seasonList: [String]

        /// 奖杯类型
        var cupType: CupType?

        init(json: JSON) {
            name = json["name"].stringValue
            seasonList = json["seasons"].arrayValue.map { $0.stringValue }
            cupType = CupType(rawValue: json["cup"].intValue)
        }

        /// 奖杯类型
        enum CupType: Int {
            case first = 1, second, third, four

            var image: UIImage {
                switch self {
                case .first: return R.image.fbTeam.glory1()!
                case .second: return R.image.fbTeam.glory2()!
                case .third: return R.image.fbTeam.glory3()!
                case .four: return R.image.fbTeam.glory4()!
                }
            }
        }
    }
}
