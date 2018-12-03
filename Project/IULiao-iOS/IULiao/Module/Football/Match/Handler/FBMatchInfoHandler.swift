//
//  FBMatchInfoHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事详情
class FBMatchInfoHandler: BaseHandler {
    
    func getMatchInfo(matchId: Int, lottery: Lottery?, success: @escaping ((FBMatchModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchInfo(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 60,
            success: {
                (json) -> Void in
                let match = FBMatchModel(json: json)
                success(match)
            },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }

}
