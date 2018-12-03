//
//  SLBuyHandler.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购买
class LotteryBuyHandler: BaseHandler {

    /// 购买
    func buy(buyModel: BuyModelProtocol, success: @escaping ((_ account: UserAccountModel, _ order: OrderModel, _ buy: UserBuyModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleBuy(json: buyModel.toJsonString)
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
                error -> Bool in
                failed(error)
                return true
        })
    }
}
