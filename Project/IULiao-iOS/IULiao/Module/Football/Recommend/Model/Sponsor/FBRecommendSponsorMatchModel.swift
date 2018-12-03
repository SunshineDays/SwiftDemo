//
//  FBRecommendSponsorMatchModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSponsorMatchModel: BaseModelProtocol {
    var json: JSON

    var id: Int
    /// 联赛id
    var mid: Int
    /// 主队名
    var home: String
    /// 客队名
    var away: String
    /// 主队ID
    var hTid: Int
    /// 客队ID
    var aTid: Int
    
    var xid: Int
    
    var lotyId: Int

    /// 联赛ID
    var lid: Int
    /// 时间
    var mTime: Int
    /// 时间场次
    var serial: String
    /// 让球数
    var letBall: Int
    
    /// 联赛名
    var lName: String
    /// 联赛名颜色
    var color: String
    /// 主队得分
    var hScore: String
    /// 客队得分
    var aScore: String
    /// 主队logo
    var hLogo: String
    /// 客队logo
    var aLogo: String
    /// 状态
    var state: Int
    /// 北单
    var isBeiDan: Int
    /// 竞彩
    var isJingCai: Int

    var exchange: Int
    /// 是否已投注亚盘玩法
    var isBetAsia: Bool
    /// 是否已投注欧赔玩法
    var isBetEurope: Bool
    /// 是否已投注大小玩法
    var isBetDaXiao: Bool
    
    var orderCount: Int
    /// 胜平负
    var spfSingle: Int
    var spfFixed: Int
    /// 让球胜平负
    var rqspfSingle: Int
    var rqspfFixed: Int
    
    var odds: FBRecommend2BunchUserOddshModel
    /// 自定义模型（记录选中状态）
    var selectedType: MatchJingcaiSelectedType
        
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        mid = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        hTid = json["htid"].intValue
        aTid = json["atid"].intValue
        xid = json["xid"].intValue
        lotyId = json["lotyid"].intValue
        mTime = json["mtime"].intValue
        serial = json["serial"].stringValue
        letBall = json["letball"].intValue
        lid = json["lid"].intValue
        lName = json["lname"].stringValue
        color = json["color"].stringValue
        hScore = json["hscore"].stringValue
        aScore = json["ascore"].stringValue
        aLogo = json["alogo"].stringValue
        hLogo = json["hlogo"].stringValue
        serial = json["serial"].stringValue
        state = json["state"].intValue
        isBeiDan = json["is_beidan"].intValue
        isJingCai = json["is_jingcai"].intValue
        exchange = json["exchange"].intValue
        isBetAsia = json["is_bet_asia"].boolValue
        isBetEurope = json["is_bet_europe"].boolValue
        isBetDaXiao = json["is_bet_daxiao"].boolValue
        orderCount = json["ordercount"].intValue
        spfSingle = json["spf_single"].intValue
        spfFixed = json["spf_fixed"].intValue
        rqspfSingle = json["rqspf_single"].intValue
        rqspfFixed = json["rqspf_fixed"].intValue
        odds = FBRecommend2BunchUserOddshModel.init(json: json["odds"])
        selectedType = MatchJingcaiSelectedType()
    }
}


/// 投注赔率
struct MatchJingcaiSelectedType {
    
    var isWin = false
    
    var isDraw = false
    
    var isLost = false
    
    var isLetWin = false
    
    var isLetDraw = false
    
    var isLetLost = false

}



