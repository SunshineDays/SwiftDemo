//
// Created by levine on 2018/4/27.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserRechargeModel: BaseModelProtocol {
    var json: JSON

    var description: String
    var id: Int
    var key: String
    var logo: String
    /// 显示名
    var name: String //显示名

    /// 最大金额
    var maxAmount: Double

    /// 是否是初始支付方式
    var isRecommend: Bool

    init(json: JSON) {
        self.json = json
        description = json["description"].stringValue
        id = json["id"].intValue
        key = json["key"].stringValue
        logo = json["logo"].stringValue
        name = json["name"].stringValue
        maxAmount = json["max_amount"].doubleValue
        isRecommend = json["is_recommend"].boolValue
    }


}
