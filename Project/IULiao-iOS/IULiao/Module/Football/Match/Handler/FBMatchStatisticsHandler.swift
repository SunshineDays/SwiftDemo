//
//  FBMatchInfoHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事 统计信息
class FBMatchStatisticsHandler: BaseHandler {

    func getStatistics(
            matchId: Int,
            lottery: Lottery?,
            success: @escaping ((_ matchInfo: FBMatchModel, _ statistics: FBMatchStatisticsModel) -> Void),
            failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbMatchStatistics(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 60,
                success: {
                    (json) -> Void in
                    let match = FBMatchModel(json: json["match"])
                    let statistics = FBMatchStatisticsModel(json: json["statistics"])
                    success(match, statistics)
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

}
