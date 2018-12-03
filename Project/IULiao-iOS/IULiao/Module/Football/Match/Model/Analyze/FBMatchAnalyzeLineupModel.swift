//
//  FBMatchAnalyzeLineupModel.swift
//  IULiao
//
//  Created by tianshui on 2017/12/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 赛事分析 赛况 阵容
struct FBMatchAnalyzeLineupModel: BaseModelProtocol {

    var json: JSON
    
    var home: Lineup
    
    var away: Lineup
    
    init(json: JSON) {
        self.json = json
        home = Lineup(json: json["home"])
        away = Lineup(json: json["away"])
    }
    
    struct Lineup {
        /// 首发
        var first: [[Player]]
        /// 替补
        var backup: [Player]
        /// 阵型
        var formation: String
        
        init(json: JSON) {
            formation = json["formation"].stringValue
            backup = json["backup"].arrayValue.map { Player(json: $0) }
            first = json["first"].arrayValue.map {
                $0.arrayValue.map {
                    Player(json: $0)
                }
            }
        }
    }
    
    struct Player {
        
        var id: Int {
            get { return pid }
            set { pid = newValue }
        }
        var pid: Int
        /// 球员
        var name: String
        /// 号码
        var number: Int?
        /// 评分
        var rate: Double
        /// 评分等级
        var grade: FBPlayerGrade
        
        init(json: JSON) {
            pid  = json["pid"].intValue
            name = json["name"].stringValue
            rate = json["rate"].doubleValue
            grade = FBPlayerGrade(grade: json["grade"].intValue)
            
            let number = json["number"].intValue
            self.number = number > 0 ? number : nil
        }
    }
}
