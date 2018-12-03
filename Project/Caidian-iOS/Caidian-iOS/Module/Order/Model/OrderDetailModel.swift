//
//  OrderDetailModel.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 订单详情
struct OrderDetailModel {
    
    /// 订单
    var order: OrderModel
    
    /// 用户认购
    var buy: UserBuyModel
    
    /// 父级底单
    var parent: OrderModel?
    
    /// 竞技彩 原复式中的对阵与投注内容
    var matchList: [MatchCombination]

    /// 用户信息
    var copy:CopyOrderModel
    
    var  code: OrderModel?
    
    /// 是否跟单
    
    var isCopyBoolean :Bool?
    
    ///近n单详情
    var rankOrder10 : RankOrderModel?
    /// 数字彩
//    var sectionList: [Section]
    
    init(json: JSON) {
        order = OrderModel(json: json["order"])
        code = OrderModel(json: json["code"])
        buy = UserBuyModel(json: json["buy"])
        copy = CopyOrderModel(json: json["copy"])
        isCopyBoolean = json["is_copy"].boolValue
        
        if let _ = json["parent"].null {
            parent = nil
        } else {
            parent = OrderModel(json: json["parent"])
        }
        
        if let _ = json["rank_order10"].null {
            rankOrder10 = nil
        } else {
            rankOrder10 = RankOrderModel(json: json["rank_order10"])
        }
        
        let lottery = order.lottery
        matchList = json["code"]["match_list"].arrayValue.map {
            subJson -> MatchCombination in
            
            let matchJson = subJson["match"]
            let betInfoJson = subJson["bet_info"]
            let betListJson = betInfoJson["bet_list"].arrayValue
            
            var match: SLMatchModelProtocol!
            var betKeyList: [SLBetKeyProtocol]!
            let letBall = betInfoJson["let_ball"].doubleValue
            let dxfNum = betInfoJson["dxf_num"].doubleValue
            let isMustBet = subJson["bet_info"]["is_must_bet"].boolValue
            
            switch lottery {
            case .jczq:
                match = JczqMatchModel(json: matchJson)
                betKeyList = betListJson.compactMap { JczqBetKeyType(key: $0["bet_key"].stringValue, sp: $0["sp"].doubleValue) }
            case .jclq:
                match = JclqMatchModel(json: matchJson)
                betKeyList = betListJson.compactMap { JclqBetKeyType(key: $0["bet_key"].stringValue, sp: $0["sp"].doubleValue)}
            default:
                match = JczqMatchModel(json: matchJson)
                betKeyList = betListJson.compactMap { JczqBetKeyType(key: $0["bet_key"].stringValue, sp: $0["sp"].doubleValue) }
            }
            
            return MatchCombination(match: match, betKeyList: betKeyList, isMustBet: isMustBet, letBall: letBall, dxfNum: dxfNum)
        }
    }
    
    struct MatchCombination {
        /// 对阵
        var match: SLMatchModelProtocol
        /// 投注
        var betKeyList: [SLBetKeyProtocol]
        /// 胆
        var isMustBet: Bool
        /// 让球,让分 这里不使用match的letBall是因为投注时的让分会变化
        var letBall: Double
        /// 大小分 这里不使用match的dxfNum是因为投注时的大小分会变化
        var dxfNum: Double
    }
    
    struct RankOrderModel:BaseModelProtocol {
        
        var json: JSON
        ///近n单
        var orderCount :Int
        
        ///win
        var  win :Int
        
        //lost
        var lost:Int
        
        ///跟单人数
        var copyCount :Int
        
        /// 跟单金额
        var copyMoney :Int
        
        ///跟单中奖金额
        var copyBouns :Double
        
        ///自己中奖金额
        var selfBonus :Double
        
        ///用户的总中奖金额
        var totalBonus :Double
        
        ///自己购买金额
        var selfMoney :Int
        var results :String
        var userId :Int
        var region:String
        
        init(json:JSON) {
            
            self.json = json
            self.orderCount = json["order_count"].intValue
            self.win = json["win"].intValue
            self.lost = json["lost"].intValue
            self.copyCount = json["copy_count"].intValue
            self.copyMoney = json["copy_money"].intValue
            self.copyBouns = json["copy_bouns"].doubleValue
            self.selfBonus = json["self_bonus"].doubleValue
            self.selfMoney = json["self_money"].intValue
            self.region = json["region"].stringValue
            self.userId = json["user_id"].intValue
            self.results = json["results"].stringValue
            self.totalBonus = json["total_bonus"].doubleValue
            
            
        }
        
    }
    
}
