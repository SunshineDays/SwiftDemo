//
//  FBLeagueRankHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


/// 联赛 排行榜
class FBLeagueRankHandler: BaseHandler {

    override init() {
        super.init()
    }

    /// 获取联赛 亚盘排行榜
    func getRankAsia(leagueId: Int, seasonId: Int?, success: @escaping ((FBLeagueRankAsiaDataModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueRankAsia(leagueId: leagueId, seasonId: seasonId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 7200,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let all = json["all"].arrayValue.map({ FBLeagueRankAsiaModel(json: $0) }),
                                home = json["home"].arrayValue.map({ FBLeagueRankAsiaModel(json: $0) }),
                                away = json["away"].arrayValue.map({ FBLeagueRankAsiaModel(json: $0) })
                        let asia = FBLeagueRankAsiaDataModel(all: all, home: home, away: away)

                        DispatchQueue.main.async {
                            success(asia)
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

    /// 获取联赛 大小球排行榜
    func getRankBigSmall(leagueId: Int, seasonId: Int?, success: @escaping ((FBLeagueRankBigSmallDataModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueRankBigSmall(leagueId: leagueId, seasonId: seasonId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 7200,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let all = json["all"].arrayValue.map({ FBLeagueRankBigSmallModel(json: $0) }),
                                home = json["home"].arrayValue.map({ FBLeagueRankBigSmallModel(json: $0) }),
                                away = json["away"].arrayValue.map({ FBLeagueRankBigSmallModel(json: $0) })
                        let bigSmall = FBLeagueRankBigSmallDataModel(all: all, home: home, away: away)

                        DispatchQueue.main.async {
                            success(bigSmall)
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

    /// 获取联赛 积分排行榜
    func getRankScore(leagueId: Int, seasonId: Int?, success: @escaping ((FBLeagueRankScoreDataModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLeagueRankScore(leagueId: leagueId, seasonId: seasonId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 7200,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let result = FBLeagueRankScoreDataModel(json: json)
                        DispatchQueue.main.async {
                            success(result)
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
