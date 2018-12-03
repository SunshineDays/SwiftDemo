//
//  SportLotteryDataModel.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 数据
struct SLDataModel<MatchType: SLMatchModelProtocol> {

    /// 按期号分组
    var groupSortType = GroupSortType.issue

    /// 原始对阵
    var originalMatchList = [MatchType]() {
        didSet {
            originalLeagueList = generateOriginalLeagueList()
            selectedLeagueList = originalLeagueList
        }
    }

    /// 原始联赛
    private (set) var originalLeagueList = [SportLotteryLeagueModel]()

    /// 选择联赛
    var selectedLeagueList = [SportLotteryLeagueModel]() {
        didSet {
            switch groupSortType {
            case .issue: matchGroupList = matchGroupByIssue()
            case .date: matchGroupList = matchGroupByDate()
            }
        }
    }

    /// 对阵分组
    var matchGroupList = [MatchGroup]()

    /// 根据原始对阵生成原始的联赛信息
    private func generateOriginalLeagueList() -> [SportLotteryLeagueModel] {
        var result = [SportLotteryLeagueModel]()
        for match in originalMatchList {
            if !result.contains(where: { $0.name == match.leagueName }) {
                result.append(SportLotteryLeagueModel(name: match.leagueName, color: match.color))
            }
        }
        return result
    }

    /// 根据原始对阵按天分组
    private func matchGroupByDate() -> [MatchGroup] {
        let matchList = filterByLeague()

        var result = [MatchGroup]()
        // 按照日期分组
        for match in matchList {
            let date = Date(timeIntervalSince1970: match.matchTime)
            let day = date.string(format: "yyyy-MM-dd")
            if let index = result.index(where: { $0.day == day }) {
                result[index].matchList.append(match)
                continue
            }
            var matchGroup = MatchGroup()
            matchGroup.day = day
            matchGroup.weekday = "星期\(date.getWeekday().cn)"
            matchGroup.matchList = [match]
            result.append(matchGroup)
        }
        return result
    }

    /// 根据原始对阵按期号分组
    private func matchGroupByIssue() -> [MatchGroup] {
        let matchList = filterByLeague()

        var result = [MatchGroup]()
        // 按照期号
        for match in matchList {
            let issue = match.issue
            if let index = result.index(where: { $0.day == issue }) {
                result[index].matchList.append(match)
                continue
            }
            let date = TSUtils.stringToTimestamp(string: "\(issue) 00:00:00", withFormat: "yyyy-MM-dd HH:mm:ss") ?? Date()
            var matchGroup = MatchGroup()
            matchGroup.day = issue
            matchGroup.weekday = "星期\(date.getWeekday().cn)"
            matchGroup.matchList = [match]
            result.append(matchGroup)
        }
        return result
    }

    /// 按照联赛过滤
    private func filterByLeague() -> [MatchType] {
        // 一个联赛不选等于全选
        let leagueList = selectedLeagueList.isEmpty ? originalLeagueList : selectedLeagueList
        let isSelectedAllLeague = leagueList.count == originalLeagueList.count

        // 符合显示联赛的对阵
        let matchList = isSelectedAllLeague ? originalMatchList : originalMatchList.filter {
            match in
            return leagueList.contains(where: { $0.name == match.leagueName })
        }
        return matchList
    }

    struct MatchGroup {
        /// 日期
        var day = ""
        /// 星期
        var weekday = ""
        /// 展开
        var isExpand = true
        /// 对阵列表
        var matchList = [MatchType]()
    }

    enum GroupSortType {
        /// 期号分组
        case issue
        /// 日期分组
        case date
    }
}

/// 联赛mode
struct SportLotteryLeagueModel {
    var name: String
    var color: UIColor
}

