//
//  FBLiveDataModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

struct FBLiveDataModel2 {

    var allMatchList = [FBLiveMatchModel2]()

    var leagueList = [FBLiveLeagueModel]()

    var issueList = [String]()

    var currentIssue = ""

    var selectIssue = ""

    var liveNum = 0

    var liveTabType = FBLiveTabType.all

    var lottery = Lottery.all
    
    /// 服务器时间
    var serverTime: TimeInterval = 0
    
    /// 本地时间与服务器时间差
    var serverTimeGap: TimeInterval = 0
    
    // 如果是关注界面，不需要筛选数据
    var isAttention = false

    /// 赛事通过日期分组
    func matchGroupByDate() -> [MatchGroup] {
        let leagues = leagueList.filter {
            $0.isSelected
        }
//        let isAllLeagues = leagues.count == leagueList.count || leagues.count == 0

        // 过滤符合显示条件的赛事
        var matchList = [FBLiveMatchModel2]()
        if liveTabType == .attention {
            matchList = allMatchList
        }
        else {
            for match in allMatchList {
                for leag in leagues {
                    if match.league.id == leag.id {
                        matchList.append(match)
                    }
                }
            }
        }

        // 分组为 进行中,日期,已完场(如果全部为已完场则按照日期显示)
        var playing = [FBLiveMatchModel2]()
        var over = [FBLiveMatchModel2]()
        var matchGroupList = [MatchGroup]()
        var overGroupList = [MatchGroup]()

        for match in matchList {
            let d = Date(match.matchTime)
            let title = d.stringWithFormat("yyyy-MM-dd") + " 星期" + d.getWeekday().cn

            let state = match.stateType
            if state == .over {
                if let index = overGroupList.index(where: { $0.indexTitle == title }) {
                    overGroupList[index].matchList.append(match)
                } else {
                    overGroupList.append(MatchGroup(indexTitle: title, matchList: [match]))
                }
                over.append(match)
                continue
            }
            if state == .uptHalf || state == .halfTime || state == .downHalf {
                playing.append(match)
                continue
            }

            if let index = matchGroupList.index(where: { $0.indexTitle == title }) {
                matchGroupList[index].matchList.append(match)
            } else {
                matchGroupList.append(MatchGroup(indexTitle: title, matchList: [match]))
            }
        }
        
        
        // 全部比赛为已完场
//        if over.count == matchList.count {
//            print(matchList.count)
//            return overGroupList.sorted(by: { $0.indexTitle < $1.indexTitle })
//        }
        
        if liveTabType == .over {
            return overGroupList.sorted(by: { $0.indexTitle < $1.indexTitle })
        }

        matchGroupList.sort(by: { $0.indexTitle < $1.indexTitle })
        if playing.count > 0 {
            matchGroupList.insert(MatchGroup(indexTitle: "进行中", matchList: playing), at: 0)
        }
        if over.count > 0 {
            matchGroupList.append(MatchGroup(indexTitle: "已完场", matchList: over))
        }
        return matchGroupList
    }

    struct MatchGroup {
        var indexTitle: String
        var matchList: [FBLiveMatchModel2]
    }

    /// 联赛通过首字母分组
//    func leagueGroupByIndexCharter() -> [LeagueGroup] {
//        var result = [LeagueGroup]()
//        for league in leagueList {
//            let title = league.indexCharter
//            if let index = result.index(where: { $0.indexTitle == title }) {
//                result[index].leagueList.append(league)
//            } else {
//                result.append(LeagueGroup(indexTitle: title, leagueList: [league]))
//            }
//        }
//        return result
//    }
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

    struct LeagueGroup {
        var indexTitle: String
        var leagueList: [FBLiveLeagueModel]
    }
    
}
