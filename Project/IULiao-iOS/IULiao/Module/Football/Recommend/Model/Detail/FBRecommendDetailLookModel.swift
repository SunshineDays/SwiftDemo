//
//  FBRecommendDetailLookModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/8.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendDetailLookModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int
    
    var avatar: String
    
    var nickname: String
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        avatar = json["avatar"].stringValue
        nickname = json["nickname"].stringValue
    }
    
}

class FBRecommendDetailPageInforModel: BaseModelProtocol {
    
    var json: JSON
    
    var page: Int
    
    var pageSize: Int
    
    var pageCount: Int
    
    var dataCount: Int
    
    required init(json: JSON) {
        self.json = json
        
        page = json["page"].intValue
        pageSize = json["pagesize"].intValue
        pageCount = json["pagecount"].intValue
        dataCount = json["datacount"].intValue
    }
    
}
