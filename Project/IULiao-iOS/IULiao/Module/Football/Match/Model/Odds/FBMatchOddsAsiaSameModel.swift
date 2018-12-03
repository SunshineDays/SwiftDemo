//
// Created by tianshui on 2017/12/14.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 亚盘 相同盘口
struct FBMatchOddsAsiaSameModel: BaseModelProtocol {

    var json: JSON

    var companyInfo: CompanyModel {
        return currentAsiaSet.company
    }

    /// 当前赔率
    var currentAsiaSet: FBOddsAsiaSetModel

    /// 全部赛事
    var allData: AsiaData

    /// 相同联赛
    var sameLeagueData: AsiaData

    init(json: JSON) {
        self.json = json
        let company = CompanyModel(cid: json["company"]["id"].intValue, name: json["company"]["name"].stringValue)
        let initOdds = FBOddsAsiaModel(json: json["init"])
        let lastOdds = FBOddsAsiaModel(json: json["last"])
        currentAsiaSet = FBOddsAsiaSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)

        allData = AsiaData(json: json["all"])
        sameLeagueData = AsiaData(json: json["same"])
    }

    struct Statistics {
        var above: Int
        var draw: Int
        var below: Int
        var count: Int

        init(json: JSON) {
            above = json["above"].intValue
            draw = json["draw"].intValue
            below = json["below"].intValue
            count = json["count"].intValue
        }
    }

    struct AsiaData {
        /// 赔率列表
        var oddsList: [(match: FBMatchModel, asiaSet: FBOddsAsiaSetModel)]
        /// 统计
        var statistics: Statistics

        init(json: JSON) {
            oddsList = json["matchs"].arrayValue.map {
                subJson -> (match: FBMatchModel, europeSet: FBOddsAsiaSetModel) in
                let company = CompanyModel(cid: 0, name: "")
                let initOdds = FBOddsAsiaModel(json: subJson["init"])
                let lastOdds = FBOddsAsiaModel(json: subJson["last"])
                let match = FBMatchModel(json: subJson["match"])
                let set = FBOddsAsiaSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                return (match, set)
            }

            statistics = Statistics(json: json["statistics"])
        }
    }


}
