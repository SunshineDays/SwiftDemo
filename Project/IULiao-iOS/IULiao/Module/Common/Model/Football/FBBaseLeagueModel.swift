//
//  FBBaseLeagueModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBBaseLeagueModelProtocol: BaseModelProtocol {
    
    /// lid
    var lid: Int {get set}
    
    /// 联赛名
    var name: String {get set}
    
    /// 联赛颜色
    var color: UIColor {get set}
}

extension FBBaseLeagueModelProtocol {
    
    var id: Int {
        return lid
    }
}

/// 足球联赛 基类
struct FBBaseLeagueModel: FBBaseLeagueModelProtocol {
    
    var json: JSON
    
    /// lid
    var lid: Int
    
    /// 联赛名
    var name: String
    
    /// 联赛颜色
    var color: UIColor
    
    init(lid: Int, name: String, color: UIColor = .black) {
        self.json = JSON.null
        self.lid   = lid
        self.name  = name
        self.color = color
    }
    
    init(json: JSON) {
        self.json = json
        lid  = json["id"].intValue
        name = json["name"].stringValue
        if let c = json["color"].string {
            color = UIColor(rgba: c)
        } else {
            color = UIColor.black
        }
    }
    
}

func ==(lhs: FBBaseLeagueModelProtocol, rhs: FBBaseLeagueModelProtocol) -> Bool {
    return lhs.id == rhs.id
}
