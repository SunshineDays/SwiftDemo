//
//  FBCountryModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 国家model
struct FBLeagueCountryModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int
    
    /// 国家
    var name: String
    
    /// 国家logo
    var logo: String
    
    /// 国家下属联赛
    var leagues: [FBLeagueModel]
    
    init(json: JSON) {
        self.json = json
        id  = json["id"].intValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
        
        leagues = json["leagues"].arrayValue.map { FBLeagueModel(json: $0) }
    }
}
