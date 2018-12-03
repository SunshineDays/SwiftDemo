//
//  FBRecommendSponsorMatchJingcaiModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSponsorMatchJingcaiModel: BaseModelProtocol {

    var json: JSON
    
    var id: Int
    
    var lid: Int
    
    var xid: Int
    
    var lotyId: Int
    
    var aTid: Int
    
    var exchange: Int
    
    var mTime: Int
    
    var away: String
    
    var home: String
    
    var hScore: String
    
    var aScore: String
    
    var lName: String
    
    var mType: Int
    
    var color: String
    
    var hLogo: String
    
    var aLogo: String
    
    var odds: FBRecommend2BunchUserOddshModel
    
    var serial: String
    
    var isJIngcai: Int
    
    var isBeidan: Int
    
    var spfSingle: Int
    
    var spfFixed: Int
    
    var rqspfSingle: Int
    
    var rqspfFixed: Int
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        lid = json["lid"].intValue
        xid = json["id"].intValue
        lotyId = json["lotyid"].intValue
        aTid = json["atid"].intValue
        exchange = json["exchange"].intValue
        mTime = json["mtime"].intValue
        away = json["away"].stringValue
        home = json["home"].stringValue
        hScore = json["hscore"].stringValue
        aScore = json["ascore"].stringValue
        lName = json["lname"].stringValue
        mType = json["mtype"].intValue
        color = json["color"].stringValue
        hLogo = json["hlogo"].stringValue
        aLogo = json["alogo"].stringValue
        odds = FBRecommend2BunchUserOddshModel.init(json: json["odds"])
        serial = json["serial"].stringValue
        isJIngcai = json["is_jingcai"].intValue
        isBeidan = json["is_beidan"].intValue
        spfSingle = json["spf_single"].intValue
        spfFixed = json["spf_fixed"].intValue
        rqspfSingle = json["rqspf_single"].intValue
        rqspfFixed = json["rqspf_fixed"].intValue

        
    }
    
}
