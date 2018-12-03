//
// Created by tianshui on 2018/4/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 竞彩足球
class JczqHandler: BaseHandler {

    func getMatchList(success: @escaping ((_ data: SLDataModel<JczqMatchModel>) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleJczqMatchList
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let matchList = json["list"].arrayValue.map {
                            return JczqMatchModel(json: $0)
                        }
                        var data = SLDataModel<JczqMatchModel>()
                        data.groupSortType = .issue
                        data.originalMatchList = matchList
                        DispatchQueue.main.async {
                            success(data)
                        }
                    }
                },
                failed: {
                    error in
                    failed(error)
                    return false
                })
    }
    
    ///  主客队历史记录
    func getMatchTeamHistory(matchId: Int, success: @escaping ((_ model: JczqMatchTeamHistoryModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleJczqTeamHistoryInfo(matchId: matchId)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = JczqMatchTeamHistoryModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}
