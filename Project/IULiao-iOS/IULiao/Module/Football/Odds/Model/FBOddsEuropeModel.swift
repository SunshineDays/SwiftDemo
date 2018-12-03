//
//  FBOddsEuropeModel.swift
//  IULiao
//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球 欧赔 赔率
struct FBOddsEuropeModel: BaseModelProtocol {

    var json: JSON

    /// 主胜
    var win: Double
    
    /// 平局
    var draw: Double
    
    /// 客胜
    var lost: Double
    
    /// 时间戳
    var time: TimeInterval

    /// 赛果
    var result: FBMatchResultEuropeType?
    
    /// 有效赔率
    var isAvailable: Bool {
        return win > 0 && draw > 0 && lost > 0
    }

    init(win: Double, draw: Double, lost: Double, time: TimeInterval = 0, result: FBMatchResultEuropeType? = nil) {
        self.json = JSON.null
        self.win = win
        self.draw = draw
        self.lost = lost
        self.time = time
        self.result = result
    }

    init(json: JSON) {
        self.json = json
        win = json["win"].doubleValue
        draw = json["draw"].doubleValue
        lost = json["lost"].doubleValue
        time = json["time"].doubleValue
        result = FBMatchResultEuropeType(rawValue: json["result"].stringValue)
    }
    
    /// 返还率
    /// 1 / ( 1 / win + 1 / draw + 1 / lost)
    /// 亦等于  win * draw * lost / (win * draw + win * lost + draw * lost)
    var returnRate: Double {
        if !isAvailable {
            return 0
        }
        return 1 / (1 / win + 1 / draw + 1 / lost)
    }
    
    /// 主胜概率
    var winPercent: Double {
        if win > 0 {
            return returnRate / win
        }
        return 0
    }
    
    /// 平局概率
    var drawPercent: Double {
        if draw > 0 {
            return returnRate / draw
        }
        return 0
    }
    
    /// 客胜概率
    var lostPercent: Double {
        if lost > 0 {
            return returnRate / lost
        }
        return 0
    }
    
    
    /// 主胜凯利指数
    ///
    /// - Parameter europe99: 99家均赔
    /// - Returns:
    func winKelly(europe99: FBOddsEuropeModel) -> Double {
        return winKelly(europe99WinPercent: europe99.winPercent)
    }
    
    
    /// 主胜凯利指数
    ///
    /// - Parameter percent: 99家主胜概率
    /// - Returns:
    func winKelly(europe99WinPercent percent: Double) -> Double {
        return percent * win
    }
    
    /// 平局凯利指数
    ///
    /// - Parameter europe99: 99家均赔
    /// - Returns:
    func drawKelly(europe99: FBOddsEuropeModel) -> Double {
        return drawKelly(europe99DrawPercent: europe99.drawPercent)
    }
    
    
    /// 平局凯利指数
    ///
    /// - Parameter percent: 99家平局概率
    /// - Returns:
    func drawKelly(europe99DrawPercent percent: Double) -> Double {
        return percent * draw
    }
    
    /// 客胜凯利指数
    ///
    /// - Parameter europe99: 99家均赔
    /// - Returns:
    func lostKelly(europe99: FBOddsEuropeModel) -> Double {
        return lostKelly(europe99LostPercent: europe99.lostPercent)
    }
    
    /// 客胜凯利指数
    ///
    /// - Parameter percent: 99家客胜概率
    /// - Returns:
    func lostKelly(europe99LostPercent percent: Double) -> Double {
        return percent * lost
    }
}

/// 足球 欧赔 赔率组合 初赔和末赔
struct FBOddsEuropeSetModel {
    
    /// 公司
    var company: CompanyModel
    
    /// 初赔
    var initOdds: FBOddsEuropeModel
    
    /// 末赔
    var lastOdds: FBOddsEuropeModel
    
    /// 主胜趋势
    var winTrend: Double {
        return lastOdds.win - initOdds.win
    }
    
    /// 平趋势
    var drawTrend: Double {
        return lastOdds.draw - initOdds.draw
    }
    
    /// 客胜趋势
    var lostTrend: Double {
        return lastOdds.lost - initOdds.lost
    }
    
}

func ==(lhs: FBOddsEuropeModel, rhs: FBOddsEuropeModel) -> Bool {
    return lhs.win == rhs.win && lhs.draw == rhs.draw && lhs.lost == rhs.lost
}

func ==(lhs: FBOddsEuropeSetModel, rhs: FBOddsEuropeSetModel) -> Bool {
    return lhs.initOdds == rhs.initOdds && lhs.lastOdds == rhs.lastOdds
}
