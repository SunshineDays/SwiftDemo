//
//  FBRecommendExpertHistoryModel.Swift
//  IULiao
//
//  Created by levine on 2017/8/14.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
//专家历史战绩 
struct FBRecommendExpertHistoryModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var userId: Int
    
    var mid: Int
    var oddsType: OddStype//玩法类型
    
    var beton: String
    
    var resultType: GuessResultType// 推荐结果 0:比赛未开始 1:输 2:输半 3:走 4:赢半 5:赢
    
    var payoff: Float
    
    var odds: Odds//投注时赔率 注意oddstype的不同导致里面的字段不会相同 单场推荐详情odds字段说明
    
    var reason: String
    
    
    var comments: Int // 本单场 评论总数
    var pollUp: Int
    
    var pollDown: Int
    
    var isShow: Bool
    //月 日 显示
    var monthDay: String? {
        let created = self.json["match"]["mtime"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timeMonthDayHourMinute(created,withFormat: "MM-dd")
    }
    //小时 ,分钟 显示
    var hourMinute: String? {
        let created = self.json["match"]["mtime"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timeMonthDayHourMinute(created,withFormat: "HH:mm")
    }

    var created: String? {
        let created = self.json["created"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timestampToString(created)
    }

    var matchCreated: String? {
        let created = self.json["created"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timesAftertampToString(created)
    }
    var match: FBLiveMatchModel
    
    
    var betons: [Betons] //投注项 数组[对象]
    
    var pollScore: Int //登录用户赞踩分 0:未赞踩 1:赞 -1:踩
    
    var relatives: [FBRelative]//相关文章推荐
    
    var isAttention: Bool //关注的 单场比赛
    var user: FBRecommendUserModel

    var wapUrl: String

    init(json: JSON) {
        self.json = json
        
        self.id =  json["id"].intValue
        
        self.userId = json["userid"].intValue
        
        self.mid = json["mid"].intValue
        
        self.oddsType = OddStype(rawValue:  json["oddstype"].intValue)
        
        self.beton =  json["beton"].stringValue
        
        self.resultType = GuessResultType(rawValue: json["result"].intValue)// 推荐结果 0:比赛未开始 1:输 2:输半 3:走 4:赢半 5:赢
        
        self.payoff =  json["payoff"].floatValue
        
        self.odds = Odds(json: json["odds"])
        
        self.reason =  json["reason"].stringValue
        
        self.comments = json["comments"].intValue
        
        self.pollUp =  json["pollup"].intValue
        
        self.pollDown =  json["polldown"].intValue
        
        self.isShow =  json["isshow"].boolValue
        
        
        self.match = FBLiveMatchModel(json: json["match"])
        
        self.betons = json["betons"].arrayValue.map({Betons(json: $0)})
        
        self.pollScore = json["pollscore"].intValue
        
        self.relatives = json["relatives"].arrayValue.map({FBRelative(json: $0)})
        
        self.isAttention = json["isattention"].boolValue
        
        self.user = FBRecommendUserModel(json: json["user"])
        
        self.wapUrl = json["wapurl"].stringValue
    }

}
 struct Odds{
    //竞彩 oddstype等于11时对应odds
    var openSale: OpenSaleType//竞彩开赛情况 1:非让球 2:让球 3:非让&让
    var win: Float//赢
    var draw: Float//平
    var lost: Float//输
    var letWin: Float//让球赢
    var letDraw: Float//让球平
    var letLost: Float//让球输
    var letBall: Int//让球
    //竞彩 oddstype等于3时对应odds
    
    var above: Float//主队水位
    var below: Float//客队水位
    var bet: Float//盘口值
    var handicap: String//盘口
    var type: Float//H:主 A:客 可忽略
    //竞彩 oddstype等于4时对应odds
    var big: Float//大球水位
    var small: Float//小球水位
    init(json: JSON) {
        self.openSale = OpenSaleType(rawValue: json["opensale"].intValue)//竞彩开赛情况 1:非让球 2:让球 3:非让&让
        self.win = json["win"].floatValue
        self.draw = json["draw"].floatValue
        self.lost = json["lost"].floatValue
        self.letWin = json["letwin"].floatValue
        self.letDraw = json["letdraw"].floatValue
        self.letLost = json["letlost"].floatValue
        self.letBall = json["letball"].intValue
        
        self.above = json["above"].floatValue
        self.below = json["below"].floatValue
        self.bet = json["bet"].floatValue
        self.handicap = json["handicap"].stringValue
        self.type = json["type"].floatValue
        
        self.big = json["big"].floatValue
        self.small = json["small"].floatValue
    }
}
struct FBRelative {
    var id: Int
    
    var module: String //定值:news
    
    var title: String //标题
    
    var url: String //对应网站的Url
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.module = json["module"].stringValue
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
    }
}
struct Betons {
    var betKey: String//投注项键
    
    var sp: Float//投注时赔率
    init(json: JSON) {
        self.betKey = json["betkey"].stringValue
        self.sp = json["sp"].floatValue
    }
}
