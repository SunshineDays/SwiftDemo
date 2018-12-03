//
//  HomeLotteryModel.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeMainModel: BaseModelProtocol {
    var json: JSON
    
    /// 轮播图
    var scrollList = [CarouselListModel]()
    /// 通知
    var noticeList = [NewsModel]()
    /// 打票点信息
    var shopModel: ShopModel!
    /// 彩种信息
    var lotterySale: LotterySaleModel!
    
    var topicList = [NewsModel]()
    var newsBonusList = [NewsBonusCellModel]()
    
    required init(json: JSON) {
        self.json = json
        
        var s = [CarouselListModel]()
        for j in json["carousel_list"].arrayValue {
            s.append(CarouselListModel(json: j))
        }
        scrollList = s
        
        var n = [NewsModel]()
        for j in json["notice_list"].arrayValue {
            n.append(NewsModel(json: j))
        }
        noticeList = n
        
        shopModel = ShopModel(json: json["shop"])
        
        lotterySale = LotterySaleModel(json: json["lottery_sale"])
        
        var t = [NewsModel]()
        for j in json["topic_list"].arrayValue {
            t.append(NewsModel(json: j))
        }
        topicList = t
        
        var news = [NewsBonusCellModel]()
        for j in json["new_bonus_list"].arrayValue {
            news.append(NewsBonusCellModel(json: j))
        }
        newsBonusList = news

        
    }
    
    
}

/// 首页热门彩种
struct HomeLotteryModel: BaseModelProtocol {
    var json: JSON

    var id: Int
    var lotteryId: LotteryType
    var lotteryName: String
    var lotteryType: LotteryType
    var isSale: Bool // 是否开售
    var description: String
    var sort: Int
    var updateTime: Int
    var creatTime: Int

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        lotteryId = LotteryType(rawValue: json["lottery_id"].intValue) ?? .jczq
        lotteryName = json["lottery_name"].stringValue
        lotteryType = LotteryType(rawValue: json["lottery_id"].intValue) ?? .jczq
        isSale = json["is_sale"].boolValue
        description = json["description"].stringValue
        sort = json["sort"].intValue
        updateTime = json["update_time"].intValue
        creatTime = json["create_time"].intValue
    }
}



struct LotterySaleModel: BaseModelProtocol {
    var json: JSON
    var home = [HomeLotteryModel]()
    var sport = [HomeLotteryModel]()
    var numeric = [HomeLotteryModel]()
    var quick = [HomeLotteryModel]()

    init(json: JSON) {
        self.json = json
        home = json["home"].arrayValue.map {
            return HomeLotteryModel(json: $0)
        }
        sport = json["sport"].arrayValue.map {
            return HomeLotteryModel(json: $0)
        }
        numeric = json["numeric"].arrayValue.map {
            return HomeLotteryModel(json: $0)
        }
        quick = json["quick"].arrayValue.map {
            return HomeLotteryModel(json: $0)
        }
    }
}

/// 中奖通报
struct NewsBonusCellModel: BaseModelProtocol {
    var json: JSON
    /// 用户id
    var userId: Int

    /// 用户名
    var nickName: String

    /// 中奖金额
    var bonus: Double

    /// 彩种
    var lotteryName: String


    init(json: JSON) {
        self.json = json
        userId = json["user_id"].intValue
        nickName = json["nickname"].stringValue
        bonus = json["bonus"].doubleValue
        lotteryName = json["lottery_name"].stringValue

    }
}

/// 轮播图
struct CarouselListModel {
    var json: JSON
    
    var id: Int
    
    var title: String
    
    var image: String
    
    var url: String
    
    var type: Int
    
    var resourceId: Int
    
    var urlScheme: String
    
    var sort: Int
    
    var isShow: Bool
    
    var createTime: TimeInterval
    
    var updateTime: TimeInterval
    
    var typeName: String
    
    init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        title = json["title"].stringValue
        image = json["img"].stringValue
        url = json["url"].stringValue
        type = json["type"].intValue
        resourceId = json["resource_id"].intValue
        urlScheme = json["url_scheme"].stringValue
        sort = json["sort"].intValue
        isShow = json["is_show"].intValue == 1 ? true : false
        createTime = json["create_time"].doubleValue
        updateTime = json["update_time"].doubleValue
        typeName = json["type_name"].stringValue
    }
}

/// 打票点
struct ShopModel {
    var json: JSON
    
    var name: String
    
    var wechat: String
    
    var businessHours: String
    
    var image: String
    
    init(json: JSON) {
        self.json = json
        
        name = json["name"].stringValue
        wechat = json["wechat"].stringValue
        businessHours = json["business_hours"].stringValue
        image = json["img"].stringValue
    }
}
