//
//  SLBuyModel.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BuyModelProtocol {

    /// 彩种
    var lottery: LotteryType { get set }
    /// 玩法
    var play: PlayType { get set }
    /// 注数
    var betCount: Int { get set }
    /// 总金额
    var totalMoney: Double { get }
    /// 单注金额
    var singleMoney: Double { get set }
    /// 订单类型
    var orderBuyType: OrderBuyType { get set }
    /// 购买请求json string
    var toJsonString: String { get }
}

/// 购买model
struct SLBuyModel<MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol>: BuyModelProtocol {

    var lottery = LotteryType.jczq
    var play = PlayType.none
    var betCount: Int {
        get {
            return bonus.betCount
        }
        set {
            bonus.betCount = newValue
        }
    }
    var totalMoney: Double {
        return Double(betCount) * singleMoney * Double(multiple)
    }
    var singleMoney: Double = 2
    var orderBuyType = OrderBuyType.normal

    /// 倍数
    var multiple = 1 {
        didSet {
            calcBonus()
        }
    }
    /// 期号
    var issue: String {
        return matchList.map { $0.match.issue }.first ?? ""
    }
    /// 发单是否保密 0 保密 1 截止可见 2 复制可见
    var isSecret =  0
    /// 发单理由
    var reason = ""
    /// 所有允许的串关方式
    private (set) var allAllowSerialList = [SLSerialType]()
    /// 串关方式
    private (set) var selectedSerialList = [SLSerialType]() {
        didSet {
            let serial = selectedSerialList.map { $0.m }.sorted()
            let minSerial = serial.first ?? 0
            let maxSerial = serial.last ?? 0
            if matchList.count <= maxSerial {
                allowMustBetCount = 0
            } else {
                allowMustBetCount = max(0, minSerial - 1)
            }
        }
    }
    
    /// 允许设胆的个数
    private (set) var allowMustBetCount: Int = 0
    /// 已经设胆的个数
    var mustBetCount: Int {
        return matchList.filter { $0.isMustBet }.count
    }
    
    /// 奖金
    private (set) var bonus = SLCalcBonusHelper.Result()
    
    /// 投注赛事列表
    private (set) var matchList = [MatchCombination]()

    struct MatchCombination {
        /// 对阵信息
        var match: MatchModel
        /// 投注信息
        var betKeyList = [BetType]()
        /// 胆
        var isMustBet = false
    }

    /// 改变投注key
    mutating func changeBetKey(match: MatchModel, key: BetType) {
        var matchList = self.matchList
        if let x = matchList.index(where: { $0.match == match }) {
            if let y = matchList[x].betKeyList.index(where: { $0 == key }) {
                matchList[x].betKeyList.remove(at: y)
                if matchList[x].betKeyList.isEmpty {
                    matchList.remove(at: x)
                }
            } else {
                matchList[x].betKeyList.append(key)
            }
        } else {
            matchList = matchList.map {
                match in
                var match = match
                match.isMustBet = false
                return match
            }
            matchList.append(MatchCombination(match: match, betKeyList: [key], isMustBet: false))
            matchList.sort(by: { $0.match.xid < $1.match.xid })
        }
        self.matchList = matchList
        allAllowSerialList = generateAllAllowSerialList()
        setDefaultSerialList()
        calcBonus()
    }

    /// 改变投注key list
    mutating func changeBetKeyList(match: MatchModel, betKeyList: [BetType]) {
        var matchList = self.matchList
        if let index = matchList.index(where: { $0.match == match }) {
            if betKeyList.isEmpty {
                matchList.remove(at: index)
            } else {
                matchList[index].betKeyList = betKeyList
            }
        } else {
            if !betKeyList.isEmpty {
                matchList = matchList.map {
                    match in
                    var match = match
                    match.isMustBet = false
                    return match
                }
                matchList.append(MatchCombination(match: match, betKeyList: betKeyList, isMustBet: false))
                matchList.sort(by: { $0.match.xid < $1.match.xid })
            }
        }
        self.matchList = matchList
        allAllowSerialList = generateAllAllowSerialList()
        setDefaultSerialList()
        calcBonus()
    }

    /// 移除一个赛事
    mutating func removeMatch(_ match: MatchModel) {
        var matchList = self.matchList
        if let index = matchList.index(where: { $0.match == match }) {
            matchList.remove(at: index)
            matchList.sort(by: { $0.match.xid < $1.match.xid })
        }
        self.matchList = matchList
        allAllowSerialList = generateAllAllowSerialList()
        setDefaultSerialList()
        calcBonus()
    }

    /// 设胆
    mutating func setMatchMustBet(match: MatchModel, isMustBet: Bool) {
        var matchList = self.matchList
        if let index = matchList.index(where: { $0.match == match }) {
            matchList[index].isMustBet = isMustBet
        }
        self.matchList = matchList
        calcBonus()
    }
    
    /// 重置已选择的胆
    mutating func resetMustBet() {
        matchList = matchList.map {
            match in
            var match = match
            match.isMustBet = false
            return match
        }
        allAllowSerialList = generateAllAllowSerialList()
        setDefaultSerialList()
        calcBonus()
    }
    
