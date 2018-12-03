//
//  PlanOrderHomeModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/6/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct  PlanOrderHomeModel: BaseModelProtocol{
    
    var  json: JSON
    
    /// 小计划列表
    var list : [PlanOrderDetailModel]
 
    /// 大计划详情
    var plan :PlanModel

    // 分页详情
    
    var pageModel : TSPageInfoModel
    
    init(json: JSON) {
        self.json = json
        self.list = json["list"].arrayValue.map{return PlanOrderDetailModel(json: $0)}
        self.plan = PlanModel(json:json["plan"])
        self.pageModel = TSPageInfoModel(json: json["page_info"])
    }
    
}
