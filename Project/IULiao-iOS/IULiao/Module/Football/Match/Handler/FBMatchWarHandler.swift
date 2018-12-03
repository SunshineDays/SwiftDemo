//
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 战绩
class FBMatchWarHandler: BaseHandler {

    typealias WarBlock = (_ matchInfo: FBMatchModel, _ homeMatchList: [FBMatchWarModel], _ awayMatchList: [FBMatchWarModel]) -> Void

    /// 近期战绩
    func getRecentMatch(matchId: Int, lottery: Lottery?, success: @escaping WarBlock, failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarRecent(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let home = json["home"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        let away = json["away"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        DispatchQueue.main.async {
                            success(match, home, away)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 未来赛事
    func getFutureMatch(matchId: Int, lottery: Lottery?, success: @escaping WarBlock, failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarFuture(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let home = json["home"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        let away = json["away"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        DispatchQueue.main.async {
                            success(match, home, away)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 相同盘口
    func getSameHandicapMatch(matchId: Int, lottery: Lottery?, success: @escaping WarBlock, failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarSameHandicap(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let home = json["home"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        let away = json["away"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        DispatchQueue.main.async {
                            success(match, home, away)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 历史交锋
    func getVersusMatch(matchId: Int, lottery: Lottery?, success: @escaping ((_ matchInfo: FBMatchModel, _ versus: [FBMatchWarModel]) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarVersus(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let versus = json["versus"].arrayValue.map {
                            FBMatchWarModel(json: $0)
                        }
                        DispatchQueue.main.async {
                            success(match, versus)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }
    
    /// 积分榜
    func getRankScore(matchId: Int, lottery: Lottery?, success: @escaping ((_ matchInfo: FBMatchModel, _ rankScore: FBLeagueRankScoreDataModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarRankScore(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in
                
                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let rankScore = FBLeagueRankScoreDataModel(json: json)
                    DispatchQueue.main.async {
                        success(match, rankScore)
                    }
                }
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }
    
    /// 进失球
    func getScoreDistribute(matchId: Int, lottery: Lottery?, success: @escaping ((_ matchInfo: FBMatchModel, _ scoreDistribute: FBMatchWarScoreDistributeModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchWarScoreDistribute(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 60,
            success: {
                (json) -> Void in
                
                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    var scoreDistribute = FBMatchWarScoreDistributeModel(json: json)
                    scoreDistribute.home.sort { $0.match.matchTime > $1.match.matchTime }
                    scoreDistribute.away.sort { $0.match.matchTime > $1.match.matchTime }
                    
                    DispatchQueue.main.async {
                        success(match, scoreDistribute)
                    }
                }
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }
}
