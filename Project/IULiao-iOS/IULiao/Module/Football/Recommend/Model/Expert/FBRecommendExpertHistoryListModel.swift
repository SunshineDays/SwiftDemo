//
//  FBRecommendExpertHistoryListModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/12.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 专辑历史推荐
class FBRecommendExpertHistoryListModel: BaseModelProtocol {
    
    var json: JSON
    
    var oddsType: RecommendDetailOddsType
    
    var reason: String
    
    var mTime2: Int
    
    var mid: Int
    
    var mTime: Int
    
    var match: FBRecommendSponsorMatchModel
    
    var match2: FBRecommendSponsorMatchModel
    
    var odds: FBRecommend2BunchUserOddshModel
    
    var odds2: FBRecommend2BunchUserOddshModel
    
    var betOdds: BetOdds
    
    var betons = [BetOn]()
    var betons2 = [BetOn]()
    
    var isShow: Int
    
    var result: GuessResultType
    
    var hits: Int
    
    var mid2: Int
    
    var id: Int
    
    var created: Int
    
    var beton2: String
    
    var pollDown: Int
    
    var userId: Int
    
    var comments: Int
    
    var payoff: Double
    
    var pollUp: Int
    
    

    required init(json: JSON) {
        self.json = json
        
        
        oddsType = RecommendDetailOddsType(rawValue: json["oddstype"].intValue)!
        
        odds = FBRecommend2BunchUserOddshModel.init(json: json["odds"])
        odds2 = FBRecommend2BunchUserOddshModel.init(json: json["odds2"])
        
        match = FBRecommendSponsorMatchModel.init(json: json["match"])
        match2 = FBRecommendSponsorMatchModel.init(json: json["match2"])

        betOdds = BetOdds(json: json["odds"])
        betons = json["betons"].arrayValue.map { BetOn(json: $0) }
        betons2 = json["betons2"].arrayValue.map { BetOn(json: $0) }

        reason = json["reason"].stringValue
        
        mTime2 = json["mtime2"].intValue
        
        
        mid = json["mid"].intValue
        mTime = json["mtime"].intValue
        isShow = json["isshow"].intValue
        result = GuessResultType.init(rawValue: json["result"].intValue)
        hits = json["hits"].intValue
        mid2 = json["mid2"].intValue
        id = json["id"].intValue
        created = json["created"].intValue
        beton2 = json["beton2"].stringValue
        pollDown = json["polldown"].intValue
        userId = json["userid"].intValue
        comments = json["comments"].intValue
        payoff = json["payoff"].doubleValue
        pollUp = json["pollup"].intValue
    }
    
    
}

class FBRecommendexpertHistoryListBetonsModel: BaseModelProtocol {
    var json: JSON
    
    var betKey: String
    
    var sp: Double
    
    required init(json: JSON) {
        self.json = json
        
        betKey = json["betkey"].stringValue
        
        sp = json["sp"].doubleValue
        
    }
}

/// 投注内容
struct BetOn {
    var betKey: BetKeyType
    /// 投注赔率
    var sp: Double
    
    /// 投注key
    enum BetKeyType: String {
        case win, draw, lost
        case letWin = "letwin", letDraw = "letdraw", letLost = "letlost"
        case above, below
        case big, handicap, small
        case none
        
        var name: String {
            switch self {
            case .win: return "胜"
            case .draw: return "平"
            case .lost: return "负"
            case .letWin: return "让胜"
            case .letDraw: return "让平"
            case .letLost: return "让负"
            case .above: return "主"
            case .below: return "客"
            case .big: return "大球"
            case .handicap: return "平"
            case .small: return "小球"
            case .none: return ""
            }
        }
    }
    
    init(betKey: BetKeyType, sp: Double) {
        self.betKey = betKey
        self.sp = sp
    }
    
    init(json: JSON) {
        betKey = BetKeyType(rawValue: json["betkey"].stringValue) ?? .none
        sp = json["sp"].doubleValue
    }
}

/// 投注赔率
struct BetOdds {
    /// 让球
    var letBall = 0
    /// 竞彩开售情况
    var openSale: OpenSaleType
    /// 竞彩非让球赔率
    var jingcaiNormal: FBOddsEuropeModel
    /// 竞彩让球赔率
    var jingcaiLetball: FBOddsEuropeModel
    /// 亚盘
    var asia: FBOddsAsiaModel
    /// 大小球
    var bigSmall: FBOddsBigSmallModel
    /// 欧赔
    var europe: FBOddsEuropeModel
    
    init(json: JSON) {
        letBall = json["letball"].intValue
        jingcaiNormal = FBOddsEuropeModel(win: json["win"].doubleValue, draw: json["draw"].doubleValue, lost: json["lost"].doubleValue)
        jingcaiLetball = FBOddsEuropeModel(win: json["letwin"].doubleValue, draw: json["letdraw"].doubleValue, lost: json["letlost"].doubleValue)
        asia = FBOddsAsiaModel(above: json["above"].doubleValue, below: json["below"].doubleValue, handicap: json["handicap"].stringValue, bet: json["bet"].intValue)
        bigSmall = FBOddsBigSmallModel(big: json["big"].doubleValue, small: json["small"].doubleValue, handicap: json["handicap"].stringValue, bet: json["bet"].intValue)
        europe = FBOddsEuropeModel(win: json["win"].doubleValue, draw: json["draw"].doubleValue, lost: json["lost"].doubleValue)
        openSale = OpenSaleType(rawValue: json["opensale"].intValue) ?? .all
    }
    
    enum OpenSaleType: Int {
        /// 非让球
        case normal = 1
        /// 让球
        case letBall = 2
        /// 全部
        case all = 3
    }
}


