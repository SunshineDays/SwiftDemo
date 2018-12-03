//
//  HomeNewsListModel.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/23.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HomeNewsListModel {
    var list = [NewsModel]()
    var pageInfo: PageInfoModel?
}

struct NewsModel: BaseModelProtocol {
    var json: JSON
    var adminName: String
    var createTime: String?
    var id: Int
    var img: String
    var title: String

    init(json: JSON) {
        self.json = json
        adminName = json["admin_name"].stringValue
        let time = json["create_time"].doubleValue
        if time <= 0 {
            createTime = nil
        } else {
            createTime = TSUtils.timestampToString(time, withFormat: "yyyy-MM-dd HH:mm", isIntelligent: true)
        }
        id = json["id"].intValue
        img = json["img"].stringValue
        title = json["title"].stringValue
    }

}

struct PageInfoModel: BaseModelProtocol {
    var json: JSON
    var dataCount: Int
    var page: Int
    var pageCount: Int
    var pageSize: Int

    init(json: JSON) {
        self.json = json
        dataCount = json["data_count"].intValue
        pageSize = json["page_size"].intValue
        page = json["page"].intValue
        pageCount = json["page_count"].intValue
    }
}
