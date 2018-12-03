//
//  FBRecommend2TodayNewsModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/19.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 推荐 今日推荐 按比赛找
class FBRecommend2TodayNewsFromMatchModel: BaseModelProtocol {
    var json: JSON
    
    var state: Int
    
    var exchange: Int
    
    var mid: Int
    
    var away: String
    
    var mTime: Int
    
    var isJingCai: Int
    
    var home: String
    
    var hScore: String
    
    var orderCount: Int
    
    var isBeiDan: Int
    
    var color: String
    
    var id: Int
    
    var hLogo: String
    
    var lName: String
    
    var lid: Int
    
    var aTid: Int
    
    var aLogo: String
    
    var aScore: String
    
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
        hScore = json["hscore"].stringValue
        orderCount = json["ordercount"].intValue
        isBeiDan = json["is_beidan"].intValue
        color = json["color"].stringValue
        id = json["id"].intValue
        hLogo = json["hlogo"].stringValue
        lName = json["lname"].stringValue
        lid = json["lid"].intValue
        aTid = json["atid"].intValue
        aLogo = json["alogo"].stringValue
        aScore = json["ascore"].stringValue
        hTid = json["htid"].intValue

    }
    
    
    
}
