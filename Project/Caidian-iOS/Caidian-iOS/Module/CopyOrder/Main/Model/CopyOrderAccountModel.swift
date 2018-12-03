//
// Created by levine on 2018/5/24.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 跟单用户
struct CopyOrderAccountModel: BaseModelProtocol {
    var json: JSON

    /// 跟单金额
    var totalMoney: Double
    


    /// 跟单用户
    var userName: String

    
    /// 跟单时间
    var createdTime: TimeInterval

    init(json: JSON) {
        self.json = json
        totalMoney = json["total_money"].doubleValue
        userName = json["user_name"].stringValue
        createdTime = json["create_time"].doubleValue
    }
}
