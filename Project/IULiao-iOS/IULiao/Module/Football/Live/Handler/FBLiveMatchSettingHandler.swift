//
//  FBLiveMatchSettingHandler.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/16.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 系统推送设置
class FBLiveMatchSettingHandler: BaseHandler {
    func getSettingData(success: @escaping (FBLiveSettingModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbLiveSettingList
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    success(FBLiveSettingModel(json: json))
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
    func postSettingData(liveStart: Int, liveHalf: Int, liveOver: Int, liveGoal: Int, liveRed: Int, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbLiveSettingEdit(liveStart: liveStart, liveHalf: liveHalf, liveOver: liveOver, liveGoal: liveGoal, liveRed: liveRed)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
}
