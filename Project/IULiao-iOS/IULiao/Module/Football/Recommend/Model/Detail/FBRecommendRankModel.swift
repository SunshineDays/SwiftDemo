//
//  RecommendRankModel.swift
//  IULiao
//
//  Created by levine on 2017/8/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
struct FBRecommendRankModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: String
    
    var userId: Int
    
    var oddsType: OddStype
    
    var region: FBRegionDay //
    
    var keepWin: String
    
    var keepLost: String
    
    var currentKeepWin: String
    
    var win: Int?
    
    var draw: Int?
    
    var lost: Int?
    
    var winHalf: Int?
    
    var lostHalf: Int?
    
    var orderCount: Int?
    
    var hitPercent: String//命中率
    
    var payOff: String//盈利值
    
    var payoffpercent: Float //盈利率

    var hasNewRecommend: Bool
    // var upDated: TimeInterval //
    
    /// 时间
    var upDated: String? {
        let created = self.json["updated"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timestampToString(created)
    }
    
    
    var user: FBRecommendUserModel
    
    var follow: Int
    
    var order10: String
    
    var isAttention: Bool//是否关注
    
    var day7KeeWin: Int//7日连赢 ,当前版本用 以后更正
    
    var day7KeepWin: Int//7日连赢
    
    var day7PayOffPercent: Double//7日盈利率
    init(json: JSON) {
        self.json = json
        
        id = json["id"].stringValue
        userId = json["userid"].intValue
        oddsType = OddStype(rawValue: json["oddstype"].intValue)
        region = FBRegionDay(rawValue: json["region"].stringValue)
        keepWin = json["keepwin"].stringValue
        keepLost = json["keeplost"].stringValue
        currentKeepWin = json["currentkeepwin"].stringValue
        win = json["win"].intValue
        draw = json["draw"].intValue
        lost = json["lost"].intValue
        winHalf = json["winhalf"].intValue
        lostHalf = json["losthalf"].intValue
        orderCount = json["ordercount"].intValue
        hitPercent = json["hitpercent"].stringValue
        payOff = json["payoff"].stringValue
        payoffpercent = json["payoffpercent"].floatValue
        hasNewRecommend = json["hasnewrecommend"].boolValue
        //upDated = json["updated"].doubleValue//
        user = FBRecommendUserModel(json: json["user"])
        follow = json["follow"].intValue
        order10 = json["order10"].stringValue
        isAttention = json["isattention"].boolValue
        day7KeeWin = json["day7keewin"].intValue
        day7KeepWin = json["day7keepwin"].intValue
        day7PayOffPercent =  json["day7payoffpercent"].doubleValue
    }
}
