//
//  FBLeagueSeasonModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛 赛季
struct FBLeagueSeasonModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int {
        get { return sid }
        set { sid = newValue }
    }
    
    /// sid
    var sid: Int
    
    /// 赛季名
    var name: String

    /// 短名字
    var shortName: String {
        let n = name.replacingOccurrences(of: "-", with: "/")
        let pattern = "20(\\d{2})"
        let regexp = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: n.count)
        return regexp.stringByReplacingMatches(in: n, options: .reportProgress, range: range, withTemplate: "$1")
    }
    
    /// 球队总数
    var teamCount: Int?
    
    /// 赛季总轮次
    var allRound: Int?
    
    /// 赛季当前轮次
    var currentRound: Int?
    
    init(json: JSON) {
        self.json = json
        sid  = json["sid"].intValue
        name = json["sname"].stringValue
        teamCount = json["teams"].int
        allRound = json["round"].int
        currentRound = json["currentround"].int
    }
}
