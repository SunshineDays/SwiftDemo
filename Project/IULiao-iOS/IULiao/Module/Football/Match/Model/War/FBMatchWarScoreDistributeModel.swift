//
//  FBMatchWarScoreDistributeModel.swift
//  IULiao
//
//  Created by tianshui on 2017/12/14.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 赛事分析 进失球
struct FBMatchWarScoreDistributeModel: BaseModelProtocol {

    var json: JSON
    
    var home: [ScoreDistribute]
    
    var away: [ScoreDistribute]
    
    init(json: JSON) {
        self.json = json
        home = json["home"].arrayValue.map { ScoreDistribute(json: $0) }
        away = json["away"].arrayValue.map { ScoreDistribute(json: $0) }
    }
    
    struct ScoreDistribute {
        
        /// 赛事
        var match: FBBaseMatchModel
        
        /// 进球事件
        var goalEventList: [Event]
        
        /// 失球事件
        var fumbleEventList: [Event]
        
        init(json: JSON) {
            match = FBBaseMatchModel(json: json["match"])
            goalEventList = json["goal_events"].arrayValue.map { Event(json: $0) }
            fumbleEventList = json["fumble_events"].arrayValue.map { Event(json: $0) }
        }
        
    }
    
    struct Event {
        
        /// 比分
        var score: String
        
        /// 事件时间
        var time: Int
        
        init(json: JSON) {
            score = json["score"].stringValue
            time = json["time"].intValue
        }
    }
}
