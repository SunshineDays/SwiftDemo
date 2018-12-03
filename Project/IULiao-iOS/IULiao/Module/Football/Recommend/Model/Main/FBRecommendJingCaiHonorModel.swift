//
//  GuessHonorModel.swift
//  IULiao
//
//  Created by levine on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 推荐 盈利达人
struct FBRecommendJingCaiHonorModel: BaseModelProtocol {

    var json: JSON
    var id: String//
    
    var mid: String//
    
    var userId: Int//
    
    var oddsType: OddStype//玩法类型
    
    var regionType: FBRegionDay//天数
    
    var keepWin: String//连赢
    
    var keepLost: String//	连输
    
    var win: String//	赢场次
    
    var draw: String//”和“ 不输不赢
    
    var lost: String// 输场次
    
    var winHalf: String//赢 半
    
    var lostHalf: String// 输 半
    
    var orderCount: String // 订单 个数
    
    var hitPercent: String// 命中率(胜率)
    
    var payOff: String//盈利
    
    var payOffPercent: Double//盈利率
    
    var updated: TimeInterval//更新时间
    
    var user: FBRecommendUserModel
    
    var order10: String //近 10单 中奖几单
    
    var hasNewRecommend: Bool //是否有新的推荐
    
    var isAttention: Bool // 当前用户是否已关注此人

    
    init(json: JSON) {
        
        self.json = json
        
        id = json["id"].stringValue
        mid  = json["mid"].stringValue
        userId = json["userid"].intValue
        oddsType = OddStype(rawValue: json["oddstype"].intValue)
        regionType = FBRegionDay(rawValue: json["region"].stringValue)
        keepWin = json["keepwin"].stringValue
        keepLost = json["keeplost"].stringValue
        win = json["win"].stringValue
        draw = json["draw"].stringValue
        lost = json["lost"].stringValue
        winHalf = json["winhalf"].stringValue
        lostHalf = json["losthalf"].stringValue
        orderCount = json["ordercount"].stringValue
        hitPercent = json["hitpercent"].stringValue// 命中率(胜率)
        payOff = json["payoff"].stringValue
        payOffPercent = json["payoffpercent"].doubleValue
        updated = json["updated"].doubleValue
        user = FBRecommendUserModel(json: json["user"])
        order10 = json["order10"].stringValue
        hasNewRecommend = json["hasnewrecommend"].boolValue
        isAttention = json["isattention"].boolValue
    }

}
//天数
enum FBRegionDay: String {
    case order10 = "order10"//近 100 天
    case day7 = "day7"//近 7 天
    case day30 = "day30"//近 30 天
    case all = "all" //所有天数
    case unknow
    init(rawValue: String) {
        switch rawValue {
        case "order10":
            self = .order10
        case "day7":
            self = .day7
        case "day30":
            self = .day30
        case "all":
            self = .all
        default:
            self = .unknow
        }
    }
    var  ragionName: String {
        switch self {
        case .order10: return "近10单"
        case .day7: return "近7天"
        case .day30: return "近30天"
        case .all: return "全部"
        case .unknow: return "未知"
       
        }
    }
}
