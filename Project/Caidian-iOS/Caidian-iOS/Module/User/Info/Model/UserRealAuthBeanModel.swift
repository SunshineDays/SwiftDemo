//
//  UserRealAuthBeanModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON


struct UserRealAuthBeanModel {
    var json: JSON

    ///银行支行
    var bankBranch: String

    ///银行市Id
    var bankCity: Int

    ///银行
    var bankCode: String

    ///
    var bankId: Int

    ///银行省份ID
    var bankProvince: Int

    ///身份证号码
    var cardCode: String

    ///实名认证时间
    var createTime: String

    ///id
    var id: Int

    ///真实姓名
    var realName: String

    ///修改时
    var updateTime: String
    
    /// 中间加 * 号的真实姓名
    var secretRealName: String {
        return realName[0 ..< 1] + "****"
    }

    /// 中间加 * 号的省份信息
    var secretCardCode: String {
        return cardCode[0..<4] + "****" + cardCode[(cardCode.count-4)..<(cardCode.count)]
    }

    ///用户id
    var userId: Int

    init(json: JSON) {
        self.json = json

        id = json["id"].intValue
        cardCode = json["card_code"].stringValue
        realName = json["real_name"].stringValue
        userId = json["user_id"].intValue
        bankId = json["bank_id"].intValue
        bankCity = json["bank_city"].intValue
        bankCode = json["bank_code"].stringValue
        bankProvince = json["bank_province"].intValue
        bankBranch = json["bank_branch"].stringValue
        updateTime = TSUtils.timestampToString(json["update_time"].doubleValue)
        createTime = TSUtils.timestampToString(json["create_time"].doubleValue)
        
    
    }



}
