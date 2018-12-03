//
//  FBLiveMatchModel.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球比分赛事model
struct FBLiveMatchModel: FBBaseMatchModelProtocol {
    
    var json: JSON//用于保存获取的网络JSON数据
    
    /// mid 赛事id
    var mid: Int
    
    /// 主队名
    var home: String
    
    /// 客队名
    var away: String
    
    /// 主队得分
    var homeScore: Int?
    
    var lastHomeScore: Int?
    
    /// 客队得分
    var awayScore: Int?
    
    var lastAwayScore: Int?
    
    /// 联赛信息
    var league: FBBaseLeagueModel
    
    /// 开赛时间
    var matchTime: TimeInterval
    
    /// 主队红牌
    var homeRed: Int
    
    /// 客队红牌
    var awayRed: Int
    
    /// 开赛时间
    var beginTime: TimeInterval?
    
    /// 需要交换消息
    var isNeedExchangeMsg: Bool
    
    /// 状态
    var stateType: FBLiveStateType
    
    /// 序号
    var serial: String
    
    /// 是否关注
    var isAttention = false
    
    /// 主队logo
    var homeLogo: String?
    
    /// 客队logo
    var awayLogo: String?
    
    /// 主队id
    var homeTid: Int
    
    /// 客队id
    var awayTid: Int
    
    /// 爆料数
    var briefCount: Int?
    
    /// 轮次id
    var roundId: Int
    
    init(json: JSON) {
        self.json = json
        
        mid  = json["mid"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        
        // 接口有可能返回字符串
        let hscore = json["hscore"]
        if hscore.type == Type.string {
            if hscore.stringValue.isEmpty {
                homeScore = nil
            } else {
                homeScore = hscore.intValue
            }
        } else {
            homeScore = hscore.int
        }
        
        let ascore = json["ascore"]
        if ascore.type == Type.string {
            if ascore.stringValue.isEmpty {
                awayScore = nil
            } else {
                awayScore = ascore.intValue
            }
        } else {
            awayScore = ascore.int
        }
        
        matchTime = json["mtime"].doubleValue
        league = FBBaseLeagueModel(lid: json["lid"].intValue, name: json["lname"].stringValue, color: UIColor(rgba: json["color"].stringValue))
        homeRed = json["hred"].intValue
        awayRed = json["ared"].intValue
        beginTime = json["ktime"].double
        isNeedExchangeMsg = json["exflag"].boolValue
        stateType = FBLiveStateType(rawValue: json["state"].intValue)
        serial = json["serial"].stringValue
        homeLogo = json["hlogo"].stringValue
        awayLogo = json["alogo"].stringValue
        homeTid = json["htid"].intValue
        awayTid = json["atid"].intValue
        
        briefCount = json["briefcount"].intValue
        roundId = json["rid"].intValue
    }
  
    
}


extension FBLiveMatchModel {
    
    /// 即时比分进行到的时间
    func liveTime() -> Int {
        
        let current = Date().timeInterval
        let realtime = beginTime ?? matchTime
        
        var time = (current - realtime) / 60
        
        if stateType == .uptHalf {
            time = max(0, time)
            time = min(45, time)
        } else if stateType == .downHalf {
            time += 45
            time = max(45, time)
            time = min(90, time)
        }
        return Int(time)
    }
}
 
