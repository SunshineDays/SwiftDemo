//
//  NewsModel.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
//  Copyright © 2015年 fenlan. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 资讯
//类 遵循了 协议，应该用required关键字修饰初始化器的具体实现
class NewsModel: TSHTMLTemplateModel {
    
    var coverImages: [TSHTMLImageModel]? {
        guard let imgsJSON =  self.json["imgs"].array else {
            return nil
        }
        return imgsJSON.map {
            TSHTMLImageModel(urlString: $0.stringValue, reference: $0.stringValue)
        }
    }
    
    /// 封面图
    var img: String

    
    /// 标签
    var tags: [String] {
        return json["tags"].arrayValue.map { $0["name"].stringValue }
    }
    
    required init(json: JSON) {
        self.img      = json["img"].stringValue
        // 调用父类初始化方法， 赋值父类的 属性
        super.init(json: json)
    }
}
