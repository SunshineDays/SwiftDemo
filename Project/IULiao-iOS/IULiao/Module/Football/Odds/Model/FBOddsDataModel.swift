//
//  FBOddsDataModel.swift
//  IULiao
//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 足球 赔率 数据
struct FBOddsDataModel {
    
    var allMatchList = [FBOddsMatchModel]()
    
    var leagueList = [FBLiveLeagueModel]()
    
    var issueList = [String]()
    
    var currentIssue = ""
    
    var selectIssue = ""
    
    var lottery = Lottery.jingcai
    
    //var companys = [CompanyModel(cid: 449, name: "立博", isSelected: true), CompanyModel(cid: 451, name: "威廉", isSelected: true)]
    //var companys = [CompanyModel(cid: 30, name: "bet 365"), CompanyModel(cid: 442, name: "澳门")]
    var companys = TSCompanyHelper.lastCompanys()
    
    var oddsType = TSCompanyHelper.lastOddsType()
    
    func filterMatchList() -> [FBOddsMatchModel] {
        let leagues = leagueList.filter { $0.isSelected }
        let isAllLeagues = leagues.count == leagueList.count
        
        let matchs = allMatchList.filter {
            match in
            
            if !isAllLeagues {
                guard let _ = leagues.index (where: { $0.id == match.league.id }) else {
                    return false
                }
            }
            return true
        }
        return matchs
    }
    
    func leaugeGroupByFirstCharter() -> (indexTitles: [String], leagues: [[FBLiveLeagueModel]]) {
        var resultDic = [String: [FBLiveLeagueModel]]()
        for league in leagueList {
            let indexCharter = league.indexCharter
            if resultDic[indexCharter] == nil {
                resultDic.updateValue([FBLiveLeagueModel](), forKey: indexCharter)
            }
            resultDic[indexCharter]?.append(league)
        }
        let sorted = resultDic.sorted { (a, b) -> Bool in
            return a.0 < b.0
        }
        
        return (sorted.map {$0.0}, sorted.map {$0.1})
    }
    
}
