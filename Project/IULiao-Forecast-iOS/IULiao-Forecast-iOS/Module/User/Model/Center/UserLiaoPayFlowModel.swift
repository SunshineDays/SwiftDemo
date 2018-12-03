//
//  UserLiaoPayFlowModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/27.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 交易流水
class UserLiaoPayFlowModel: BaseModelProtocol {
    var json: JSON
    
    /// 交易流水列表
    var list = [UserLiaoPayFlowListModel]()
    
    var pageInfo: PageInfoModel!
    
    required init(json: JSON) {
        self.json = json
        list = json["list"].arrayValue.map({ return UserLiaoPayFlowListModel(json: $0) })
        pageInfo = PageInfoModel(json: json["pageinfo"])
    }
}

/// 交易流水列表
class UserLiaoPayFlowListModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var userId: Int
    /// 对应的产生流水的资源id
    var resourceId: Int
    /// 流水号
    var tradeNum: String
    /// 交易类型 <0: false, >0: true
    var tradeTypeIsPlus: Bool
    /// 本次交易料豆
    var tradeCoin: Double
    /// 本次交易后剩余料豆
    var remainCoin: Double
    /// 本次交易人民币
    var money: Double
    /// 备注
    var remark: String
    /// 交易类型
    var tradeTypeName: String
    
    var createTime: TimeInterval
    
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userId = json["user_id"].intValue
        resourceId = json["resource_id"].intValue
        tradeNum = json["trade_num"].stringValue
        tradeTypeIsPlus = json["trade_type"].intValue < 0 ? false : true
        tradeCoin = json["trade_coin"].doubleValue
        remainCoin = json["remain_coin"].doubleValue
        money = json["money"].doubleValue
        remark = json["remark"].stringValue
        tradeTypeName = json["trade_type_name"].stringValue
        createTime = json["create_time"].doubleValue
    }
    
}
