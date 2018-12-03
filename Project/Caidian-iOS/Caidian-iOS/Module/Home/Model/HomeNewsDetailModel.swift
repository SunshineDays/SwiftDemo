//
// Created by levine on 2018/5/2.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

///新闻详情model
struct HomeNewsDetailModel: BaseModelProtocol {
    var json: JSON
    var id: Int
    var title: String
//    var admin
    var img: String
    var createdTime: TimeInterval
    var content: String

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        title = json["title"].stringValue
        img = json["img"].stringValue
        createdTime = json["create_time"].doubleValue
        content = json["content"].stringValue
    }
}
