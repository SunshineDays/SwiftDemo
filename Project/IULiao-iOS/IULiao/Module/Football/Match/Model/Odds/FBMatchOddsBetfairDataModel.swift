//
//  FBMatchOddsBetfairDataModel.swift
//  IULiao
//
//  Created by tianshui on 2017/12/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 必发数据
struct FBMatchOddsBetfairDataModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 主队统计
    var winStatistics: Statistics
    /// 平局统计
    var drawStatistics: Statistics
    /// 客队统计
    var lostStatistics: Statistics
    
    /// 主队成交历史
    var winVolumes: [Betfair]
    /// 平局成交历史
    var drawVolumes: [Betfair]
    /// 客队成交历史
    var lostVolumes: [Betfair]
    
    /// 总成交量
    var totalVolume: Double {
        return winStatistics.deal.volume + drawStatistics.deal.volume + lostStatistics.deal.volume
    }
    
    init(json: JSON) {
        self.json = json
        
        let statisticsJson = json["statistics"]
        let volumesJson = json["volumes"]
        winStatistics = Statistics(json: statisticsJson["win"])
        drawStatistics = Statistics(json: statisticsJson["draw"])
        lostStatistics = Statistics(json: statisticsJson["lost"])
        
        winVolumes = volumesJson["win"].arrayValue.map { Betfair(json: $0) }
        drawVolumes = volumesJson["draw"].arrayValue.map { Betfair(json: $0) }
        lostVolumes = volumesJson["lost"].arrayValue.map { Betfair(json: $0) }
    }
    
    /// 必发
    struct Betfair {
        
        /// 价格
        var price: Double
        /// 交易量
        var volume: Double
        /// 时间戳
        var time: TimeInterval
        
        init(json: JSON) {
            price = json["price"].doubleValue
            volume = json["volume"].doubleValue
            time = json["time"].doubleValue
        }
    }
    
    /// 统计
    struct Statistics {
        
        /// 指数
        var index: Index
        /// 成交量
        var deal: Betfair
        
        init(json: JSON) {
            index = Index(json: json["index"])
            deal = Betfair(json: json["deal"])
        }
        
        /// 指数
        struct Index {
            /// 市场指数
            var market: Double
            /// 盈亏指数
            var profit: Double
            /// 冷热指数
            var hot: Double
            /// 购买指数
            var buyPrefer: Double
            /// 出售指数
            var sellPrefer: Double
            
            init(json: JSON) {
                market = json["market"].doubleValue
                profit = json["profit"].doubleValue
                hot = json["hot"].doubleValue
                buyPrefer = json["buy_prefer"].doubleValue
                sellPrefer = json["sell_prefer"].doubleValue
            }
        }
    }
}
