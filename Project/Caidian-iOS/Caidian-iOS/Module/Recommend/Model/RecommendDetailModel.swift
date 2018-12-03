//
//  RecommendDetailModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/13.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐详情
class RecommendDetailModel: BaseModelProtocol {
    var json: JSON
    
    /// 推荐信息
    var recommend: RecommendExpertListModel
    /// 用户信息
    var order: RecommendOrderModel
    /// 对阵信息
    var statistic: RecommendStatisticModel
    /// 比赛信息
    var matchInfo: JczqMatchModel
    /// 历史修改信息列表
    var historyList = [RecommendDetailhistoryListtModel]()
    
    required init(json: JSON) {
        self.json = json
        
        recommend = RecommendExpertListModel(json: json["recommend"])
        order = RecommendOrderModel(json: json["order5"])
        statistic = RecommendStatisticModel(json: json["statistic"])
        matchInfo = JczqMatchModel(json: json["match_info"])
        
        var l = [RecommendDetailhistoryListtModel]()
        for j in json["history_list"].arrayValue {
            l.append(RecommendDetailhistoryListtModel(json: j))
        }
        historyList = l
    }
}

struct RecommendDetailhistoryListtModel {
    var json: JSON
    
    var id: Int
    
    var recommendId: Int
    
    var code = [JczqBetKeyType]()
    
    var updateTime: TimeInterval
    
    var reason: String
    
    var odds: JczqMatchModel
    
    var stage: String
    
    
    init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        recommendId = json["recommend_id"].intValue
        
        var c = [JczqBetKeyType]()
        for j in json["code"].arrayValue {
            c.append(JczqBetKeyType(key: j["betkey"].stringValue, sp: j["sp"].doubleValue)!)
        }
        code = c
        
        updateTime = json["update_time"].doubleValue
        reason = json["reason"].stringValue
        odds = JczqMatchModel(json: json["odds"])
        stage = json["stage"].stringValue
    }
}
