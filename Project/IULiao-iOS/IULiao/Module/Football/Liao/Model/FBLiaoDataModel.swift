//
//  FBLiaoDataModel.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 足球 料 数据
struct FBLiaoDataModel {
    
    var allMatchList = [FBMatchModel]()
    
    var leagueList = [FBLiveLeagueModel]()
    
    /// 简讯 mid: [Brief]
    var briefDict = [Int: [FBLiaoBriefModel]]()
    
    var issueList = [String]()
    
    var currentIssue = ""
    
    var selectIssue = ""

    
    func filterMatchList() -> [FBMatchModel] {
        let leagues = leagueList.filter { $0.isSelected }
        let isAllLeagues = leagues.count == leagueList.count
        
        let matchs = allMatchList.filter {
            match in
            
            if let count = briefDict[match.mid]?.count, count < 2 {
                return false
            }
            
            if !isAllLeagues {
                guard let _ = leagues.index (where: { $0.id == match.league.id }) else {
                    return false
                }
            }
            return true
        }
        return matchs
    }
    func filterPostRecommendList() ->[FBMatchModel]  {
        let leagues = leagueList.filter({$0.isSelected})
       
        let matchs = allMatchList.filter { (matchModel) -> Bool in
            guard let _ = leagues.index(where: {$0.lid == matchModel.lid})else { return false }
            return true
        }
        
           
        
        return matchs
    }
    //数据分组操作
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
