//
//  UserRealNameInfoModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON


struct UserRealNameInfoModel {
    
    
    /// 银行支行
    var bankBranch :String
    
    ///银行-市
    var bankCityId :Int
    
    ///银行- 省
    var bankProvinceId :Int
    
    /// 银行id
    var bankId:Int
    
    ///身份证号码
    var cardCode : String
    
    var createTime: String
    
    var updateTime : String

    var id:Int
    
    /// 真实姓名
    var realName :String
    
    ///用户id
    var userId :Int
    
    
    init(json :JSON) {
        
        realName    = json["real_name"].stringValue
        userId      = json["user_id"].intValue
        bankBranch  = json["bank_branch"].stringValue
        id          = json["id"].intValue
        bankId      = json["bank_id"].intValue
        cardCode    = json["card_code"].stringValue
        bankCityId  = json["bank_city"].intValue
        bankProvinceId = json["bank_province"].intValue
        

        updateTime = TSUtils.timestampToString(json["update_time"].doubleValue)
        createTime = TSUtils.timestampToString(json["create_time"].doubleValue)
    
    }
    
}

