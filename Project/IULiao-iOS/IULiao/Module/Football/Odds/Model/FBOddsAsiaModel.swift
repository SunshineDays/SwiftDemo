//
//  FBOddsAsiaModel.swift
//  IULiao
//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球 亚盘 赔率
struct FBOddsAsiaModel: BaseModelProtocol {

    var json: JSON

    /// 上盘水位
    var above: Double
    
    /// 下盘水位
    var below: Double
    
    /// 盘口
    var handicap: String
    
    /// 盘口变化
    var bet: Int
    
    /// 时间戳
    var time: TimeInterval

    /// 赛果
    var result: FBMatchResultAsiaType?

    /// 有效赔率
    var isAvailable: Bool {
        return above > 0 && below > 0 && bet != 0
    }

    init(above: Double, below: Double, handicap: String, bet: Int, time: TimeInterval = 0, result: FBMatchResultAsiaType? = nil) {
        self.json = JSON.null
        self.above = above
        self.below = below
        self.handicap = handicap
        self.bet = bet
        self.time = time
        self.result = result
    }

    init(json: JSON) {
        self.json = json
        above = json["above"].doubleValue
        below = json["below"].doubleValue
        handicap = json["handicap"].stringValue
        bet = json["bet"].intValue
        time = json["time"].doubleValue
        result = FBMatchResultAsiaType(rawValue: json["result"].stringValue)
    }
}

/// 足球 亚盘 赔率组合 初赔和末赔
struct FBOddsAsiaSetModel {
    
    /// 公司
    var company: CompanyModel
    
    /// 初赔
    var initOdds: FBOddsAsiaModel
    
    /// 末赔
    var lastOdds: FBOddsAsiaModel
    
    /// 上盘趋势
    var aboveTrend: Double {
        return lastOdds.above - initOdds.above
    }
    
    /// 下盘趋势
    var belowTrend: Double {
        return lastOdds.below - initOdds.below
    }
    
    /// 盘口趋势
    var handicapTrend: Int {
        return FBOddsAsiaSetModel.handicapTrend(initBet: initOdds.bet, lastBet: lastOdds.bet)
    }
    
    /// 盘口趋势
    static func handicapTrend(initBet: Int, lastBet: Int) -> Int {
        // 即时盘与初盘都为负数或正数时
        // 即时（绝对值）-初盘（绝对值）——大于0 升——小于0降——等于0不升不降
        // 即时盘与初盘中出现一个负数时  直接判断为降盘
        if initBet >= 0 && lastBet >= 0 || initBet < 0 && lastBet < 0 {
            return abs(lastBet) - abs(initBet)
        }
        return -1
    }
}

func ==(lhs: FBOddsAsiaModel, rhs: FBOddsAsiaModel) -> Bool {
    return lhs.above == rhs.above && lhs.below == rhs.below && lhs.handicap == rhs.handicap && lhs.bet == rhs.bet
}

func ==(lhs: FBOddsAsiaSetModel, rhs: FBOddsAsiaSetModel) -> Bool {
    return lhs.initOdds == rhs.initOdds && lhs.lastOdds == rhs.lastOdds
}
