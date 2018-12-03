//
//  ForecastOrderModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/17.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

class ForecastOrderModel: BaseModelProtocol {
    var json: JSON

    var id: Int
    
    var forecastId: Int
    ///订单编号
    var orderNum: String
    
    var userId: Int
    
    var price: Double
    ///定价
    var pay: Double
    /// 是否退款
    var isRefunc: Bool
    
    var createTime: TimeInterval
    
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        forecastId = json["forecast_id"].intValue
        orderNum = json["order_num"].stringValue
        userId = json["user_id"].intValue
        price = json["price"].doubleValue
        pay = json["pay"].doubleValue
        isRefunc = json["is_refund"].intValue == 1 ? true : false
        createTime = json["create_time"].doubleValue
    }
    
}
