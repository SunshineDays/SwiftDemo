//
//  FBRecommendDetailModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/4.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendDetailModel: BaseModelProtocol {
    var json: JSON
    
    var isShow: Int
    
    var hits: Int
    
    var id: Int
    
    var mid: Int
    
    var mid2: Int
        
    var userId: Int
    
    var user: FBRecommendDetailUserModel
    
    var mTime: Int

    var mTime2: Int

    var reason: String

    var isAttention: Bool
    
    var payoff: Int
    
    var oddsType: RecommendDetailOddsType
    
    var relatives: [FBRecommendDetailRelativesModel]
    
    var odds: FBRecommend2BunchUserOddshModel

    var odds2: FBRecommend2BunchUserOddshModel
    
    var betOdds: BetOdds
    
    var betons = [BetOn]()
    var betons2 = [BetOn]()

    var match: FBRecommendSponsorMatchModel
    
    var match2: FBRecommendSponsorMatchModel

    var result: Int
    
    var pollScore: Int
    
    var created: Int
    
    var beton2: String
    
    var comments: Int
    
    var wapUrl: String
    
    var pollUp: Int
    
    var pollDown: Int

    
    
    required init(json: JSON) {
        self.json = json
        
        oddsType = RecommendDetailOddsType(rawValue: json["oddstype"].intValue)!
        
        odds = FBRecommend2BunchUserOddshModel.init(json: json["odds"])

        odds2 = FBRecommend2BunchUserOddshModel.init(json: json["odds2"])
        
        mTime = json["mtime"].intValue
        
        isShow = json["isshow"].intValue
        
        hits = json["hits"].intValue
        
        mid2 = json["mid2"].intValue
                
        relatives = json["relatives"].arrayValue.map {FBRecommendDetailRelativesModel.init(json: $0)}
        
        id = json["id"].intValue
        
        userId = json["userid"].intValue
        
        isAttention = json["isattention"].boolValue
        
        payoff = json["payoff"].intValue
        
        user = FBRecommendDetailUserModel.init(json: json["user"])
        
        mTime2 = json["mtime2"].intValue
        
        reason = json["reason"].stringValue
        
        betons = json["betons"].arrayValue.map { BetOn(json: $0) }

        mid = json["mid"].intValue
        
        match2 = FBRecommendSponsorMatchModel(json: json["match2"])
        
        beton2 = json["betons2"].stringValue
        
        result = json["result"].intValue
        
        pollScore = json["pollscore"].intValue
        
        created = json["created"].intValue
        
        betons2 = json["betons2"].arrayValue.map { BetOn(json: $0) }

        pollDown = json["polldown"].intValue
        
        comments = json["comments"].intValue
        
        wapUrl = json["wapurl"].stringValue
        
        pollUp = json["pollup"].intValue
        
        match = FBRecommendSponsorMatchModel.init(json: json["match"])
        
        betOdds = BetOdds(json: json["odds"])
    }
    
}


class FBRecommendDetailRelativesModel: BaseModelProtocol {
    var json: JSON
    
    var module: String
    
    var title: String
    
    var id: Int
    
    var url: String
    
    required init(json: JSON) {
        self.json = json
        
        module = json["module"].stringValue
        
        title = json["title"].stringValue
        
        id = json["id"].intValue
        
        url = json["url"].stringValue
        
    }
}


class FBRecommendDetailUserModel: BaseModelProtocol {
    var json: JSON
    
    var follow: Int
    
    var order10PayoffPercent: Double
    
    var nickname: String
    
    var payoffPercent: Double
    
    var orderCount: Int
    
    var day7PayoffPercent: Double
    
    var win: Int
    
    var lostHalf: Int
    
    var winHalf: Int
    
    var id: Int
    
    var skilledOddsType: RecommendDetailOddsType
    
    var keepWin: Int
    
    var draw: Int
    
    var hitPercent: Double
    
    var avatar: String
    
    var skilledLeague: String
    
    var lost: Int
    
    var isAttention: Bool
    
    required init(json: JSON) {
        self.json = json
        
        follow = json["follow"].intValue
        
        order10PayoffPercent = json["order10payoffpercent"].doubleValue
        
        nickname = json["nickname"].stringValue
        
        payoffPercent = json["payoffpercent"].doubleValue
        
        orderCount = json["ordercount"].intValue
        
        day7PayoffPercent = json["day7payoffpercent"].doubleValue
        
        win = json["win"].intValue
        
        lostHalf = json["losthalf"].intValue
        
        winHalf = json["winhalf"].intValue
        
        id = json["id"].intValue
        
        skilledOddsType = RecommendDetailOddsType(rawValue: json["skilledoddstype"].intValue)!
        
        keepWin = json["keepwin"].intValue
        
        draw = json["draw"].intValue
        
        hitPercent = json["hitpercent"].doubleValue
        
        avatar = json["avatar"].stringValue
        
        skilledLeague = json["skilledleague"].stringValue
        
        lost = json["lost"].intValue
        
        isAttention = json["isattention"].boolValue
    }
}





class FBRecommendDetailMatchModel: BaseModelProtocol {
    var json: JSON
    
    var state: Int
    
    var exchange: Int
    
    var mid: Int
    
    var away: String
    
    var mTime: Int
    
    var isJingCai: Int
    
    var home: String
    
    var hScore: Int
    
    var isBeiDan: Int
    
    var color: String
    
    var id: Int
    
    var hLogo: String
    
    var lName: String
    
    var lid: Int
    
    var aTid: Int
    
    var aLogo: String
    
    var aScore: Int
    
    var hTid: Int
    
    required init(json: JSON) {
        self.json = json
        
        state = json["state"].intValue
        
        exchange = json["exchange"].intValue
        
        mid = json["mid"].intValue
        
        away = json["away"].stringValue
        
        mTime = json["mtime"].intValue
        
        isJingCai = json["is_jingcai"].intValue
        
        home = json["home"].stringValue
        
        hScore = json["hscore"].intValue
        
        isBeiDan = json["is_beidan"].intValue
        
        color = json["color"].stringValue
        
        id = json["id"].intValue
        
        hLogo = json["hlogo"].stringValue
        
        lName = json["lname"].stringValue
        
        lid = json["lid"].intValue
        
        aTid = json["atid"].intValue
        
        aLogo = json["alogo"].stringValue
        
        aScore = json["ascore"].intValue
        
        hTid = json["htid"].intValue
    }
}

