//
// Created by levine on 2018/4/28.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

///提现记录
class UserWithdrawHandler: BaseHandler {
    ///提现记录列表
    func drawList(page: Int, pageSize: Int,success: @escaping ((_ drawListmodel: UserWithDrawListModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userWithDrawList(page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    print(json)
                    success(UserWithDrawListModel(json: json))
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }

    ///申请提现
    func apply(money: Double, success: @escaping((_ userAccount: UserAccountModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userWithDrawApply(money: money)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    print(json)
                    success(UserAccountModel(json: json))
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }
}
