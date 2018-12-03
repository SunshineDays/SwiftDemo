//
//  FBMatchWarStatisticsHelper.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 战绩统计类 此类的设计方式尽可能缓存数据
struct FBMatchWarStatisticsHelper {
    
    /// 筛选后的对阵
    var matchList = [FBMatchWarModel]()
    
    /// 基于筛选后对阵的统计数据
    var statistics = Statistics()
    
    /// 去除友谊
    var isRemoveFriendshipLeague = false {
        didSet {
            filterMatchList()
            caclStatistics()
        }
    }
    
    /// 主客相同
    var isSameHomeAway = false {
        didSet {
            filterMatchList()
            caclStatistics()
        }
    }
    
    /// 比赛场次
    var matchNumber = 6 {
        didSet {
            filterMatchList()
            caclStatistics()
        }
    }
    
    /// 所有赛事
    private var allMatchList = [FBMatchWarModel]()
    
    /// 球队id
    private var teamId = 0
    
    /// 主客类型
    private var teamType = TeamType.none
    
    /// 友谊赛 球会友谊
    private var friendshipLeagueIds = [61, 166]

    init(allMatchList: [FBMatchWarModel], teamId: Int, teamType: TeamType) {
        self.allMatchList = allMatchList
        self.teamId = teamId
        self.teamType =  teamType
        filterMatchList()
        caclStatistics()
    }
    
    /// 筛选对阵对阵
    private mutating func filterMatchList() {
        var matchList = [FBMatchWarModel]()
        
        for match in allMatchList {
            if matchList.count >= matchNumber {
                break
            }
            
            // 去除友谊
            if isRemoveFriendshipLeague {
                if friendshipLeagueIds.contains(match.league.lid) {
                    continue
                }
            }
            
            // 主客相同
            if isSameHomeAway {
                if teamType == .home {
                    if teamId != match.homeTid {
                        continue
                    }
                } else if teamType == .away {
                    if teamId != match.awayTid {
                        continue
                    }
                }
            }
            matchList.append(match)
        }
        self.matchList = matchList
    }
    
    /// 统计 胜 平 负 进球 失球 
    private mutating func caclStatistics() {
        
        var win = 0, draw = 0, lost = 0
        var goal = 0, fumble = 0
        
        for match in matchList {
            let homeScore = match.homeScore ?? 0
            let awayScore = match.awayScore ?? 0
            
            if teamId == match.homeTid {
                goal += homeScore
                fumble += awayScore
                
                if homeScore > awayScore {
                    win += 1
                } else if homeScore < awayScore {
                    lost += 1
                } else {
                    draw += 1
                }
            } else if teamId == match.awayTid {
                goal += awayScore
                fumble += homeScore
                
                if homeScore > awayScore {
                    lost += 1
                } else if homeScore < awayScore {
                    win += 1
                } else {
                    draw += 1
                }
            }
        }
        statistics = Statistics(win: win, draw: draw, lost: lost, goal: goal, fumble: fumble, total: matchList.count)
    }
    
    struct Statistics {
        var win = 0
        var draw = 0
        var lost = 0
        var goal = 0
        var fumble = 0
        var total = 0
    }
    
}
