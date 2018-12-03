//
// Created by tianshui on 2018/4/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 竞彩足球对阵
struct JczqMatchModel: SLMatchModelProtocol {

    var json: JSON

    var id: Int
    var home: String
    var away: String
    var xid: Int
    var issue: String
    var matchTime: TimeInterval
    var color: UIColor
    var leagueName: String
    var score: String?
    var halfScore: String?
    var letBall: Double
    var saleStatus: SLMatchSaleStatusType
    
    var recommendId: Int
    
    
    /// 主队logo
    var homeLogo: String
    /// 客队logo
    var awayLogo: String

    /// 竞彩序号
    var serial: String

    /// 销售截止时间
    var saleEndTime: TimeInterval

    /// 销售截止时间
    var saleEndTimeString: String

    /// 胜平负固定过关
    var spfFixed: Bool

    /// 让球胜平负固定过关
    var rqspfFixed: Bool

    /// 半全场固定过关
    var bqcFixed: Bool

    /// 进球数固定过关
    var jqsFixed: Bool

    /// 比分固定过关
    var bfFixed: Bool

    /// 胜平负单关
    var spfSingle: Bool

    /// 让球胜平负单关
    var rqspfSingle: Bool

    /// 半全场单关
    var bqcSingle: Bool

    /// 进球数单关
    var jqsSingle: Bool

    /// 比分单关
    var bfSingle: Bool

    /// 胜平负赔率
    var spf_sp3: JczqBetKeyType
    var spf_sp1: JczqBetKeyType
    var spf_sp0: JczqBetKeyType

    /// 让球胜平负赔率
    var rqspf_sp3: JczqBetKeyType
    var rqspf_sp1: JczqBetKeyType
    var rqspf_sp0: JczqBetKeyType

    /// 进球数赔率
    var jqs_sp0: JczqBetKeyType
    var jqs_sp1: JczqBetKeyType
    var jqs_sp2: JczqBetKeyType
    var jqs_sp3: JczqBetKeyType
    var jqs_sp4: JczqBetKeyType
    var jqs_sp5: JczqBetKeyType
    var jqs_sp6: JczqBetKeyType
    var jqs_sp7: JczqBetKeyType

    /// 半全场赔率
    var bqc_sp00: JczqBetKeyType
    var bqc_sp01: JczqBetKeyType
    var bqc_sp03: JczqBetKeyType
    var bqc_sp10: JczqBetKeyType
    var bqc_sp11: JczqBetKeyType
    var bqc_sp13: JczqBetKeyType
    var bqc_sp30: JczqBetKeyType
    var bqc_sp31: JczqBetKeyType
    var bqc_sp33: JczqBetKeyType

    /// 比分赔率
    var bf_sp00: JczqBetKeyType
    var bf_sp01: JczqBetKeyType
    var bf_sp02: JczqBetKeyType
    var bf_sp03: JczqBetKeyType
    var bf_sp04: JczqBetKeyType
    var bf_sp05: JczqBetKeyType
    var bf_sp10: JczqBetKeyType
    var bf_sp11: JczqBetKeyType
    var bf_sp12: JczqBetKeyType
    var bf_sp13: JczqBetKeyType
    var bf_sp14: JczqBetKeyType
    var bf_sp15: JczqBetKeyType
    var bf_sp20: JczqBetKeyType
    var bf_sp21: JczqBetKeyType
    var bf_sp22: JczqBetKeyType
    var bf_sp23: JczqBetKeyType
    var bf_sp24: JczqBetKeyType
    var bf_sp25: JczqBetKeyType
    var bf_sp30: JczqBetKeyType
    var bf_sp31: JczqBetKeyType
    var bf_sp32: JczqBetKeyType
    var bf_sp33: JczqBetKeyType
    var bf_sp40: JczqBetKeyType
    var bf_sp41: JczqBetKeyType
    var bf_sp42: JczqBetKeyType
    var bf_sp50: JczqBetKeyType
    var bf_sp51: JczqBetKeyType
    var bf_sp52: JczqBetKeyType

    /// 比分负其他
    var bf_spA0: JczqBetKeyType
    /// 比分平其他
    var bf_spA1: JczqBetKeyType
    /// 比分胜其他
    var bf_spA3: JczqBetKeyType
    
