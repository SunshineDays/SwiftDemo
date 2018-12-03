//
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 赔率
class FBMatchOddsHandler: BaseHandler {

    /// 欧赔列表
    func getEuropeList(
        matchId: Int,
        lottery: Lottery?,
        success: @escaping (_ match: FBMatchModel, _ odds: FBMatchOddsEuropeDataModel) -> Void,
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchEuropeOdds(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let oddsList = json["odds"].arrayValue.map {
                            subJson -> FBOddsEuropeSetModel in
                            let companyJson = subJson["company"]
                            let company = CompanyModel(cid: companyJson["id"].intValue, name: companyJson["name"].stringValue, companyType: CompanyModel.CompanyType(rawValue: companyJson["type"].intValue) ?? .none)
                            let initOdds = FBOddsEuropeModel(json: subJson["init"])
                            let lastOdds = FBOddsEuropeModel(json: subJson["last"])
                            let result = FBOddsEuropeSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                            return result
                        }
                        // 最大 最小 平均(百家) 竞彩
                        var maxData: (win: Double, draw: Double, lost: Double) = (0, 0, 0)
                        var minData: (win: Double, draw: Double, lost: Double) = (0, 0, 0)
                        var totalData: (win: Double, draw: Double, lost: Double) = (0, 0, 0)
                        var jingcaiOdds = FBOddsEuropeModel(win: 0, draw: 0, lost: 0)

                        for (index, odds) in oddsList.enumerated() {
                            let lastOdds = odds.lastOdds
                            let win = lastOdds.win
                            let draw = lastOdds.draw
                            let lost = lastOdds.lost

                            if index == 0 {
                                maxData = (win, draw, lost)
                                minData = (win, draw, lost)
                            }
                            if maxData.win < win {
                                maxData.win = win
                            }
                            if maxData.draw < draw {
                                maxData.draw = draw
                            }
                            if maxData.lost < lost {
                                maxData.lost = lost
                            }
                            if minData.win > win && win > 0 {
                                minData.win = win
                            }
                            if minData.draw > draw && draw > 0 {
                                minData.draw = draw
                            }
                            if minData.lost > lost && lost > 0 {
                                minData.lost = lost
                            }
                            totalData = (totalData.win + win, totalData.draw + draw, totalData.lost + lost)

                            // 竞彩
                            if odds.company.id == 10000 {
                                jingcaiOdds = lastOdds
                            }
                        }

                        let count = max(1, Double(oddsList.count))
                        let maxOdds = FBOddsEuropeModel(win: maxData.win, draw: maxData.draw, lost: maxData.lost)
                        let minOdds = FBOddsEuropeModel(win: minData.win, draw: minData.draw, lost: minData.lost)
                        let europe99Odds = FBOddsEuropeModel(win: totalData.win / count, draw: totalData.draw / count, lost: totalData.lost / count)

                        let data = FBMatchOddsEuropeDataModel(oddsList: oddsList, europe99Odds: europe99Odds, minOdds: minOdds, maxOdds: maxOdds, jingcaiOdds: jingcaiOdds)
                        DispatchQueue.main.async {
                            success(match, data)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 欧赔详细(历史)
    func getEuropeHistory(
            matchId: Int,
            companyId: Int,
            lottery: Lottery?,
            success: @escaping (_ match: FBMatchModel, _ company: CompanyModel, _ oddsList: [FBOddsEuropeModel]) -> Void,
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchEuropeHistory(matchId: matchId, companyId: companyId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        var oddsList = json["odds"].arrayValue.map { FBOddsEuropeModel(json: $0) }
                        let company = CompanyModel(cid: json["company"]["id"].intValue, name: json["company"]["name"].stringValue)
                        oddsList = oddsList.sorted(by: { $0.time > $1.time })
                        DispatchQueue.main.async {
                            success(match, company, oddsList)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 欧赔相同赔率
    func getEuropeSameOdds(
            matchId: Int,
            companyId: Int,
            lottery: Lottery?,
            success: @escaping (_ match: FBMatchModel, _ europeSame: FBMatchOddsEuropeSameModel) -> Void,
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchEuropeSame(matchId: matchId, companyId: companyId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 60,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let europeSame = FBMatchOddsEuropeSameModel(json: json)

                        DispatchQueue.main.async {
                            success(match, europeSame)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 亚盘列表
    func getAsiaList(
        matchId: Int,
        lottery: Lottery?,
        success: @escaping (_ match: FBMatchModel, _ oddsList: [FBOddsAsiaSetModel]) -> Void,
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchAsiaOdds(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in

                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let oddsList = json["odds"].arrayValue.map {
                        subJson -> FBOddsAsiaSetModel in
                        let companyJson = subJson["company"]
                        let company = CompanyModel(cid: companyJson["id"].intValue, name: companyJson["name"].stringValue, companyType: CompanyModel.CompanyType(rawValue: companyJson["type"].intValue) ?? .none)
                        let initOdds = FBOddsAsiaModel(json: subJson["init"])
                        let lastOdds = FBOddsAsiaModel(json: subJson["last"])
                        let result = FBOddsAsiaSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                        return result
                    }

                    DispatchQueue.main.async {
                        success(match, oddsList)
                    }
                }
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

    /// 亚盘详细(历史)
    func getAsiaHistory(
            matchId: Int,
            companyId: Int,
            lottery: Lottery?,
            success: @escaping (_ match: FBMatchModel, _ company: CompanyModel, _ oddsList: [FBOddsAsiaModel]) -> Void,
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchAsiaHistory(matchId: matchId, companyId: companyId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        var oddsList = json["odds"].arrayValue.map { FBOddsAsiaModel(json: $0) }
                        let company = CompanyModel(cid: json["company"]["id"].intValue, name: json["company"]["name"].stringValue)
                        oddsList = oddsList.sorted(by: { $0.time > $1.time })

                        DispatchQueue.main.async {
                            success(match, company, oddsList)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 亚盘相同盘口
    func getAsiaSameOdds(
            matchId: Int,
            companyId: Int,
            lottery: Lottery?,
            success: @escaping (_ match: FBMatchModel, _ asiaSame: FBMatchOddsAsiaSameModel) -> Void,
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchAsiaSame(matchId: matchId, companyId: companyId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 60,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let asiaSame = FBMatchOddsAsiaSameModel(json: json)

                        DispatchQueue.main.async {
                            success(match, asiaSame)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 大小球列表
    func getBigSmallList(
        matchId: Int,
        lottery: Lottery?,
        success: @escaping (_ match: FBMatchModel, _ oddsList: [FBOddsBigSmallSetModel]) -> Void,
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchBigSmallOdds(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in

                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let oddsList = json["odds"].arrayValue.map {
                        subJson -> FBOddsBigSmallSetModel in
                        let companyJson = subJson["company"]
                        let company = CompanyModel(cid: companyJson["id"].intValue, name: companyJson["name"].stringValue, companyType: CompanyModel.CompanyType(rawValue: companyJson["type"].intValue) ?? .none)
                        let initOdds = FBOddsBigSmallModel(json: subJson["init"])
                        let lastOdds = FBOddsBigSmallModel(json: subJson["last"])
                        let result = FBOddsBigSmallSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                        return result
                    }

                    DispatchQueue.main.async {
                        success(match, oddsList)
                    }
                }
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

    /// 大小球详细(历史)
    func getBigSmallHistory(
            matchId: Int,
            companyId: Int,
            lottery: Lottery?,
            success: @escaping (_ match: FBMatchModel, _ company: CompanyModel, _ oddsList: [FBOddsBigSmallModel]) -> Void,
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchBigSmallHistory(matchId: matchId, companyId: companyId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        var oddsList = json["odds"].arrayValue.map { FBOddsBigSmallModel(json: $0) }
                        let company = CompanyModel(cid: json["company"]["id"].intValue, name: json["company"]["name"].stringValue)
                        oddsList = oddsList.sorted(by: { $0.time > $1.time })
                        
                        DispatchQueue.main.async {
                            success(match, company, oddsList)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 波胆(比分)列表
    func getScoreList(
        matchId: Int,
        lottery: Lottery?,
        success: @escaping (_ match: FBMatchModel, _ oddsList: [FBOddsScoreSetModel]) -> Void,
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchScoreOdds(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in

                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let oddsList = json["odds"].arrayValue.map {
                        subJson -> FBOddsScoreSetModel in
                        let companyJson = subJson["company"]
                        let company = CompanyModel(cid: companyJson["id"].intValue, name: companyJson["name"].stringValue, companyType: CompanyModel.CompanyType(rawValue: companyJson["type"].intValue) ?? .none)
                        let initOdds = FBOddsScoreModel(json: subJson["init"])
                        let lastOdds = FBOddsScoreModel(json: subJson["last"])
                        let result = FBOddsScoreSetModel(company: company, initOdds: initOdds, lastOdds: lastOdds)
                        return result
                    }

                    DispatchQueue.main.async {
                        success(match, oddsList)
                    }
                }
        },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

    /// 必发赔率
    func getBetfairOdds(
        matchId: Int,
        lottery: Lottery?,
        success: @escaping (_ match: FBMatchModel, _ betfairData: FBMatchOddsBetfairDataModel) -> Void,
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchBetfairOdds(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in

                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let betfairData = FBMatchOddsBetfairDataModel(json: json)
                    DispatchQueue.main.async {
                        success(match, betfairData)
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
