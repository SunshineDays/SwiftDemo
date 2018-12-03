//
// Created by levine on 2018/5/18.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 复制跟单
class CopyOrderHandler: BaseHandler {
    /// 复制跟单列表
    func getCopyOrderList(page: Int, pageSize: Int, success: @escaping ((_ copyOrderList: [CopyOrderModel], _ pageInfo: TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.copayOrderList(page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    let copyOrderList = json["list"].arrayValue.map {
                        return CopyOrderModel(json: $0)
                    }
                    let pageInfo = TSPageInfoModel(json: json["page_info"])
                    success(copyOrderList, pageInfo)
                },
                failed: {
                    error in
                    failed(error)
                    return false
                })

    }

    /// 跟单购买
    func orderBuy(orderId: Int, multiple: Int, totalMoney: Double, success: @escaping ((_ account: UserAccountModel, _ order: OrderModel, _ buy: UserBuyModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.copyOrderBuy(orderId: orderId, multiple: multiple, totalMoney: totalMoney)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let account = UserAccountModel(json: json["account"])
                        let order = OrderModel(json: json["order"])
                        let buy = UserBuyModel(json: json["buy"])
                        DispatchQueue.main.async {
                            success(account, order, buy)
                        }
                    }
                },
                failed: {
                    error in
                    failed(error)
                    return true
                }
        )


    }

}