    /// 上下单双  上单
    var sxds_spsd: JczqBetKeyType
    /// 上下单双 下单
    var sxds_spxd: JczqBetKeyType
    /// 上下单双  单双
    var sxds_spss: JczqBetKeyType
    /// 上下单双  下双
    var sxds_spxs: JczqBetKeyType

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        home = json["home3"].stringValue
        away = json["away3"].stringValue
        xid = json["xid"].intValue
        issue = json["issue"].stringValue
        recommendId = 0
        matchTime = json["match_time"].doubleValue
        color = UIColor(rgba: json["color"].stringValue)
        leagueName = json["league_name"].stringValue
        saleStatus = SLMatchSaleStatusType(rawValue: json["status"].intValue) ?? .normal
        let score = json["score"].stringValue
        // 1:2
        if score.split(separator: ":").count == 2 {
            self.score = score
        }
        let halfScore = json["score_half"].stringValue
        if score.split(separator: ":").count == 2 {
            self.halfScore = halfScore
        }
        homeLogo = json["home_logo"].stringValue
        awayLogo = json["away_logo"].stringValue

        serial = json["serial"].stringValue
        letBall = json["let_ball"].doubleValue
        saleEndTime = json["sale_end_time"].doubleValue
        saleEndTimeString = "\(Date(timeIntervalSince1970: saleEndTime).string(format: "HH:mm"))"

        spfFixed = json["spf_fixed"].boolValue
        rqspfFixed = json["rqspf_fixed"].boolValue
        bqcFixed = json["bqc_fixed"].boolValue
        jqsFixed = json["jqs_fixed"].boolValue
        bfFixed = json["bf_fixed"].boolValue
        spfSingle = json["spf_single"].boolValue
        rqspfSingle = json["rqspf_single"].boolValue
        bqcSingle = json["bqc_single"].boolValue
        jqsSingle = json["jqs_single"].boolValue
        bfSingle = json["bf_single"].boolValue

