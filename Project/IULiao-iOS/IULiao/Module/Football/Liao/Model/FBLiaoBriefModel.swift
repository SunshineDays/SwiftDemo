//
//  FBLiaoBriefModel.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 料 简讯
struct FBLiaoBriefModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 封面图
    var img: String
    
    var imgUrl: URL? {
        return URL(string: img)
    }
    
    var id: Int
    
    /// 标题
    var title: String
    
    var content: String
    
    /// 赛事id
    var mid: Int
    
    /// 球队id
    var tid: Int
    
    /// 分类
    var taxonomy: NewsTaxonomyModel
    
    init(json: JSON) {
        self.json = json
        id  = json["id"].intValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        img = json["img"].stringValue
        mid = json["mid"].intValue
        tid = json["tid"].intValue
        
        taxonomy = NewsTaxonomyModel(json: json["taxonomy"])
    }
}
