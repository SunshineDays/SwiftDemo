//
//  PlanModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct  PlanModel: BaseModelProtocol{

    var  json :JSON

    // 计划详情id
    var  id:Int

    // 作者
    var author :String

    //标题
    var title:String

    // 跟单人数
    var followUser :Int

    // 跟单金额
    var followMoney :Double

    var detailCount :Int

    ///总中奖金额
    var totalBonus : Double
    
    var createTime :TimeInterval

    var updateTime :TimeInterval

    init(json:JSON){
        self.json = json

        self.author = json["author"].stringValue
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.followUser = json["follow_user"].intValue
        self.followMoney = json["follow_money"].doubleValue
        self.detailCount  = json["detail_count"].intValue
        self.createTime = json["create_time"].doubleValue
        self.updateTime = json["update_time"].doubleValue
        self.totalBonus = json["total_bonus"].doubleValue
    }

}
