//
// Created by levine on 2018/5/4.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 交易日志
struct UserPayLogModel: BaseModelProtocol {
    var json: JSON


    var list: [UserPayLogCellModel]
    var pageInfo: PageInfoModel

    init(json: JSON) {
        self.json = json
        list = json["list"].arrayValue.map {
            subJson in
            return UserPayLogCellModel(json: subJson)
        }
        pageInfo = PageInfoModel(json: json["page_info"])

    }
}

/// 交易日志 单个model
struct UserPayLogCellModel: BaseModelProtocol {
    var json: JSON
    /// 备注
    var remark: String

    /// 交易编号
    var payCode: String

    /// 交易类型名字
    var tradeName: String

    /// 时间
    var createdTime: TimeInterval

    /// 交易类型id
    var tradeId: TradeIdType

    /// 支付金额或彩金
    var payMoney: Double

    /// 对应此记录的资源id
    var resourceId: Int

    /// 交易类型
    var inOut: InOutType

    init(json: JSON) {
        self.json = json
        remark = json["remark"].stringValue
        payCode = json["pay_code"].stringValue
        tradeName = json["trade_name"].stringValue
        createdTime = json["create_time"].doubleValue
        tradeId = TradeIdType(rawValue: json["trade_id"].intValue)!
        payMoney = json["pay_money"].doubleValue
        resourceId = json["resource_id"].intValue
        inOut = InOutType(rawValue: json["in_out"].intValue)!

    }
}
