//
// Created by tianshui on 2017/12/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 统计信息
struct FBMatchStatisticsModel: BaseModelProtocol {

    typealias Statistics = FBMatchOddsEuropeSameModel.Statistics

    var json: JSON

    /// 亚盘
    var asia: FBOddsAsiaSetModel

    /// 欧赔
    var europe: FBOddsEuropeSetModel

    /// 历史交锋战绩
    var warStatistics: Statistics

    /// 主队战绩
    var homeStatistics: Statistics

    /// 客队战绩
    var awayStatistics: Statistics

    init(json: JSON) {
        self.json = json

        let asiaJson = json["asia"]
        asia = FBOddsAsiaSetModel(
                company: CompanyModel(cid: 0, name: ""),
                initOdds: FBOddsAsiaModel(json: asiaJson["init"]),
                lastOdds: FBOddsAsiaModel(json: asiaJson["last"])
        )
        let europeJson = json["europe"]
        europe = FBOddsEuropeSetModel(
                company: CompanyModel(cid: 0, name: ""),
                initOdds: FBOddsEuropeModel(json: europeJson["init"]),
                lastOdds: FBOddsEuropeModel(json: europeJson["last"])
        )

        warStatistics = Statistics(json: json["wars"])
        homeStatistics = Statistics(json: json["home_matchs"])
        awayStatistics = Statistics(json: json["away_matchs"])
    }
}

