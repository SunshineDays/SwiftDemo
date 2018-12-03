//
//  FBLeagueModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛model
struct FBLeagueModel: FBBaseLeagueModelProtocol {
    
    var json: JSON
    
    var id: Int {
        get { return lid }
        set { lid = newValue }
    }
    
    /// lid
    var lid: Int
    
    /// 联赛名
    var name: String
    
    /// 联赛颜色
    var color: UIColor
    
    /// 联赛logo
    var logo: String
    
    /// 完整赛季名
    var fullName: String?
    
    init(lid: Int, name: String, color: UIColor, logo: String = "") {
        self.init(json: JSON(NSNull()))
        self.lid   = lid
        self.name  = name
        self.color = color
        self.logo = logo
    }
    
    init(json: JSON) {
        self.json = json
        lid  = json["id"].intValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
        fullName = json["fullname"].string
        
        if let c = json["color"].string {
            color = UIColor(rgba: c)
        } else {
            color = UIColor.black
        }
    }
}
