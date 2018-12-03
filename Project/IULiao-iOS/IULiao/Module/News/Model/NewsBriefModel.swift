//
// Created by tianshui on 2017/11/30.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 新闻 简讯 爆料
struct NewsBriefModel: BaseModelProtocol {
    var json: JSON

    var id: Int

    var title: String

    /// 赛事id
    var matchId: Int

    /// 球队id
    var teamId: Int

    /// 图片
    var img: String

    /// 内容
    var content: String

    /// 分类
    var taxonomy: NewsTaxonomyModel

    /// 优劣势
    var compare: Compare

    init(json: JSON) {
        self.json = json

        id = json["id"].intValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        img = json["img"].stringValue

        matchId = json["mid"].intValue
        teamId = json["tid"].intValue

        taxonomy = NewsTaxonomyModel(json: json["taxonomy"])
        compare = Compare(rawValue: json["preponderant"].intValue) ?? .none
    }


    /// 优劣势
    enum Compare: Int, CustomStringConvertible {

        /// 优势
        case preponderant = 1

        /// 劣势
        case disadvantage = -1

        case none = 0
        
        var description: String {
            switch self {
            case .preponderant:
                return "优势"
            default:
                return "劣势"
            }
        }
    }
}