        spf_sp3 = JczqBetKeyType.spf_sp3(sp: json["spf_sp3"].doubleValue)
        spf_sp1 = JczqBetKeyType.spf_sp1(sp: json["spf_sp1"].doubleValue)
        spf_sp0 = JczqBetKeyType.spf_sp0(sp: json["spf_sp0"].doubleValue)
        rqspf_sp3 = JczqBetKeyType.rqspf_sp3(sp: json["rqspf_sp3"].doubleValue)
        rqspf_sp1 = JczqBetKeyType.rqspf_sp1(sp: json["rqspf_sp1"].doubleValue)
        rqspf_sp0 = JczqBetKeyType.rqspf_sp0(sp: json["rqspf_sp0"].doubleValue)
        jqs_sp0 = JczqBetKeyType.jqs_sp0(sp: json["jqs_sp0"].doubleValue)
        jqs_sp1 = JczqBetKeyType.jqs_sp1(sp: json["jqs_sp1"].doubleValue)
        jqs_sp2 = JczqBetKeyType.jqs_sp2(sp: json["jqs_sp2"].doubleValue)
        jqs_sp3 = JczqBetKeyType.jqs_sp3(sp: json["jqs_sp3"].doubleValue)
        jqs_sp4 = JczqBetKeyType.jqs_sp4(sp: json["jqs_sp4"].doubleValue)
        jqs_sp5 = JczqBetKeyType.jqs_sp5(sp: json["jqs_sp5"].doubleValue)
        jqs_sp6 = JczqBetKeyType.jqs_sp6(sp: json["jqs_sp6"].doubleValue)
        jqs_sp7 = JczqBetKeyType.jqs_sp7(sp: json["jqs_sp7"].doubleValue)
        bqc_sp00 = JczqBetKeyType.bqc_sp00(sp: json["bqc_sp00"].doubleValue)
        bqc_sp01 = JczqBetKeyType.bqc_sp01(sp: json["bqc_sp01"].doubleValue)
        bqc_sp03 = JczqBetKeyType.bqc_sp03(sp: json["bqc_sp03"].doubleValue)
        bqc_sp10 = JczqBetKeyType.bqc_sp10(sp: json["bqc_sp10"].doubleValue)
        bqc_sp11 = JczqBetKeyType.bqc_sp11(sp: json["bqc_sp11"].doubleValue)
        bqc_sp13 = JczqBetKeyType.bqc_sp13(sp: json["bqc_sp13"].doubleValue)
        bqc_sp30 = JczqBetKeyType.bqc_sp30(sp: json["bqc_sp30"].doubleValue)
        bqc_sp31 = JczqBetKeyType.bqc_sp31(sp: json["bqc_sp31"].doubleValue)
        bqc_sp33 = JczqBetKeyType.bqc_sp33(sp: json["bqc_sp33"].doubleValue)
        bf_sp00 = JczqBetKeyType.bf_sp00(sp: json["bf_sp00"].doubleValue)
        bf_sp01 = JczqBetKeyType.bf_sp01(sp: json["bf_sp01"].doubleValue)
        bf_sp02 = JczqBetKeyType.bf_sp02(sp: json["bf_sp02"].doubleValue)
        bf_sp03 = JczqBetKeyType.bf_sp03(sp: json["bf_sp03"].doubleValue)
        bf_sp04 = JczqBetKeyType.bf_sp04(sp: json["bf_sp04"].doubleValue)
        bf_sp05 = JczqBetKeyType.bf_sp05(sp: json["bf_sp05"].doubleValue)
        bf_sp10 = JczqBetKeyType.bf_sp10(sp: json["bf_sp10"].doubleValue)
        bf_sp11 = JczqBetKeyType.bf_sp11(sp: json["bf_sp11"].doubleValue)
        bf_sp12 = JczqBetKeyType.bf_sp12(sp: json["bf_sp12"].doubleValue)
        bf_sp13 = JczqBetKeyType.bf_sp13(sp: json["bf_sp13"].doubleValue)
        bf_sp14 = JczqBetKeyType.bf_sp14(sp: json["bf_sp14"].doubleValue)
        bf_sp15 = JczqBetKeyType.bf_sp15(sp: json["bf_sp15"].doubleValue)
        bf_sp20 = JczqBetKeyType.bf_sp20(sp: json["bf_sp20"].doubleValue)
        bf_sp21 = JczqBetKeyType.bf_sp21(sp: json["bf_sp21"].doubleValue)
        bf_sp22 = JczqBetKeyType.bf_sp22(sp: json["bf_sp22"].doubleValue)
        bf_sp23 = JczqBetKeyType.bf_sp23(sp: json["bf_sp23"].doubleValue)
        bf_sp24 = JczqBetKeyType.bf_sp24(sp: json["bf_sp24"].doubleValue)
        bf_sp25 = JczqBetKeyType.bf_sp25(sp: json["bf_sp25"].doubleValue)
        bf_sp30 = JczqBetKeyType.bf_sp30(sp: json["bf_sp30"].doubleValue)
        bf_sp31 = JczqBetKeyType.bf_sp31(sp: json["bf_sp31"].doubleValue)
        bf_sp32 = JczqBetKeyType.bf_sp32(sp: json["bf_sp32"].doubleValue)
        bf_sp33 = JczqBetKeyType.bf_sp33(sp: json["bf_sp33"].doubleValue)
        bf_sp40 = JczqBetKeyType.bf_sp40(sp: json["bf_sp40"].doubleValue)
        bf_sp41 = JczqBetKeyType.bf_sp41(sp: json["bf_sp41"].doubleValue)
        bf_sp42 = JczqBetKeyType.bf_sp42(sp: json["bf_sp42"].doubleValue)
        bf_sp50 = JczqBetKeyType.bf_sp50(sp: json["bf_sp50"].doubleValue)
        bf_sp51 = JczqBetKeyType.bf_sp51(sp: json["bf_sp51"].doubleValue)
        bf_sp52 = JczqBetKeyType.bf_sp52(sp: json["bf_sp52"].doubleValue)
        bf_spA3 = JczqBetKeyType.bf_spA3(sp: json["bf_spA3"].doubleValue)
        bf_spA1 = JczqBetKeyType.bf_spA1(sp: json["bf_spA1"].doubleValue)
        bf_spA0 = JczqBetKeyType.bf_spA0(sp: json["bf_spA0"].doubleValue)
        
