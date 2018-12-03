//
//  CommonTopicModel.swift
//  IULiao
//
//  Created by levine on 2017/9/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import YYText

struct CommonTopicModel: BaseModelProtocol {


    var json: JSON
    // 二级评论 和一级字段一样
//    var children: [CommonTopicModel]? {
//        return json["children"].arrayValue.map({CommonTopicModel(json: $0)})
//    }
    var children: [CommonTopicModel]
    // 资讯内容",
    var content: String
    // 发表时间
    var created: Double
    //var createTime: String?
    /*? {
     let created = self.json["created"].doubleValue
     if created <= 0 {
     return nil
     }
     return TSUtils.timestampToString(created)
     }
    */
     //
    var id: Int
    // 1:已被删除 0:正常
    var isKill: Int// "0",
    //  父级id 一级评论永远是0
    var parentId: Int
    // 点赞数
    var pollDown: Int
    // 登录用户对此评论的操作 1:赞 0:无 -1:踩
    var pollScore: Int
    // 踩 数
    var pollUp: Int
    // 用户
    var user: FBRecommendUserModel
    // 用户id
    var userId: Int
   // var module:
    init(json: JSON) {
        
        self.json = json
        children =  json["children"].arrayValue.map({CommonTopicModel(json: $0)})
        content = json["content"].stringValue
        created = json["created"].doubleValue
        id = json["id"].intValue
        isKill = json["iskill"].intValue
        parentId = json["parentid"].intValue
        pollDown = json["polldown"].intValue
        pollScore = json["pollscore"].intValue
        pollUp = json["pollup"].intValue
        user = FBRecommendUserModel(json: json["user"])
        userId = json["userid"].intValue


     
    }
   //额外添加的属性
    
    init(aId: Int, userId: Int, content: String, createTime: Double, pollUp: Int, parentId: Int,userAvatar: String, userNickName: String) {
        self.init(json: JSON(NSNull()))
        self.id  = aId
        self.userId = userId
        self.content  = content
        self.created = createTime
        self.pollUp = pollUp
        self.parentId = parentId
        self.user.avatar = userAvatar
        self.user.nickName = userNickName
    }
    /// 辅助属性
    var commentCount: Int = 0

    var comments: NSMutableArray = []

//    var thumbNumsString: String {
//        return self.thumbNumsString
//    }
    // 获取富文本

    var attributedContentText: NSMutableAttributedString {

        var commentText = content
        if isKill == 1 {
            commentText = "该条评论涉嫌违规,已被删除"

        }
        let attributedString = NSMutableAttributedString(string: commentText)

        if isKill == 1 {
          attributedString.yy_setTextStrikethrough(YYTextDecoration(style: YYTextLineStyle.single), range: NSMakeRange(0, attributedString.length))
        }

        attributedString.yy_font = UIFont.systemFont(ofSize: 14)
        attributedString.yy_color = UIColor(r: 102, g: 102, b: 102)
        attributedString.yy_lineSpacing = 5
        return attributedString


    }

//    var attributeCommentContentText: NSAttributedString {
//        // 是否有回复
//        if children.count > 0 {
//            let textString = String(format: "%@", <#T##arguments: CVarArg...##CVarArg#>))
//        }
//    }

    
}
