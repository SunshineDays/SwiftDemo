//
//  UserLiaoRechargeModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/20.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 料豆充值
class UserLiaoRechargeModel: BaseModelProtocol {
    var json: JSON
    
    /// 充值价目表
    var priceList = [UserLiaoRechargePriceListModel]()
    
    required init(json: JSON) {
        self.json = json
        priceList = json["price_list"].arrayValue.map({ return UserLiaoRechargePriceListModel(json: $0) })
    }
}

/// 充值价目表d
class UserLiaoRechargePriceListModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    /// 价格
    var money: Double
    /// 料豆数量
    var coin: Double
    /// 赠送个数
    var present: Double

    var isShow: Bool
    
    var createTime: TimeInterval
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        money = json["money"].doubleValue
        coin = json["coin"].doubleValue
        present = json["present"].doubleValue
        isShow = json["is_show"].intValue == 1 ? true : false
        createTime = json["create_time"].doubleValue
    }
}
