//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球 大小球 赔率
struct FBOddsBigSmallModel: BaseModelProtocol {

    var json: JSON

    /// 大球水位
    var big: Double
    
    /// 小球水位
    var small: Double
    
    /// 盘口
    var handicap: String
    
    /// 盘口变化
    var bet: Int
    
    /// 时间戳
    var time: TimeInterval

    /// 赛果
    var result: FBMatchResultBigSmallType?

    /// 有效赔率
    var isAvailable: Bool {
        return big > 0 && small > 0 && bet != 0
    }

    init(big: Double, small: Double, handicap: String, bet: Int, time: TimeInterval = 0, result: FBMatchResultBigSmallType? = nil) {
        self.json = JSON.null
        self.big = big
        self.small = small
        self.handicap = handicap
        self.bet = bet
        self.time = time
        self.result = result
    }

    init(json: JSON) {
        self.json = json
        big = json["big"].doubleValue
        small = json["small"].doubleValue
        handicap = json["handicap"].stringValue
        bet = json["bet"].intValue
        time = json["time"].doubleValue
        result = FBMatchResultBigSmallType(rawValue: json["result"].stringValue)
    }
}

/// 足球 大小球 赔率组合 初赔和末赔
struct FBOddsBigSmallSetModel {
    
    /// 公司
    var company: CompanyModel
    
    /// 初赔
    var initOdds: FBOddsBigSmallModel
    
    /// 末赔
    var lastOdds: FBOddsBigSmallModel
    
    /// 大球趋势
    var bigTrend: Double {
        return lastOdds.big - initOdds.big
    }
    
    /// 小球趋势
    var smallTrend: Double {
        return lastOdds.small - initOdds.small
    }
    
    /// 盘口趋势
    var handicapTrend: Int {
        return lastOdds.bet - initOdds.bet
    }
    
}
