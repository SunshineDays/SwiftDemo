//
//  TSHTMLTemplateModel.swift
//  HuaXia
//
//  Created by tianshui on 15/10/20.
// 
//

import UIKit
import SwiftyJSON

/// html中的image
struct TSHTMLImageModel {
    var urlString: String
    var reference: String
}

/// html相关阅读
struct TSHTMLRelativeModel {
    var id: Int
    var title: String
    var module: String
    
    /// 用于app的链接 news://1070
    var appURLString: String {
        return "\(module)://\(id)"
    }
}

/// html 模板数据  //类遵循了 协议 用required 关键字修饰初始化器的具体实现
/// swift4.0开始字段需要加@objc才能在模板中使用
class TSHTMLTemplateModel: NSObject, BaseModelProtocol {
    
    var json: JSON
    
    @objc var id: Int
    
    /// 标题
    @objc var title: String
    
    /// 点击数
    @objc var hits: Int
    
    /// 内容
    @objc var content: String
    
    /// 时间
    @objc var time: String? {
        let created = self.json["created"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timestampToString(created)
    }
    
    @objc var timeYYMMDDHHMM: String? {
        let created = self.json["created"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timestampToString(created, withFormat: "yy-MM-dd HH:mm")
    }
    
    
    /// 图片数组
    var images: [TSHTMLImageModel]? {
        guard let imgsJSON =  self.json["imgs"].array else {
            return nil
        }
        return imgsJSON.map {
            TSHTMLImageModel(urlString: $0["url"].stringValue, reference: $0["ref"].stringValue)
        }
    }
   
    /// 相关阅读
    var relatives: [TSHTMLRelativeModel]? {
        guard let tempJSON = self.json["relatives"].array else {
            return nil
        }
        return tempJSON.map {
            TSHTMLRelativeModel(id: $0["id"].intValue, title: $0["title"].stringValue, module: $0["module"].stringValue)
        }
    }
    /// 评论数
    @objc var comments: Int
    /// 关注新闻
    var isAttention: Bool

     /// 是否删除了评论
    var isKill: Int
    //wap 链接
    var wapUrl: String

    var summary: String
    required init(json: JSON) {
        self.json     = json
        self.id       = json["id"].intValue
        self.title    = json["title"].stringValue
        self.content  = json["content"].stringValue
        self.hits     = json["hits"].intValue
        self.comments = json["comments"].intValue
        self.isAttention = json["isattention"].boolValue
        self.isKill = json["iskill"].intValue
        self.wapUrl = json["wapurl"].stringValue
        self.summary = json["summary"].stringValue
    }
    
}
