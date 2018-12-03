//
//  UserLiaoHandler.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/20.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

class UserLiaoHandler: BaseHandler {
    /// 获取料豆充值价目表
    func getLiaoRechargeData(success: @escaping (_ model: UserLiaoRechargeModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.liaoRechargeList
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = UserLiaoRechargeModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 获取交易流水
    func getLiaoPayFlowData(page: Int, success: @escaping (_ model: UserLiaoPayFlowModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.liaoPayFlow(page: page, pageSize: 20)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = UserLiaoPayFlowModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
}