    /// 清楚所有对阵
    mutating func clearMatchList() {
        matchList = []
        allAllowSerialList = generateAllAllowSerialList()
        setDefaultSerialList()
        calcBonus()
    }
    
    /// 选中过关方式
    mutating func selected(serialList: [SLSerialType]) {
        selectedSerialList = serialList
        calcBonus()
    }
    
    /// 设置默认选择的串关
    private mutating func setDefaultSerialList() {
        if let last = allAllowSerialList.last {
            selectedSerialList = [last]
        } else {
            selectedSerialList = []
        }
    }

    /// 生成所有允许的串关
    private func generateAllAllowSerialList() -> [SLSerialType] {
        // 可以投注单关
        var canBetSingle = true
        var maxSerial = matchList.count

        for combination in matchList {
            let match = combination.match
            for betKey in combination.betKeyList {
                let num = lottery.maxSerial(play: betKey.playType)
                maxSerial = min(maxSerial, num)

                if canBetSingle {
                    // 不同彩种的单关开售情况
                    switch lottery {
                    case .jczq:
                        let m = match as! JczqMatchModel
                        switch betKey.playType {
                        case .fb_spf: canBetSingle = m.spfSingle
                        case .fb_rqspf: canBetSingle = m.rqspfSingle
                        case .fb_bqc: canBetSingle = m.bqcSingle
                        case .fb_bf: canBetSingle = m.bfSingle
                        case .fb_jqs: canBetSingle = m.jqsSingle
                        default: break
                        }
                    case .jclq:
                        let m = match as! JclqMatchModel
                        switch betKey.playType {
                        case .bb_sf: canBetSingle = m.sfSingle
                        case .bb_rfsf: canBetSingle = m.rfsfSingle
                        case .bb_dxf: canBetSingle = m.dxfSingle
                        case .bb_sfc: canBetSingle = m.sfcSingle
                        default: break
                        }
                    default: break
                    }
                }
            }
        }

        let result: [SLSerialType] = SLSerialType.generalProbableSerialList(m: maxSerial, minSerial: canBetSingle ? 1 : 2)
        return result
    }
 
    /// 计算奖金
    mutating func calcBonus() {
        if lottery == .jczq {
            bonus = SLCalcBonusHelper.shared.jczq(buyModel: self as! SLBuyModel<JczqMatchModel, JczqBetKeyType>)
        } else if lottery == .jclq {
            bonus = SLCalcBonusHelper.shared.jzlq(buyModel: self as! SLBuyModel<JclqMatchModel, JclqBetKeyType>)
        }
    }
}

/**
 * 竞技彩购买
 *
 * ******************************************
 * ```
 * lottery_id: Int 彩种id
 * play_id: Int 玩法
 * bet_count: Int 注数
 * total_money: Double 总金额
 * single_money: Double 单注金额默认2.00只有大乐透追加投注为3
 * order_type: Int 订单类型 0:代购自购 1:发单 2:复制跟单 3:追号 4:合买
 * ```
 * ******************************************
 * ```
 * 足球篮球
 *
 * multiple: Int 倍数
 * issue: String 期号
 * ----仅竞彩足球做发单----
 * is_secret: Int 保密设置order_type为3发单时 0:公开无佣金 1:截止后公开有佣金
 * reason: String 发单理由
 *
 * serial_list: Array<String> 串关方式 [1串1,2串1,3串1]
 * match_list: Array<Match> 投注赛事列表 [Match]
 *
 * Match: {
 *      id: Int
 *      let_ball: Double 让球
 *      dxf_num: 大小分
 *      is_must_bet: Bool 胆拖(必须投注)
 *      bet_list: Array<Bet> 投注内容
 * }
 *
 * Bet: {
 *      bet_key: String 投注key (bf_sp13或spf_sp3等)
 *      sp: Double sp值
 * }
 * ```
 * ******************************************
 */
extension SLBuyModel {
    var toJsonString: String {
        let list = matchList.map {
            combination -> [String : Any] in
            let betList = combination.betKeyList.map {
                betKey in
                return ["bet_key": betKey.key, "sp": betKey.sp]
            }
            let item: [String : Any] = [
                "id": combination.match.id,
                "let_ball": combination.match.letBall,
                "dxf_num": (combination.match as? JclqMatchModel)?.dxfNum ?? 0,
                "is_must_bet": combination.isMustBet,
                "bet_list": betList,
                "recommend_id": combination.match.recommendId
                ]
            return item
        }
        let dict: [String: Any] = [
            "lottery_id": lottery.rawValue,
            "play_id": play.rawValue,
            "bet_count": betCount,
            "total_money": totalMoney,
            "single_money": singleMoney,
            "order_type": orderBuyType.rawValue,
            "multiple": multiple,
            "issue": issue,
            "is_secret": isSecret,
            "reason": reason,
            "serial_list": selectedSerialList.map { $0.rawValue },
            "match_list": list
        ]
        let jsonString = JSON(dict).rawString([.castNilToNSNull: true]) ?? ""
        return jsonString
    }
}
