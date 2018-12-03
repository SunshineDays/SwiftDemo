//
//  FBBaseMatchModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBBaseMatchModelProtocol: BaseModelProtocol {
    
    /// mid
    var mid: Int {get set}
    
    /// 主队名
    var home: String {get set}
    
    /// 客队名
    var away: String {get set}
    
    /// 主队得分
    var homeScore: Int? {get set}
    
    /// 客队得分
    var awayScore: Int? {get set}
    
    /// 联赛信息
    var league: FBBaseLeagueModel {get set}
    
    /// 开赛时间
    var matchTime: TimeInterval {get set}
    
    /// 主队id
    var homeTid: Int {get set}
    
    /// 客队id
    var awayTid: Int {get set}
}

extension FBBaseMatchModelProtocol {
    
    /// id
    var id: Int {
        return mid
    }
}

/// 足球赛事 基类
struct FBBaseMatchModel: FBBaseMatchModelProtocol {
    
    var json: JSON
    
    /// mid
    var mid: Int
    
    /// 主队名
    var home: String
    
    /// 客队名
    var away: String
    
    /// 主队得分
    var homeScore: Int?
    
    /// 客队得分
    var awayScore: Int?
    
    /// 联赛信息
    var league: FBBaseLeagueModel
    
    /// 开赛时间
    var matchTime: TimeInterval
    
    /// 主队id
    var homeTid: Int
    
    /// 客队id
    var awayTid: Int
    
    init(json: JSON) {
        self.json = json
        mid  = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeScore = json["hscore"].int
        awayScore = json["ascore"].int
        matchTime = json["mtime"].doubleValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
    }
}

func ==(lhs: FBBaseMatchModelProtocol, rhs: FBBaseMatchModelProtocol) -> Bool {
    return lhs.id == rhs.id
}
