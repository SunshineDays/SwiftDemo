//
// Created by levine on 2018/5/3.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 购买列表
struct UserOrderBuyListModel: BaseModelProtocol {
    var json: JSON
    var list: [UserSingleOrderModel]
    var pageInfo: TSPageInfoModel

    init(json: JSON) {
        self.json = json
        list = json["list"].arrayValue.map {
            return UserSingleOrderModel(json: $0)
        }
        pageInfo = TSPageInfoModel(json: json["page_info"])
    }
}

/// 购买单个订单
struct UserSingleOrderModel: BaseModelProtocol {
    var json: JSON
    var buy: UserBuyModel
    var order: OrderModel

    init(json: JSON) {
        self.json = json
        buy = UserBuyModel(json: json["buy"])
        order = OrderModel(json: json["order"])
    }
}
