//
//  FBPlayerModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 球员 详情
struct FBPlayerDetailModel: BaseModelProtocol {

    var json: JSON

    /// 球员信息
    var playerInfo: FBPlayerModel

    /// 当前俱乐部
    var clubInfo: Club

    /// 球员技能
    var skill: Skill

    /// 转会历史
    var transferList: [Transfer]
    
    init(json: JSON) {
        self.json = json

        playerInfo = FBPlayerModel(json: json["player_info"])
        clubInfo = Club(json: json["team_info"])
        skill = Skill(json: json["skill"])
        transferList = json["transfers"].arrayValue.map { Transfer(json: $0) }
    }

    /// 俱乐部
    struct Club {

        var name: String
        var logo: String

        /// 身价
        var estimatedValue: Int

        /// 合同到期
        var contractDeadline: String

        init(json: JSON) {
            name = json["name"].stringValue
            logo = json["logo"].stringValue
            estimatedValue = json["estimatedvalue"].intValue
            contractDeadline = json["contractdeadline"].stringValue
        }
    }

    /// 技能
    struct Skill {

        /// 场上位置
        var positions: [(en: String, cn: String)]

        /// 优势
        var advantages: [String]

        /// 劣势
        var disadvantages: [String]

        init(json: JSON) {
            advantages = json["advantages"].arrayValue.map { $0.stringValue }
            disadvantages = json["disadvantages"].arrayValue.map { $0.stringValue }
            positions = json["positions"].arrayValue.map {
                (en: $0["en"].stringValue, cn: $0["cn"].stringValue)
            }
        }
    }

    /// 转会信息
    struct Transfer {

        var seasonName: String
        
        var beginDateString: String
        var beginDate: Foundation.Date? {
            return TSUtils.stringToTimestramp(str: beginDateString, withFormat: "yyyy-MM-dd")
        }
        
        var endDateString: String
        var endDate: Foundation.Date? {
            return TSUtils.stringToTimestramp(str: beginDateString, withFormat: "yyyy-MM-dd")
        }

        /// 价格(身价)
        var money: Int

        /// 转会类型
        var category: String

        /// 转入球队
        var inTeam: FBTeamModel

        /// 转出球队
        var outTeam: FBTeamModel

        init(json: JSON) {
            seasonName = json["sname"].stringValue
            beginDateString = json["begintime"].stringValue
            endDateString = json["endtime"].stringValue
            money = json["money"].intValue

            category = json["description"].stringValue
            inTeam = FBTeamModel(json: json["inteam"])
            outTeam = FBTeamModel(json: json["outteam"])
        }

    }
}
