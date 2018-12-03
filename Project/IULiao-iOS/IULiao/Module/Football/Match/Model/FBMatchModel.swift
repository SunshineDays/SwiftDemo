//
//  FBMatchModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球赛事
struct FBMatchModel: FBBaseMatchModelProtocol {
    
    var json: JSON
    
    /// mid
    var mid: Int
    
    ////竞彩id
    var xid: Int
    
    ////比赛状态
    var state: FBLiveStateType
    ///竞彩让球
    var letball: Int
    ///竞彩开售 1:非让 2:让球 3:非让和让
    var opensale: Int
    
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
    
    /// 比赛类型
    var oName: String
    
    var timeStr: String? {
        let created = self.json["mtime"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timeMonthDayHourMinute(created,withFormat: "yyyy-MM-dd")
    }

    var beginTimeStr: String? {
        let created = self.json["mtime"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timeMonthDayHourMinute(created,withFormat: "MM-dd HH:mm")
    }
    ///联赛id
    var lid: Int
    
    /// 主队id
    var homeTid: Int
    
    /// 客队id
    var awayTid: Int
    
    
    var color: UIColor
    
    /// 主队logo
    var homeLogo: String?
    
    /// 客队logo
    var awayLogo: String?
    
    /// 序号
    var serial: String

    
    var homeLogoUrl: URL? {
        guard let logo = homeLogo else {
            return nil
        }
        return URL(string: logo)
    }
    
    var awayLogoUrl: URL? {
        guard let logo = awayLogo else {
            return nil
        }
        return URL(string: logo)
    }

    init(json: JSON) {
        self.json = json
        mid  = json["mid"].intValue
        xid = json["xid"].intValue
        state = FBLiveStateType(rawValue: json["state"].intValue)
        letball = json["letball"].intValue
        opensale = json["opensale"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeScore = json["hscore"].int
        awayScore = json["ascore"].int
        matchTime = json["mtime"].doubleValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
        homeLogo = json["hlogo"].stringValue
        awayLogo = json["alogo"].stringValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        serial = json["serial"].stringValue
        lid = json["lid"].intValue
        oName = json["oname"].stringValue
        if let c = json["color"].string {
            color = UIColor(rgba: c)
        } else {
            color = UIColor.black
        }
    }
    
}
