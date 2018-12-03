//
//  BankModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BankModel {

    
    var json :JSON
    
    // 银行id
    var id :Int
    
    //银行名称
    var name :String
    
    //英银行logo
    var logo :String?
    
    var isKill :Bool
    
    init(json:JSON) {
        
        self.json = json

        id     = json["id"].intValue
        name   = json["name"].stringValue
        logo   = json["logo"].stringValue
        isKill = json["is_kill"].boolValue
        
    }
    
}
