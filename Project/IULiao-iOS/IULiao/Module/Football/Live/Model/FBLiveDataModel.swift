//
//  FBLiveDataModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

struct FBLiveDataModel {
    
    var allMatchList = [FBLiveMatchModel]()//所有比赛
    
    var leagueList = [FBLiveLeagueModel]()//比分联赛模型
    
    var issueList = [String]()
    
    var currentIssue = ""
    
    var selectIssue = ""
    
    var liveNum = 0

    var liveTabType = FBLiveTabType.all// 比分标签   ->当前默认值 是字符串
    
    var lottery = Lottery.jingcai///// 彩种      ->当前默认值 是字符串 竞彩
    
    func filterMatchList() -> [FBLiveMatchModel] {
        let leagues = leagueList.filter { $0.isSelected }//
        let isAllLeagues = leagues.count == leagueList.count//是否是所有联赛
        let liveStateTypes = liveTabType.liveStateTypes//数组 存放
        let isAllStateType = liveTabType == .all// 默认true
        let isAttention = liveTabType == .attention//是否关注
        
        let matchs = allMatchList.filter {
            match in
            if isAttention {
                guard match.isAttention else {
                    return false
                }
            }
            
            if !isAllStateType {
                guard let _ = liveStateTypes.index(of: match.stateType) else {
                    return false
                }
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
