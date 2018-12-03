//
// Created by tianshui on 2017/11/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 球队
class FBTeamHandler: BaseHandler {

    override init() {
        super.init()
    }

    /// 球队详情
    func getDetail(teamId: Int, success: @escaping((FBTeamDetailModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbTeamDetail(teamId: teamId)
        defaultRequestManager.requestWithRouter(router, expires: 3600, success: { (json) in
            DispatchQueue.global().async {
                let detail = FBTeamDetailModel.init(json: json)
                DispatchQueue.main.async {
                    success(detail)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    
    /// 球队阵容
    func getLineup(teamId: Int, success: @escaping(([FBTeamLinupModel]) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbTeamLineup(teamId: teamId)
        defaultRequestManager.requestWithRouter(router, expires: 3600, success: { (json) in
            DispatchQueue.global().async {
                let playerList = json.arrayValue.map { FBPlayerModel(json: $0) }
                var lineupList = [FBTeamLinupModel]()
                // 按球员位置分组
                for player in playerList {
                    if let index = lineupList.index(where: { $0.point == player.point }) {
                        lineupList[index].playerList.append(player)
                    } else {
                        let lineup = FBTeamLinupModel(point: player.point, pointName: player.pointName, playerList: [player])
                        lineupList.append(lineup)
                    }
                }
                lineupList.sort(by: { (a, b) -> Bool in
                    return a.point < b.point
                })
                DispatchQueue.main.async {
                    success(lineupList)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }

    /// 新闻列表
    func getNewsList(
            teamId: Int,
            page: Int,
            pageSize: Int,
            success: @escaping(([NewsModel], TSPageInfoModel) -> Void),
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbTeamNews(teamId: teamId, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 3600,
                success: {
                    json in

                    DispatchQueue.global().async {
                        var list = [NewsModel]()
                        for subJson in json["list"].arrayValue {
                            let obj = NewsModel(json: subJson)
                            list.append(obj)
                        }
                        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
                        DispatchQueue.main.async {
                            success(list, pageInfo)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }
    
    /// 球队赛程
    ///
    /// - Parameters:
    ///   - teamId: 球队id
    ///   - success: 请求成功
    ///   - failed: 请求失败
    func getSchedule(teamId: Int, success: @escaping((FBTeamScheduleModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbTeamSchedule(teamId: teamId)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 3600,
            success: {
                json in
                
                DispatchQueue.global().async {
                    let matchList = json.arrayValue.map { FBLiveMatchModel(json: $0) }
                    var over = [FBLiveMatchModel]()
                    var future = [FBLiveMatchModel]()
                    
                    for match in matchList {
                        if match.homeScore != nil && match.awayScore != nil {
                            over.append(match)
                        } else {
                            future.append(match)
                        }
                    }
                    
                    over.sort {
                        a, b -> Bool in
                        return a.matchTime > b.matchTime
                    }
                    future.sort {
                        a, b -> Bool in
                        return a.matchTime > b.matchTime
                    }
                    if let near = future.popLast() {
                        over.insert(near, at: 0)
                    }
                    
                    let schedule = FBTeamScheduleModel(overMatchList: over, futureMatchList: future )
                    DispatchQueue.main.async {
                        success(schedule)
                    }
                }
        },
            failed: {
                error -> Bool in
                failed(error)
                return false
        })
    }
}
