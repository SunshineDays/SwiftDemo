//
// Created by tianshui on 2017/11/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 球队model
struct FBTeamModel: BaseModelProtocol {

    var json: JSON

    var id: Int {
        get { return tid }
        set { tid = newValue }
    }

    var tid: Int

    /// 球队名
    var name: String

    /// 球队logo
    var logo: String

    /// 英文名
    var englishName: String

    /// 所属国家
    var country: String

    /// 主场球场
    var stadium: String

    /// 网站
    var website: String

    init(json: JSON) {
        self.json = json
        tid  = json["tid"].intValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
        englishName = json["enname"].stringValue
        country = json["country"].stringValue
        stadium = json["stadium"].stringValue
        website = json["web"].stringValue
    }
}
