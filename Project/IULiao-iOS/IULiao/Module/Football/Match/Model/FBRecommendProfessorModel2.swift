//
// Created by tianshui on 2017/12/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 推荐 专家
struct FBRecommendProfessorModel2: BaseModelProtocol {
    var json: JSON

    var id: Int

    var userId: Int {
        return id
    }

    var nickname: String

    /// 头像
    var avatar: String

    /// 专家介绍
    var intro: String

    /// 连红
    var keepWin: Int

    /// 连黑
    var keepLost: Int

    /// 关注用户
    var follow: Int

    /// 竞彩达人
    var jingcaiHonor: Bool

    /// 盈利达人
    var payoffHonor: Bool

    //------------------------------------
    // 特殊的几个统计字段
    //------------------------------------

    /// 近10单命中
    var order10: String

    /// 近7天盈利率
    var day7PayoffPercent: Double
    
    /// 近7天命中率
    var day7HitPercent: Double

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        nickname = json["nickname"].stringValue
        avatar = json["avatar"].stringValue
        intro = json["intro"].stringValue
        keepWin = json["keepwin"].intValue
        keepLost = json["keeplost"].intValue
        follow = json["follow"].intValue
        jingcaiHonor = json["jingcaihonor"].boolValue
        payoffHonor = json["payoffhonor"].boolValue

        order10 = json["order10"].stringValue
        day7PayoffPercent = json["day7payoffpercent"].doubleValue
        day7HitPercent = json["day7hitpercent"].doubleValue
    }

}
