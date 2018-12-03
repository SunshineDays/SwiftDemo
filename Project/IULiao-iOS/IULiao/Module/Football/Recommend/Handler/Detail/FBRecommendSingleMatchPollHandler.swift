//
//  FBRecommendSingleMatchPollHandler.swift
//  IULiao
//
//  Created by levine on 2017/8/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSingleMatchPollHandler: BaseHandler {
    //score 打分 -1:踩 1:赞   // 资源id
    func sendPoll(module: ModuleAttentionType, resourceId: Int, score: Int, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.commonPollVote(resourceId: resourceId, module: module, score: score)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
}
