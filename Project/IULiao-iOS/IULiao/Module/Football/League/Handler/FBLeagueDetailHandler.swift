//
//  FBLeagueDetailHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


/// 联赛详情
class FBLeagueDetailHandler: BaseHandler {

    override init() {
        super.init()
    }

    /// 获取联赛详情
    func getDetail(leagueId: Int, seasonId: Int?, success: @escaping ((FBLeagueDetailModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueDetail(leagueId: leagueId, seasonId: seasonId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 7200,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let detail = FBLeagueDetailModel(json: json)
                        DispatchQueue.main.async {
                            success(detail)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                }
        )
    }

    /// 获取赛季列表
    func getSeasonList(leagueId: Int, success: @escaping ((FBLeagueModel, [FBLeagueSeasonModel]) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueSeasonList(leagueId: leagueId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 12 * 3600,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let league = FBLeagueModel(json: json)
                        let seasons = json["seasons"].arrayValue.map { FBLeagueSeasonModel(json: $0) }
                        DispatchQueue.main.async {
                            success(league, seasons)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                }
        )
    }

}
