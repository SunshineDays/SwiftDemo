//
// Created by levine on 2018/4/27.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

//支付方式列表
class UserRechargeHandler: BaseHandler {

    ///支付方式列表
    func rechargeList(success: @escaping ([UserRechargeModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.userRechargeList
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in

                    var lists = [UserRechargeModel]()

                    for listJson in json.arrayValue {
                        lists.append(UserRechargeModel(json: listJson))
                    }

                    success(lists)
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }

    ///申请充值
    func rechargeApply(key: String, money: Double, success: @escaping ((_ rechargeUrl: String) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userRechargeApply(key: key, money: money)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    success(json["url"].stringValue)
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }
}
