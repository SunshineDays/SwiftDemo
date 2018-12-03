//
//  MatchBetonModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 投注内容
class JczqBetonModel: BaseModelProtocol {
    var json: JSON
    
    var betKey: JczqBetKeyType
    
    var sp: Double
    
    required init(json: JSON) {
        self.json = json
        
        betKey = JczqBetKeyType(key: json["bet_key"].stringValue, sp: json["sp"].doubleValue) ?? .spf_sp0(sp: 0.00)
        sp = json["sp"].doubleValue
    }
    
}
