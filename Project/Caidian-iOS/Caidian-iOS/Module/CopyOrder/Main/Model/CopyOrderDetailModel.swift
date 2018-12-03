//
// Created by levine on 2018/5/24.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CopyOrderDetailModel:BaseModelProtocol {
    var json: JSON

    /// 用户信息
    var copy:CopyOrderModel

    /// 订单信息
    var order: OrderModel

    init(json: JSON) {
        self.json = json
        copy = CopyOrderModel(json: json["copy"])
        order = OrderModel(json: json["order"])

    }
}
