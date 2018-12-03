//
// Created by levine on 2018/5/3.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 购彩
class UserOrderBuyHandler: BaseHandler {
    /// 购买列表
    func buyList(buyType: OrderBuyType, page: Int, pageSize: Int, sinceTime: Int? = nil, success: @escaping((_ buyListModel: UserOrderBuyListModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userOrderBuyList(buyType: buyType, page: page, pageSize: pageSize, sinceTime: sinceTime)
        defaultRequestManager.request(router: router, expires: 0, success: {
            json in
            DispatchQueue.global().async {
                let listModel = UserOrderBuyListModel(json: json)
                DispatchQueue.main.async {
                    success(listModel)
                }
            }

        }, failed: {
            error in
            failed(error)
            return true
        })

    }

    
    /// 用户购买订单详情
    ///
    /// - Parameters:
    ///   - buyId: 购买id
    ///   - success:
    ///   - failed:
    func getDetail(buyId: Int, success: @escaping((_ orderDetail: OrderDetailModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userOrderDetail(orderBuyId: buyId)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let orderDetail = OrderDetailModel(json: json)
                        DispatchQueue.main.async {
                            success(orderDetail)
                        }
                    }

                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }
}
