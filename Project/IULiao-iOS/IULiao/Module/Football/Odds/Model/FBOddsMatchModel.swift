//
//  FBOddsMatchModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球赔率赛事model odds//赔率
struct FBOddsMatchModel: FBBaseMatchModelProtocol {
    
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
    
    /// 状态
    var stateType: FBLiveStateType
    
    /// 序号
    var serial: String
    
    /// 欧赔
    var europes: [FBOddsEuropeSetModel]
    
    /// 亚盘
    var asias: [FBOddsAsiaSetModel]
    
    /// 主队id
    var homeTid: Int
    
    /// 客队id
    var awayTid: Int
    
    init(json: JSON) {
        self.json = json
        mid  = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeScore = json["hscore"].int
        awayScore = json["ascore"].int
        matchTime = json["mtime"].doubleValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
        stateType = FBLiveStateType(rawValue: json["state"].intValue)
        serial = json["serial"].stringValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        
        europes = json["europes"].arrayValue.map { subJson -> FBOddsEuropeSetModel in
            let initJson = subJson["init"]
            let lastJson = subJson["last"]
            let companyJson = subJson["company"]
            
            let initOdds = FBOddsEuropeModel(win: initJson["win"].doubleValue, draw: initJson["draw"].doubleValue, lost: initJson["lost"].doubleValue)
            let lastOdds = FBOddsEuropeModel(win: lastJson["win"].doubleValue, draw: lastJson["draw"].doubleValue, lost: lastJson["lost"].doubleValue)
            let company = CompanyModel(cid: companyJson["cid"].intValue, name: companyJson["name"].stringValue)
            return FBOddsEuropeSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
        }
        
        asias = json["asias"].arrayValue.map { subJson -> FBOddsAsiaSetModel in
            let initJson = subJson["init"]
            let lastJson = subJson["last"]
            let companyJson = subJson["company"]
            
            let initOdds = FBOddsAsiaModel(above: initJson["above"].doubleValue, below: initJson["below"].doubleValue, handicap: initJson["handicap"].stringValue, bet: initJson["bet"].intValue)
            let lastOdds = FBOddsAsiaModel(above: lastJson["above"].doubleValue, below: lastJson["below"].doubleValue, handicap: lastJson["handicap"].stringValue, bet: lastJson["bet"].intValue)
            let company = CompanyModel(cid: companyJson["cid"].intValue, name: companyJson["name"].stringValue)
            return FBOddsAsiaSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
        }

    }
    
}
