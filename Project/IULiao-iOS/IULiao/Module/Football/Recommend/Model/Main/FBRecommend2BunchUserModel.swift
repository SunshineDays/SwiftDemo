//
//  FBRecommend2BunchUserModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 推荐 2串1
class FBRecommend2BunchUserModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var mid: Int
    
    var mid2: Int
    
    var userId: Int
    
    var oddstype: RecommendDetailOddsType
    
    var beton2: String
    
    var result: Int
    
    var payoff: Int
    
    var odds: FBRecommend2BunchUserOddshModel
    
    var odds2: FBRecommend2BunchUserOddshModel
    
    var reason: String
    
    var mTime: Int
    
    var mTime2: Int
    
    var comments: Int
    
    var hits: Int
    
    var pollUp: Int
    
    var pollDown: Int
    
    var isShow: Int
    
    var created: Int
    
    var betons = [BetOn]()

    var betons2 = [BetOn]()
    
    var match: FBRecommendSponsorMatchModel
    
    var match2: FBRecommendSponsorMatchModel
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        mid = json["mid"].intValue
        mid2 = json["mid2"].intValue
        userId = json["userid"].intValue
        oddstype = RecommendDetailOddsType(rawValue: json["oddstype"].intValue)!
        beton2 = json["beton2"].stringValue
        result = json["result"].intValue
        payoff = json["payoff"].intValue
        odds = FBRecommend2BunchUserOddshModel.init(json: json["odds"])
        odds2 = FBRecommend2BunchUserOddshModel.init(json: json["odds2"])
        reason = json["reason"].stringValue
        mTime = json["mtime"].intValue
        mTime2 = json["mtime2"].intValue
        comments = json["comments"].intValue
        hits = json["hits"].intValue
        pollUp = json["pollup"].intValue
        pollDown = json["polldown"].intValue
        isShow = json["isshow"].intValue
        created = json["created"].intValue
        betons = json["betons"].arrayValue.map { BetOn(json: $0) }
        betons2 = json["betons2"].arrayValue.map { BetOn(json: $0) }
        match = FBRecommendSponsorMatchModel.init(json: json["match"])
        match2 = FBRecommendSponsorMatchModel.init(json: json["match2"])

    }
    
}


class FBRecommend2BunchUserOddshModel: BaseModelProtocol {
    var json: JSON
    
    var letBall: Int
    
    var win: Double
    
    var draw: Double
    
    var lost: Double
    
    var letWin: Double
    
    var letDraw: Double
    
    var letLost: Double
    
    
    required init(json: JSON) {
        self.json = json
        letBall = json["letball"].intValue
        win = json["win"].doubleValue
        draw = json["draw"].doubleValue
        lost = json["lost"].doubleValue
        letWin = json["letwin"].doubleValue
        letDraw = json["letdraw"].doubleValue
        letLost = json["letlost"].doubleValue

    }
    
}
