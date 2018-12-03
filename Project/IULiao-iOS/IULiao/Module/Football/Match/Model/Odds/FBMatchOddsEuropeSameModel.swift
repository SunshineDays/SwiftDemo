//
// Created by tianshui on 2017/12/14.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 欧赔 相同赔率
struct FBMatchOddsEuropeSameModel: BaseModelProtocol {

    var json: JSON
    
    // 公司信息
    var companyInfo: CompanyModel {
        return currentEuropeSet.company
    }

    /// 当前赔率
    var currentEuropeSet: FBOddsEuropeSetModel

    /// 全部赛事
    var allData: EuropeData

    /// 相同联赛
    var sameLeagueData: EuropeData

    init(json: JSON) {
        self.json = json
        let company = CompanyModel(cid: json["company"]["id"].intValue, name: json["company"]["name"].stringValue)
        let initOdds = FBOddsEuropeModel(json: json["init"])
        let lastOdds = FBOddsEuropeModel(json: json["last"])
        currentEuropeSet = FBOddsEuropeSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)

        allData = EuropeData(json: json["all"])
        sameLeagueData = EuropeData(json: json["same"])
    }

    struct Statistics {
        var win: Int
        var draw: Int
        var lost: Int
        var count: Int

        init(json: JSON) {
            win = json["win"].intValue
            draw = json["draw"].intValue
            lost = json["lost"].intValue
            count = json["count"].intValue
        }
    }

    struct EuropeData {
        /// 赔率列表
        var oddsList: [(match: FBMatchModel, europeSet: FBOddsEuropeSetModel)]
        /// 统计
        var statistics: Statistics

        init(json: JSON) {
            oddsList = json["matchs"].arrayValue.map {
                subJson -> (match: FBMatchModel, europeSet: FBOddsEuropeSetModel) in
                let company = CompanyModel(cid: 0, name: "")
                let initOdds = FBOddsEuropeModel(json: subJson["init"])
                let lastOdds = FBOddsEuropeModel(json: subJson["last"])
                let match = FBMatchModel(json: subJson["match"])
                let set = FBOddsEuropeSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                return (match, set)
            }

            statistics = Statistics(json: json["statistics"])
        }
    }


}
