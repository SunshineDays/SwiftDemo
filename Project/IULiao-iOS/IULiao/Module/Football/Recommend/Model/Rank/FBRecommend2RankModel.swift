//
//  FBRecommend2RankModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommend2RankModel: BaseModelProtocol {
    var json: JSON
    
    /// 玩法类型
    var oddsType: Int
    
    /// 用户信息
    var user: FBRecommendSingleUserModel

    /// 盈利率(盈利值/发单数)
    var payoffPercent: Double
    
    /// 赢
    var win: Int
    
    /// 当前连赢
    var currentKeepWin: String
    
    /// 当前连输
    var currentKeepLost: String
    
    /// 更新时间
    var updated: String
    
    /// 输半
    var lostHalf: Int
    
    /// 赢半
    var winHalf: Int
    
    /// id
    var id: String
    
    /// 走
    var draw: Int
    
    /// 命中率（胜率）
    var hitPercent: Double
    
    /// 连赢
    var keepWin: Int
    
    /// 连输
    var keepLost: Int
    
    /// 用户id
    var userId: Int
    
    /// 是否关注
    var isAttention: Bool
    
    /// 输
    var lost: Int
    
    /// 盈利
    var payoff: String
    
    /// 是否有新的推荐
    var hasnewRecommend: Bool
    
    required init(json: JSON) {
        self.json = json
        
        oddsType = json["oddstype"].intValue
        
        user = FBRecommendSingleUserModel.init(json: json["user"])
        
        payoffPercent = json["payoffpercent"].doubleValue
        win = json["win"].intValue
        
        currentKeepWin = json["currentkeepwin"].stringValue
        currentKeepLost = json["currentKeepLost"].stringValue
        
        updated = json["updated"].stringValue
        lostHalf = json["losthalf"].intValue
        
        winHalf = json["winhalf"].intValue
        id = json["id"].stringValue
        
        draw = json["draw"].intValue
        hitPercent = json["hitpercent"].doubleValue
        
        keepWin = json["keepwin"].intValue
        keepLost = json["keeplost"].intValue
        
        userId = json["userid"].intValue
        isAttention = json["isattention"].boolValue
        
        lost = json["lost"].intValue
        payoff = json["payoff"].stringValue
        
        hasnewRecommend = json["hasnewrecommend"].boolValue
    }
    
}

class FBRecommendSingleUserModel: BaseModelProtocol {
    var json: JSON
    
    /// id
    var id: Int
    
    /// 昵称
    var nickname: String
    
    /// 头像
    var avatar: String
    
    required init(json: JSON) {
        self.json = json
        
        id = json["id"].intValue
        nickname = json["nickname"].stringValue
        avatar = json["avatar"].stringValue
        
        
    }
    
}

