//
// Created by levine on 2018/4/28.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 提现列表（单个订单）
struct UserWithDrawModel: BaseModelProtocol {
    var json: JSON

    var codeNum: String
    var createdTime: TimeInterval
    var money: Double
    var remark: String

    var status: OrderStatus

    init(json: JSON) {
        self.json = json
        codeNum = json["order_num"].stringValue
        createdTime = json["create_time"].doubleValue
        money = json["money"].doubleValue
        remark = json["remark"].stringValue

        status = OrderStatus(rawValue: json["status"].intValue) ?? .none
    }
}

/// 提现列表
struct UserWithDrawListModel: BaseModelProtocol {
    var json: JSON
    var list: [UserWithDrawModel]
    var pageInfo: PageInfoModel

    init(json: JSON) {
        self.json = json
        list = json["list"].arrayValue.map {
            subJson in
            return UserWithDrawModel(json: subJson)
        }
        pageInfo = PageInfoModel(json: json["page_info"])
    }
}

/// 提现状态
enum OrderStatus: Int, CustomStringConvertible {
    case none = 0
    case success = 1
    case failed = -1
    case refuse = -2

    var description: String {
        switch self {
        case .success: return "提现成功"
        case .none: return "进行中"
        case .refuse: return " 系统驳回"
        default: return "提现失败"
        }
    }

    init(description: String) {
        switch description {
        case "成功":
            self = .success
        case "失败":
            self = .failed
        case"系统驳回":
            self = .refuse
        default:
            self = .none
        }
    }

    var color: UIColor {
        switch self {
        case .success: return UIColor(hex: 0x009933)
        case .failed,.refuse: return UIColor.logo
        default: return UIColor.grayGamut.gamut333333
        }
    }
}
