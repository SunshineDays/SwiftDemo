//
//  FBLeagueStageHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/10/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


/// 联赛 阶段
class FBLeagueStageHandler: BaseHandler {
    
    override init() {
        super.init()
    }
    
    /// 获取阶段 列表
    func getStageList(leagueId: Int, seasonId: Int?, success: @escaping (([FBLeagueStageModel]) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueStageList(leagueId: leagueId, seasonId: seasonId)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 7200,
            success: {
                json in
                
                DispatchQueue.global().async {
                    let stages = json["stages"].arrayValue.map { FBLeagueStageModel(json: $0) }
                    
                    DispatchQueue.main.async {
                        success(stages)
                    }
                }
        },
            failed: {
                error -> Bool in
                failed(error)
                return false
        })
    }
    
    /// 获取阶段 赛事
    func getStageMatch(
        leagueId: Int,
        seasonId: Int?,
        stageId: Int?,
        groupId: Int?,
        success: @escaping (([FBMatchModel]) -> Void),
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbLeagueStageMatch(leagueId: leagueId, seasonId: seasonId, stageId: stageId, groupId: groupId)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 7200,
            success: {
                json in
                
                DispatchQueue.global().async {
                    let matchs = json["matchs"].arrayValue.map({ FBMatchModel(json: $0) })
                    
                    DispatchQueue.main.async {
                        success(matchs)
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
