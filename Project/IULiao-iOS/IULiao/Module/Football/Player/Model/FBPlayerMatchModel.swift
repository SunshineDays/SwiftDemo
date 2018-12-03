//
//  FBPlayerModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 球员
struct FBPlayerMatchModel: FBBaseMatchModelProtocol {


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

    /// 评分
    var rate: Double

    /// 等级
    var grade: Int

    /// 颜色
    var gradeColor: UIColor {
        return FBPlayerGrade(grade: grade).color
    }

    init(json: JSON) {
        self.json = json
        mid = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeScore = json["hscore"].int
        awayScore = json["ascore"].int
        matchTime = json["mtime"].doubleValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))

        rate = json["rate"].doubleValue
        grade = json["grade"].intValue
    }
}

/// 球员评分等级
struct FBPlayerGrade {
    
    /// 等级
    var grade: Int
    
    var color: UIColor {
        var hex = 0xcccccc
        switch grade {
        case 0: hex = 0x90cc90
        case 1: hex = 0x9adb16
        case 2: hex = 0xdbdb16
        case 3: hex = 0xdbcb16
        case 4: hex = 0xffcc66
        case 5: hex = 0xffbb33
        case 6: hex = 0xffaa00
        case 7: hex = 0xff9933
        case 8: hex = 0xff7f00
        case 9: hex = 0xfc7632
        case 10: hex = 0xff5500
        case 11: hex = 0xff2a00
        case 12: hex = 0xff0000
        case 13: hex = 0xcccccc
        default: break
        }
        return UIColor(hex: hex)
    }
}
