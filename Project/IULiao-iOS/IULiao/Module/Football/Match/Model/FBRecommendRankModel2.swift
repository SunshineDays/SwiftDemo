//
// Created by tianshui on 2017/12/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

///  推荐 排行榜
struct FBRecommendRankModel2: BaseModelProtocol {
    var json: JSON

    var id: Int

    var userId: Int

    /// 玩法
    var playType: FBRecommendModel2.PlayType

    /// 范围
    var regionType: RegionType

    /// 总单数
    var orderCount: Int

    /// 赢次数
    var win: Int

    /// 赢半次数
    var winHalf: Int

    /// 走次数
    var draw: Int

    /// 输半次数
    var lostHalf: Int

    /// 输次数
    var lost: Int

    /// 连红
    var keepWin: Int

    /// 连黑
    var keepLost: Int

    /// 命中率
    var hitPercent: Double

    /// 盈利率
    var payoffPercent: Double

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userId = json["userid"].intValue
        playType = FBRecommendModel2.PlayType(rawValue: json["oddstype"].intValue) ?? .none
        regionType = RegionType(rawValue: json["region"].stringValue) ?? .all
        orderCount = json["ordercount"].intValue
        win = json["win"].intValue
        draw = json["draw"].intValue
        lost = json["lost"].intValue
        winHalf = json["winhalf"].intValue
        lostHalf = json["losthalf"].intValue
        keepWin = json["keepwin"].intValue
        keepLost = json["keeplost"].intValue
        hitPercent = json["hitpercent"].doubleValue
        payoffPercent = json["payoffpercent"].doubleValue
    }

    /// 排行榜范围
    enum RegionType: String {
        case all, day7, day30, order5, order10
    }

}
