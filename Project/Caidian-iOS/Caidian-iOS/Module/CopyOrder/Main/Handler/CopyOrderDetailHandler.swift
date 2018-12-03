//
// Created by levine on 2018/5/23.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 复制跟单详情
class CopyOrderDetailHandler: BaseHandler {
    /// 跟单详情
    func orderDetail(orderId: Int, success: @escaping (_ copyOrderDetail: OrderDetailModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.copyOrderDetail(orderId: orderId)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: { json in
                    success(OrderDetailModel(json: json))
                },
                failed: { error in
                    failed(error)
                    return false
                })

    }

 
    /// 跟单用户
    func orderAccount(orderId: Int, page: Int, pageSize: Int, success: @escaping ((_ accountList: [CopyOrderAccountModel], _ pageInfo: TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.copyOrderAccount(orderId: orderId, page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: { json in
                    let list = json["list"].arrayValue.map {
                        return CopyOrderAccountModel(json: $0)
                    }
                    let pageInfo = TSPageInfoModel(json: json["page_info"])
                    success(list, pageInfo)

                },
                failed: { error in
                    failed(error)
                    return false
                })

    }
}
