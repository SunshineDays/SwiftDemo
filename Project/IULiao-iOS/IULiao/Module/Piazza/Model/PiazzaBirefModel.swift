//
//  PiazzaBirefModel.swift
//  IULiao
//
//  Created by levine on 2017/7/31.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
struct PiazzaBirefModel: BaseModelProtocol {
    var json: JSON
    
    var id :Int
    var title:String//标题
    
    var content:String//内容
    
    var img:String//图片
    
    var tid : Int
    
    var mid :Int
    
    var preponderant:Int//主要的
    var time:String?//时间
    {
        let created = self.json["created"].doubleValue
        if created < 0{
            return nil
        }
        return TSUtils.timestampToString(created)
    }
    /// 分类
    var taxonomy: NewsTaxonomyModel
    init(json:JSON) {
        self.json = json
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.content = json["content"].stringValue
        self.img = json["img"].stringValue
        self.tid = json["tid"].intValue
        self.mid = json["mid"].intValue
        self.preponderant = json["preponderant"].intValue
        self.taxonomy = NewsTaxonomyModel(json: json["taxonomy"])
    }
}
