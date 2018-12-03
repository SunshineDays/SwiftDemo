//
//  FBRecommend2BunchModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 推荐 2串1
class FBRecommend2BunchModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var nickname: String
    
    var avatar: String
    
    var orderCount: Int
    
    var order10: FBRecommendExpertOddsTypeDetailModel
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        nickname = json["nickname"].stringValue
        avatar = json["avatar"].stringValue
        orderCount = json["ordercount"].intValue
        order10 = FBRecommendExpertOddsTypeDetailModel.init(json: json["order10"])
    }
}

