//
//  FBLiveLeagueModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 比分联赛模型
struct FBLiveLeagueModel: FBBaseLeagueModelProtocol {
    
    var json: JSON
    
    /// lid
    var lid: Int
    
    /// 联赛名
    var name: String
    
    /// 联赛颜色
    var color: UIColor
    
    /// 是否选中
    var isSelected = true
    
    /// 首字母索引
    var indexCharter: String
    
    init(json: JSON) {
        self.json = json
        lid  = json["lid"].intValue
        name = json["lname"].stringValue
        if let c = json["color"].string {
            color = UIColor(rgba: c)
        } else {
            color = UIColor.black
        }
        indexCharter = json["index"].stringValue
    }
}
