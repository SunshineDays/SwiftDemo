//
//  FBRecommendExpertModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON


class FBOddsTypeShowModel: BaseModelProtocol {
    var json: JSON
        
    required init(json: JSON) {
        self.json = json
    }
}

/// 专家推荐详情
class FBRecommendExpertModel: BaseModelProtocol {

    var json: JSON
    
    var user: FBRecommendExpertUserModel
    
    var daxiao: FBRecommendExpertOddsTypeModel
    
    var jingCaiSingle: FBRecommendExpertOddsTypeModel

    var jingCaiSerial: FBRecommendExpertOddsTypeModel

    var asia: FBRecommendExpertOddsTypeModel
    
    var football: FBRecommendExpertOddsTypeModel
    
    var jingCai: FBRecommendExpertOddsTypeModel

    var europe: FBRecommendExpertOddsTypeModel
    
    
    var oddsTypeShow: FBOddsTypeShowModel
    

    required init(json: JSON) {
        self.json = json
        user = FBRecommendExpertUserModel.init(json: json["user"])
        daxiao = FBRecommendExpertOddsTypeModel.init(json: json["daxiao"])
        jingCaiSingle = FBRecommendExpertOddsTypeModel.init(json: json["jingcai_single"])
        jingCaiSerial = FBRecommendExpertOddsTypeModel.init(json: json["jingcai_serial"])
        asia = FBRecommendExpertOddsTypeModel.init(json: json["asia"])
        football = FBRecommendExpertOddsTypeModel.init(json: json["football"])
        jingCai = FBRecommendExpertOddsTypeModel.init(json: json["jingcai"])
        europe = FBRecommendExpertOddsTypeModel.init(json: json  ["europe"])
        
        oddsTypeShow = FBOddsTypeShowModel.init(json: json)
    }
    
}

class FBRecommendExpertUserModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var skilledOddsType: RecommendDetailOddsType
    
    var keepWin: Int
    
    var follow: Int
    
    var avatar: String
    
    var nickname: String
    
    var skilledLeague: String
    
    var isAttention: Bool
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        skilledOddsType = RecommendDetailOddsType(rawValue: json["skilledoddstype"].intValue)!
        keepWin = json["keepwin"].intValue
        follow = json["follow"].intValue
        avatar = json["avatar"].stringValue
        nickname = json["nickname"].stringValue
        skilledLeague = json["skilledleague"].stringValue
        isAttention = json["isattention"].boolValue
    }
    
    
}

class FBRecommendExpertOddsTypeModel: BaseModelProtocol {
    var json: JSON
    
    var day7: FBRecommendExpertOddsTypeDetailModel
    
    var all: FBRecommendExpertOddsTypeDetailModel
    
    var order10: FBRecommendExpertOddsTypeDetailModel
    
    required init(json: JSON) {
        self.json = json
        day7 = FBRecommendExpertOddsTypeDetailModel.init(json: json["day7"])
        all = FBRecommendExpertOddsTypeDetailModel.init(json: json["all"])
        order10 = FBRecommendExpertOddsTypeDetailModel.init(json: json["order10"])
    }
    
}

class FBRecommendExpertOddsTypeDetailModel: BaseModelProtocol {
    var json: JSON
    
    var oddsType: Int
    
    var payoffPercent: Double
    
    var lastOrderTime: Int
    
    var orderCount: Int
    
    var win: Int
    
    var currentKeepWin: Int
    
    var currentKeepLost: Int
    
    var lostHalf: Int
    
    var winHalf: Int
    
    var results: String
    
    var keepwin: Int
    
    var region: String
    
    var draw: Int
    
    var hitPercent: Double
    
    var keepLost: Int
    
    var lost: Int
    
    var payoff: Double
    
    required init(json: JSON) {
        self.json = json
        oddsType = json["oddstype"].intValue
        payoffPercent = json["payoffpercent"].doubleValue
        lastOrderTime = json["lastordertime"].intValue
        orderCount = json["ordercount"].intValue
        win = json["win"].intValue
        currentKeepWin = json["currentkeepwin"].intValue
        currentKeepLost = json["currentkeeplost"].intValue
        lostHalf = json["losthalf"].intValue
        winHalf = json["winhalf"].intValue
        results = json["results"].stringValue
        keepwin = json["keepwin"].intValue
        region = json["region"].stringValue
        draw = json["draw"].intValue
        hitPercent = json["hitpercent"].doubleValue
        keepLost = json["keeplost"].intValue
        lost = json["lost"].intValue
        payoff = json["payoff"].doubleValue
    }
    
}
