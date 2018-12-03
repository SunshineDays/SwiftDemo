//
//  FBRecommendSponsorActivityModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSponsorActivityModel: BaseModelProtocol {
    var json: JSON
    
    /// 新闻列表
    var newsList = [FBRecommendSponsorActivityNewsModel]()
    
    /// 客服QQ
    var qq: String
    
    required init(json: JSON) {
        self.json = json
        newsList = json["news_list"].arrayValue.map {FBRecommendSponsorActivityNewsModel.init(json: $0)}
        qq = json["qq"].stringValue
    }
    
}


class FBRecommendSponsorActivityNewsModel: BaseModelProtocol {
    var json: JSON
    
    var module: String
    
    var title: String
    
    var id: Int
    
    var url: String
    
    required init(json: JSON) {
        self.json = json
        module = json["module"].stringValue
        title = json["title"].stringValue
        id = json["id"].intValue
        url = json["ulr"].stringValue
    }
}
