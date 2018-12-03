//
//  ForecastExpertModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 专家信息
class ForecastExpertModel: BaseModelProtocol {
    
    var json: JSON
    
    var user: ForecastExpertUserModel

    required init(json: JSON) {
        self.json = json
        user = ForecastExpertUserModel(json: json["user"])
    }
}

/// 专家个人信息
class ForecastExpertUserModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int
    
    var nickname: String
    
    var avatar: String
    
    var keepWin: Int
    
    var payoff: String
    
    var hit: Int
    
    var win: Int
    
    var follow: Int
    
    var isAttention: Bool
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        nickname = json["nickname"].stringValue
        avatar = json["avatar"].stringValue
        keepWin = json["keep_win"].intValue
        payoff = (json["payoff"].doubleValue * 100).decimal(0) + "%"
        hit = json["hit"].intValue
        win = json["win"].intValue
        follow = json["follow"].intValue
        isAttention = json["is_attention"].boolValue
    }
}
