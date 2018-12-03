//
//  RecommendExpertListMdel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/13.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐 专家列表页
class RecommendExpertModel: BaseModelProtocol {
    var json: JSON
    
    var list = [RecommendExpertListModel]()
    
    var pageInfo: PageInfoModel
    
    var order: RecommendOrderModel
    
    var statistic: RecommendStatisticModel
    
    required init(json: JSON) {
        self.json = json
        
        var l = [RecommendExpertListModel]()
        for j in json["list"].arrayValue {
            l.append(RecommendExpertListModel(json: j))
        }
        
        list = l
        
        pageInfo = PageInfoModel(json: json["page_info"])
        
        order = RecommendOrderModel(json: json["order5"])
        
        statistic = RecommendStatisticModel(json: json["statistic"])
    }
    
}

struct RecommendExpertListModel {
    var json: JSON
    
    var id: Int
    
    var matchId: Int
    
    var title: String
    
    var userId: Int
    
    var playType: Int
    
    var code = [JczqBetKeyType]()
    
    var codeString: String
    
    var winStatus: RecommendWinStatusType
    
    var payoff: Int
    
    var odds: JczqMatchModel
    
    var reason: String
    
    var matchTime: TimeInterval
    
    var hits: Int
    
    /// -1:已放弃(false) 1:正常(true)
    var isShow: Bool
    
    var createTime: TimeInterval
    
    var updateTime: TimeInterval
    
    var matchInfo: JczqMatchModel
    
    var serial: String
    
    var winStatusName: String
    
    var playTypeName: String
    
    /// 是否选中去购买（购物车）
    var isSelectedToBuy = false
    /// 是否选中去删除（购物车）
    var isSelectedToDelete = false
    
    init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        matchId = json["match_id"].intValue
        title = json["title"].stringValue
        userId = json["user_id"].intValue
        playType = json["play_type"].intValue

        var c = [JczqBetKeyType]()
        for j in json["code"].arrayValue {
            c.append(JczqBetKeyType(key: j["betkey"].stringValue, sp: j["sp"].doubleValue)!)
        }
        code = c
        
        codeString = json["code_string"].stringValue
        winStatus = RecommendWinStatusType(rawValue: json["win_status"].intValue) ?? .notOpen
        payoff = json["payoff"].intValue
        odds = JczqMatchModel(json: json["odds"])
        reason = json["reason"].stringValue
        matchTime = json["match_time"].doubleValue
        hits = json["hits"].intValue
        isShow = json["is_show"].intValue == -1 ? false : true
        createTime = json["create_time"].doubleValue
        updateTime = json["update_time"].doubleValue
        matchInfo = JczqMatchModel(json: json["match_info"])
        serial = json["serial"].stringValue
        winStatusName = json["win_status_name"].stringValue
        playTypeName = json["play_type_name"].stringValue

    }
}

struct RecommendCodeModel {
    var json: JSON
    
    var betKey: String
    
    var sp: Double
    
    init(json: JSON) {
        self.json = json
        
        betKey = json["betKey"].stringValue
        
        sp = json["sp"].doubleValue
    }
}


//struct RecommedOddsModel {
//    var json: JSON
//
//    var spfSp3: String
//
//    var spfSp1: String
//
//    var spfSp0: String
//
//    var rqspfSp3: String
//
//    var rqspfSp1: String
//
//    var rqspfSp0: String
//
//    var letBall: Int
//
//    init(json: JSON) {
//        self.json = json
//
//        spfSp3 = json["spf_sp3"].stringValue
//        spfSp1 = json["spf_sp1"].stringValue
//        spfSp0 = json["spf_sp0"].stringValue
//        rqspfSp3 = json["rqspf_sp3"].stringValue
//        rqspfSp1 = json["rqspf_sp1"].stringValue
//        rqspfSp0 = json["rqspf_sp0"].stringValue
//        letBall = json["let_ball"].intValue
//    }
//}

struct RecommendStatisticModel {
    var json: JSON
    
    var userId: Int
    
    var payoff: Double
    
    var orderCount: Int
    
    var keepWin: Int
    
    var keepLost: Int



    var win: Int


    var lost: Int
    
    var name: String
    
    var avatar: String

    
    init(json: JSON) {
        self.json = json
        
        userId = json["user_id"].intValue
        payoff = json["payoff"].doubleValue
        orderCount = json["order_count"].intValue
        keepWin = json["keep_win"].intValue
        keepLost = json["keep_lost"].intValue
        win = json["win"].intValue
        lost = json["lost"].intValue
        name = json["name"].stringValue
        avatar = json["avatar"].stringValue
    }
    
}
