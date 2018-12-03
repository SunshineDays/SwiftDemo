//
//  NewsTaxonomyModel.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 分类
//结构体中的方法修改到属性的时候需要在方法前面加上关键字mutating表示该属性能够被修改
struct NewsTaxonomyModel: BaseModelProtocol {
    
    /// 分类类型
    enum `Type`: Int {
        
        // 分类
        case category = 1
        
        /// 标签
        case tag = 2
        
        case none = 0
    }
    
    var json: JSON
    
    var name: String
    
    var id: Int
    
    var type: `Type`
    
    init(json: JSON) {
        self.json = json
        
        name = json["name"].stringValue
        id = json["id"].intValue
        type = Type(rawValue: json["type"].intValue) ?? .none
    }
}
