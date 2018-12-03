
//
//  FBRecommendSponsorMatchBetModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSponsorMatchBetModel: BaseModelProtocol {
    var json: JSON
    
    var match: FBRecommendSponsorMatchBetMatchModel
    
    var asiaList: [FBRecommendSponsorMatchBetAsiaModel]
    
    var europeList: [FBRecommendSponsorMatchBetEuropeModel]
    
    var daXiaoList: [FBRecommendSponsorMatchBetDaXiaoModel]
    
    required init(json: JSON) {
        self.json = json
        match = FBRecommendSponsorMatchBetMatchModel.init(json: json["match"])
        asiaList = json["asia_list"].arrayValue.map {FBRecommendSponsorMatchBetAsiaModel.init(json: $0)}
        europeList = json["europe_list"].arrayValue.map {FBRecommendSponsorMatchBetEuropeModel.init(json: $0)}
        daXiaoList = json["daxiao_list"].arrayValue.map {FBRecommendSponsorMatchBetDaXiaoModel.init(json: $0)}
    }
}



class FBRecommendSponsorMatchBetMatchModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var mid: Int
    
    var home: String
    
    var away: String
    
    var hTid: Int
    
    var aTid: Int
    
    var mTime: Int
    
    var lid: Int
    
    var lName: String
    
    var color: String
    
    var hScore: Int
    
    var aScore: Int
    
    var state: Int
    
    var isBeiDan: Int
    
    var isJingCai: Int

    var exchange: Int
    /// 主队logo
    var hLogo: String
    /// 客队logo
    var aLogo: String
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        mid = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        hTid = json["htid"].intValue
        aTid = json["atid"].intValue
        mTime = json["mtime"].intValue
        lid = json["lid"].intValue
        lName = json["lname"].stringValue
        color = json["color"].stringValue
        hScore = json["hscore"].intValue
        aScore = json["ascore"].intValue
        state = json["state"].intValue
        isBeiDan = json["is_beidan"].intValue
        isJingCai = json["is_jingcai"].intValue
        exchange = json["exchange"].intValue
        hLogo = json["hlogo"].stringValue
        aLogo = json["alogo"].stringValue
    }
}

/// 亚盘
class FBRecommendSponsorMatchBetAsiaModel: BaseModelProtocol {
    var json: JSON
    /// 主队
    var above: Double
    /// 盘口
    var bet: String
    /// 客队
    var below: Double
    
    var type: String
    /// 盘口秒杀
    var handicap: String
    
    required init(json: JSON) {
        self.json = json
        above = json["above"].doubleValue
        bet = json["bet"].stringValue
        below = json["below"].doubleValue
        type = json["type"].stringValue
        handicap = json["handicap"].stringValue
    }
}

/// 欧赔
class FBRecommendSponsorMatchBetEuropeModel: BaseModelProtocol {
    var json: JSON
    /// 让球数
    var letBall: Int
    /// 主胜
    var win: Double
    /// 平局
    var draw: Double
    /// 主负
    var lost: Double
    
    required init(json: JSON) {
        self.json = json
        letBall = json["letball"].intValue
        win = json["win"].doubleValue
        draw = json["draw"].doubleValue
        lost = json["lost"].doubleValue
    }
}

/// 大小球
class FBRecommendSponsorMatchBetDaXiaoModel: BaseModelProtocol {
    var json: JSON
    /// 小球
    var small: Double
    /// 盘口
    var bet: String
    /// 大球
    var big: Double
    /// 盘口秒杀
    var handicap: String
    
    required init(json: JSON) {
        self.json = json
        small = json["small"].doubleValue
        bet = json["bet"].stringValue
        big = json["big"].doubleValue
        handicap = json["handicap"].stringValue
    }
}
