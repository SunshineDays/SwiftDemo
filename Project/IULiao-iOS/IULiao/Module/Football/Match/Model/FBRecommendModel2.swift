//
// Created by tianshui on 2017/12/20.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 推荐
struct FBRecommendModel2: BaseModelProtocol {
    var json: JSON

    var id: Int

    var matchId: Int
    
    var matchId2: Int

    var userId: Int
    
    var oddsType: RecommendDetailOddsType

    /// 玩法
    var playType: PlayType

    /// 彩果
    var result: ResultType

    /// 投注赔率
    var betOdds: BetOdds
    
    var betOdds2: BetOdds

    /// 投注内容
    var betOnList: [BetOnList]

    var betOnList2: [BetOnList]
    
    var betons = [BetOn]()
    var betons2 = [BetOn]()
    
    /// 点击量
    var hits: Int

    /// 发单时间
    var createTime: TimeInterval
    
    /// 理由
    var reason: String
    
    /// 时间场次
    var serial: String
    
    var match: FBRecommendSponsorMatchModel
    
    var match2: FBRecommendSponsorMatchModel
    
    var user: FBRecommendDetailUserModel


    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        matchId = json["mid"].intValue
        matchId2 = json["mid2"].intValue
        userId = json["userid"].intValue
        oddsType = RecommendDetailOddsType(rawValue: json["oddstype"].intValue)!
        playType = PlayType(rawValue: json["oddstype"].intValue) ?? .none
        result = ResultType(rawValue: json["result"].intValue) ?? .none
        betOdds = BetOdds(json: json["odds"])
        betOdds2 = BetOdds(json: json["odds"])
        betOnList = json["betons"].arrayValue.map {
            BetOnList(json: $0)
        }
        betOnList2 = json["betons2"].arrayValue.map {
            BetOnList(json: $0)
        }
        hits = json["hits"].intValue
        createTime = json["created"].doubleValue
        reason = json["reason"].stringValue
        serial = json["serial"].stringValue

        match = FBRecommendSponsorMatchModel(json: json["match"])
        match2 = FBRecommendSponsorMatchModel(json: json["match2"])
        betons = json["betons"].arrayValue.map { BetOn(json: $0) }
        betons2 = json["betons2"].arrayValue.map { BetOn(json: $0) }
        user = FBRecommendDetailUserModel(json: json["user"])
    }

    enum PlayType: Int {
        /// 亚盘
        case asia = 3
        /// 大小球
        case bigSmall = 4
        /// 欧赔
        case europe = 5
        /// 竞彩
        case jingcai = 11
        
        
        case none = 0

        var name: String? {
            switch self {
            case .asia: return "亚盘"
            case .bigSmall: return "大小球"
            case .europe: return "欧赔"
            case .jingcai: return "竞彩"
            case .none: return nil
            }
        }

        var color: UIColor? {
            switch self {
            case .asia: return UIColor(hex: 0xf49900)
            case .bigSmall: return UIColor(hex: 0x4abdff)
            case .europe: return UIColor(hex: 0xE65757)
            case .jingcai: return UIColor(hex: 0xff604b)
            case .none: return nil
            }
        }
    }

    /// 投注内容
    struct BetOnList {
        var betKey: BetKeyType
        /// 投注赔率
        var sp: Double

        /// 投注key
        enum BetKeyType: String {
            case win, draw, lost
            case letWin = "letwin", letDraw = "letdraw", letLost = "letlost"
            case above, below
            case big, handicap, small
            case none

            var name: String {
                switch self {
                case .win: return "胜"
                case .draw: return "平"
                case .lost: return "负"
                case .letWin: return "让胜"
                case .letDraw: return "让平"
                case .letLost: return "让负"
                case .above: return "主"
                case .below: return "客"
                case .big: return "大球"
                case .handicap: return "平"
                case .small: return "小球"
                case .none: return ""
                }
            }
        }

        init(betKey: BetKeyType, sp: Double) {
            self.betKey = betKey
            self.sp = sp
        }

        init(json: JSON) {
            betKey = BetKeyType(rawValue: json["betkey"].stringValue) ?? .none
            sp = json["sp"].doubleValue
        }
    }

    /// 投注赔率
    struct BetOdds {
        /// 让球
        var letBall = 0
        /// 竞彩开售情况
        var openSale: OpenSaleType
        /// 竞彩非让球赔率
        var jingcaiNormal: FBOddsEuropeModel
        /// 竞彩让球赔率
        var jingcaiLetball: FBOddsEuropeModel
        /// 亚盘
        var asia: FBOddsAsiaModel
        /// 大小球
        var bigSmall: FBOddsBigSmallModel
        /// 欧赔
        var europe: FBOddsEuropeModel

        init(json: JSON) {
            letBall = json["letball"].intValue
            jingcaiNormal = FBOddsEuropeModel(win: json["win"].doubleValue, draw: json["draw"].doubleValue, lost: json["lost"].doubleValue)
            jingcaiLetball = FBOddsEuropeModel(win: json["letwin"].doubleValue, draw: json["letdraw"].doubleValue, lost: json["letlost"].doubleValue)
            asia = FBOddsAsiaModel(above: json["above"].doubleValue, below: json["below"].doubleValue, handicap: json["handicap"].stringValue, bet: json["bet"].intValue)
            bigSmall = FBOddsBigSmallModel(big: json["big"].doubleValue, small: json["small"].doubleValue, handicap: json["handicap"].stringValue, bet: json["bet"].intValue)
            europe = FBOddsEuropeModel(win: json["win"].doubleValue, draw: json["draw"].doubleValue, lost: json["lost"].doubleValue)
            openSale = OpenSaleType(rawValue: json["opensale"].intValue) ?? .all
        }

        enum OpenSaleType: Int {
            /// 非让球
            case normal = 1
            /// 让球
            case letBall = 2
            /// 全部
            case all = 3
        }
    }

    /// 彩果
    enum ResultType: Int, CustomStringConvertible {
        case none = 0, lost, lostHalf, draw, winHalf, win

        var image: UIImage? {
            switch self {
            case .win: return R.image.fbRecommend2.resultWin()
            case .winHalf: return R.image.fbRecommend2.resultWinHalf()
            case .draw: return R.image.fbRecommend2.resultDraw()
            case .lostHalf: return R.image.fbRecommend2.resultLostHalf()
            case .lost: return R.image.fbRecommend2.resultLost()
            case .none: return nil
            }
        }

        var description: String {
            switch self {
            case .win: return "赢"
            case .winHalf: return "赢半"
            case .draw: return "走"
            case .lostHalf: return "输半"
            case .lost: return "输"
            case .none: return ""
            }
        }
    }
}