        sxds_spsd = JczqBetKeyType.bf_spA0(sp: json["sxds_spsd"].doubleValue)
        sxds_spxd = JczqBetKeyType.bf_spA0(sp: json["sxds_spxd"].doubleValue)
        sxds_spss = JczqBetKeyType.bf_spA0(sp: json["sxds_spss"].doubleValue)
        sxds_spxs = JczqBetKeyType.bf_spA0(sp: json["sxds_spxs"].doubleValue)
    }
    
    /**
     * 根据betKey 获取对应的bet
     */
    func getBetKeyTypeFromBetKey(beteKey: String) -> JczqBetKeyType {
        switch beteKey {
            /// 胜平负赔率
            
        case spf_sp3.key: return spf_sp3
        case spf_sp1.key: return spf_sp1
        case spf_sp0.key: return spf_sp0
            
        /// 让球胜平负赔率
        case rqspf_sp3.key: return rqspf_sp3
        case rqspf_sp1.key: return rqspf_sp1
        case rqspf_sp0.key: return rqspf_sp0
            
        /// 进球数赔率
        case jqs_sp0.key: return jqs_sp0
        case jqs_sp1.key: return jqs_sp1
        case jqs_sp2.key: return jqs_sp2
        case jqs_sp3.key: return jqs_sp3
        case jqs_sp4.key: return jqs_sp4
        case jqs_sp5.key: return jqs_sp5
        case jqs_sp6.key: return jqs_sp6
        case jqs_sp7.key: return jqs_sp7
            
        /// 半全场赔率
        case bqc_sp00.key: return bqc_sp00
        case bqc_sp01.key: return bqc_sp01
        case bqc_sp03.key: return bqc_sp03
        case bqc_sp10.key: return bqc_sp10
        case bqc_sp11.key: return bqc_sp11
        case bqc_sp13.key: return bqc_sp13
        case bqc_sp30.key: return bqc_sp30
        case bqc_sp31.key: return bqc_sp31
        case bqc_sp33.key: return bqc_sp33
            
        /// 比分赔率
        case bf_sp00.key: return bf_sp00
        case bf_sp01.key: return bf_sp01
        case bf_sp02.key: return bf_sp02
        case bf_sp03.key: return bf_sp03
        case bf_sp04.key: return bf_sp04
        case bf_sp05.key: return bf_sp05
        case bf_sp10.key: return bf_sp10
        case bf_sp11.key: return bf_sp11
        case bf_sp12.key: return bf_sp12
        case bf_sp13.key: return bf_sp13
        case bf_sp14.key: return bf_sp14
        case bf_sp15.key: return bf_sp15
        case bf_sp20.key: return bf_sp20
        case bf_sp21.key: return bf_sp21
        case bf_sp22.key: return bf_sp22
        case bf_sp23.key: return bf_sp23
        case bf_sp24.key: return bf_sp24
        case bf_sp25.key: return bf_sp25
        case bf_sp30.key: return bf_sp30
        case bf_sp31.key: return bf_sp31
        case bf_sp32.key: return bf_sp32
        case bf_sp33.key: return bf_sp33
        case bf_sp40.key: return bf_sp40
        case bf_sp41.key: return bf_sp41
        case bf_sp42.key: return bf_sp42
        case bf_sp50.key: return bf_sp50
        case bf_sp51.key: return bf_sp51
        case bf_sp52.key: return bf_sp52
            
        /// 比分负其他
        case bf_spA0.key: return bf_spA0
        /// 比分平其他
        case bf_spA1.key: return bf_spA1
        /// 比分胜其他
        case bf_spA3.key: return bf_spA3
            
        /// 上下单双  上单
        case sxds_spsd.key: return sxds_spsd
        /// 上下单双 下单
        case sxds_spxd.key: return sxds_spxd
        /// 上下单双  单双
        case sxds_spss.key: return sxds_spss
        /// 上下单双  下双
        default: return sxds_spxs
            
        }
        
    }
    
}

