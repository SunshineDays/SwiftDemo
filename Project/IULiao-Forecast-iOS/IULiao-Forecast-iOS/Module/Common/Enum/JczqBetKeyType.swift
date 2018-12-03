//
// Created by tianshui on 2018/4/19.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 投注项
protocol BetKeyProtocol { // }: Equatable {
    
    /// 显示名
    var name: String { get }
    
    /// 投注key 唯一
    var key: String { get }
    
    /// sp赔率值
    var sp: Double { get }
    
    /// 所属玩法
    var playType: PlayType { get }
}

extension BetKeyProtocol {
    
    var playType: PlayType {
        let str = String(key.split(separator: "_")[0])
        return PlayType(betKey: str)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.key == rhs.key
    }
}

/// 投注key
enum JczqBetKeyType: BetKeyProtocol {

    /// 胜平负赔率
    case spf_sp3(sp: Double)
    case spf_sp1(sp: Double)
    case spf_sp0(sp: Double)

    /// 让球胜平负赔率
    case rqspf_sp3(sp: Double)
    case rqspf_sp1(sp: Double)
    case rqspf_sp0(sp: Double)

    /// 进球数赔率
    case jqs_sp0(sp: Double)
    case jqs_sp1(sp: Double)
    case jqs_sp2(sp: Double)
    case jqs_sp3(sp: Double)
    case jqs_sp4(sp: Double)
    case jqs_sp5(sp: Double)
    case jqs_sp6(sp: Double)
    case jqs_sp7(sp: Double)

    /// 半全场赔率
    case bqc_sp00(sp: Double)
    case bqc_sp01(sp: Double)
    case bqc_sp03(sp: Double)
    case bqc_sp10(sp: Double)
    case bqc_sp11(sp: Double)
    case bqc_sp13(sp: Double)
    case bqc_sp30(sp: Double)
    case bqc_sp31(sp: Double)
    case bqc_sp33(sp: Double)

    /// 比分赔率
    case bf_sp00(sp: Double)
    case bf_sp01(sp: Double)
    case bf_sp02(sp: Double)
    case bf_sp03(sp: Double)
    case bf_sp04(sp: Double)
    case bf_sp05(sp: Double)
    case bf_sp10(sp: Double)
    case bf_sp11(sp: Double)
    case bf_sp12(sp: Double)
    case bf_sp13(sp: Double)
    case bf_sp14(sp: Double)
    case bf_sp15(sp: Double)
    case bf_sp20(sp: Double)
    case bf_sp21(sp: Double)
    case bf_sp22(sp: Double)
    case bf_sp23(sp: Double)
    case bf_sp24(sp: Double)
    case bf_sp25(sp: Double)
    case bf_sp30(sp: Double)
    case bf_sp31(sp: Double)
    case bf_sp32(sp: Double)
    case bf_sp33(sp: Double)
    case bf_sp40(sp: Double)
    case bf_sp41(sp: Double)
    case bf_sp42(sp: Double)
    case bf_sp50(sp: Double)
    case bf_sp51(sp: Double)
    case bf_sp52(sp: Double)

    /// 比分胜其他
    case bf_spA3(sp: Double)
    /// 比分平其他
    case bf_spA1(sp: Double)
    /// 比分负其他
    case bf_spA0(sp: Double)
    
    
    /// 上下单双
    /// 上单
    case sxds_spsd(sp : Double)
    /// 下单
    case sxds_spxd(sp : Double)
    ///  上双
    case sxds_spss(sp : Double)
    ///  下双
    case sxds_spxs(sp : Double)

    init?(key: String, sp: Double) {
        switch key {
        case "spf_sp3": self = .spf_sp3(sp: sp)
        case "spf_sp1": self = .spf_sp1(sp: sp)
        case "spf_sp0": self = .spf_sp0(sp: sp)

        case "rqspf_sp3": self = .rqspf_sp3(sp: sp)
        case "rqspf_sp1": self = .rqspf_sp1(sp: sp)
        case "rqspf_sp0": self = .rqspf_sp0(sp: sp)

        case "jqs_sp0": self = .jqs_sp0(sp: sp)
        case "jqs_sp1": self = .jqs_sp1(sp: sp)
        case "jqs_sp2": self = .jqs_sp2(sp: sp)
        case "jqs_sp3": self = .jqs_sp3(sp: sp)
        case "jqs_sp4": self = .jqs_sp4(sp: sp)
        case "jqs_sp5": self = .jqs_sp5(sp: sp)
        case "jqs_sp6": self = .jqs_sp6(sp: sp)
        case "jqs_sp7": self = .jqs_sp7(sp: sp)

        case "bqc_sp00": self = .bqc_sp00(sp: sp)
        case "bqc_sp01": self = .bqc_sp01(sp: sp)
        case "bqc_sp03": self = .bqc_sp03(sp: sp)
        case "bqc_sp10": self = .bqc_sp10(sp: sp)
        case "bqc_sp11": self = .bqc_sp11(sp: sp)
        case "bqc_sp13": self = .bqc_sp13(sp: sp)
        case "bqc_sp30": self = .bqc_sp30(sp: sp)
        case "bqc_sp31": self = .bqc_sp31(sp: sp)
        case "bqc_sp33": self = .bqc_sp33(sp: sp)

        case "bf_sp00": self = .bf_sp00(sp: sp)
        case "bf_sp01": self = .bf_sp01(sp: sp)
        case "bf_sp02": self = .bf_sp02(sp: sp)
        case "bf_sp03": self = .bf_sp03(sp: sp)
        case "bf_sp04": self = .bf_sp04(sp: sp)
        case "bf_sp05": self = .bf_sp05(sp: sp)
        case "bf_sp10": self = .bf_sp10(sp: sp)
        case "bf_sp11": self = .bf_sp11(sp: sp)
        case "bf_sp12": self = .bf_sp12(sp: sp)
        case "bf_sp13": self = .bf_sp13(sp: sp)
        case "bf_sp14": self = .bf_sp14(sp: sp)
        case "bf_sp15": self = .bf_sp15(sp: sp)
        case "bf_sp20": self = .bf_sp20(sp: sp)
        case "bf_sp21": self = .bf_sp21(sp: sp)
        case "bf_sp22": self = .bf_sp22(sp: sp)
        case "bf_sp23": self = .bf_sp23(sp: sp)
        case "bf_sp24": self = .bf_sp24(sp: sp)
        case "bf_sp25": self = .bf_sp25(sp: sp)
        case "bf_sp30": self = .bf_sp30(sp: sp)
        case "bf_sp31": self = .bf_sp31(sp: sp)
        case "bf_sp32": self = .bf_sp32(sp: sp)
        case "bf_sp33": self = .bf_sp33(sp: sp)
        case "bf_sp40": self = .bf_sp40(sp: sp)
        case "bf_sp41": self = .bf_sp41(sp: sp)
        case "bf_sp42": self = .bf_sp42(sp: sp)
        case "bf_sp50": self = .bf_sp50(sp: sp)
        case "bf_sp51": self = .bf_sp51(sp: sp)
        case "bf_sp52": self = .bf_sp52(sp: sp)
        case "bf_spA3": self = .bf_spA3(sp: sp)
        case "bf_spA1": self = .bf_spA1(sp: sp)
        case "bf_spA0": self = .bf_spA0(sp: sp)
            
        case "sxds_spsd" : self = .sxds_spsd(sp:sp)
        case "sxds_spxd" : self = .sxds_spxd(sp:sp)
        case "sxds_spss" : self = .sxds_spss(sp:sp)
        case "sxds_spxs" : self = .sxds_spxs(sp:sp)
            
        default: return nil
        }
    }

    /// 显示名
    var name: String {
        switch self {
        case .spf_sp3(_): return "胜"
        case .spf_sp1(_): return "平"
        case .spf_sp0(_): return "负"

        case .rqspf_sp3(_): return "让胜"
        case .rqspf_sp1(_): return "让平"
        case .rqspf_sp0(_): return "让负"

        case .jqs_sp0(_): return "0球"
        case .jqs_sp1(_): return "1球"
        case .jqs_sp2(_): return "2球"
        case .jqs_sp3(_): return "3球"
        case .jqs_sp4(_): return "4球"
        case .jqs_sp5(_): return "5球"
        case .jqs_sp6(_): return "6球"
        case .jqs_sp7(_): return "7+球"

        case .bqc_sp00(_): return "负负"
        case .bqc_sp01(_): return "负平"
        case .bqc_sp03(_): return "负胜"
        case .bqc_sp10(_): return "平负"
        case .bqc_sp11(_): return "平平"
        case .bqc_sp13(_): return "平胜"
        case .bqc_sp30(_): return "胜负"
        case .bqc_sp31(_): return "胜平"
        case .bqc_sp33(_): return "胜胜"

        case .bf_sp00(_): return "0:0"
        case .bf_sp01(_): return "0:1"
        case .bf_sp02(_): return "0:2"
        case .bf_sp03(_): return "0:3"
        case .bf_sp04(_): return "0:4"
        case .bf_sp05(_): return "0:5"
        case .bf_sp10(_): return "1:0"
        case .bf_sp11(_): return "1:1"
        case .bf_sp12(_): return "1:2"
        case .bf_sp13(_): return "1:3"
        case .bf_sp14(_): return "1:4"
        case .bf_sp15(_): return "1:5"
        case .bf_sp20(_): return "2:0"
        case .bf_sp21(_): return "2:1"
        case .bf_sp22(_): return "2:2"
        case .bf_sp23(_): return "2:3"
        case .bf_sp24(_): return "2:4"
        case .bf_sp25(_): return "2:5"
        case .bf_sp30(_): return "3:0"
        case .bf_sp31(_): return "3:1"
        case .bf_sp32(_): return "3:2"
        case .bf_sp33(_): return "3:3"
        case .bf_sp40(_): return "4:0"
        case .bf_sp41(_): return "4:1"
        case .bf_sp42(_): return "4:2"
        case .bf_sp50(_): return "5:0"
        case .bf_sp51(_): return "5:1"
        case .bf_sp52(_): return "5:2"
        case .bf_spA3(_): return "胜其他"
        case .bf_spA1(_): return "平其他"
        case .bf_spA0(_): return "负其他"
            
        case .sxds_spsd(_): return "上单"
        case .sxds_spxd(_): return "下单"
        case .sxds_spss(_): return "上双"
        case .sxds_spxs(_): return "上双"
        }
    }

    /// 投注key
    var key: String {
        switch self {
        case .spf_sp3(_): return "spf_sp3"
        case .spf_sp1(_): return "spf_sp1"
        case .spf_sp0(_): return "spf_sp0"

        case .rqspf_sp3(_): return "rqspf_sp3"
        case .rqspf_sp1(_): return "rqspf_sp1"
        case .rqspf_sp0(_): return "rqspf_sp0"

        case .jqs_sp0(_): return "jqs_sp0"
        case .jqs_sp1(_): return "jqs_sp1"
        case .jqs_sp2(_): return "jqs_sp2"
        case .jqs_sp3(_): return "jqs_sp3"
        case .jqs_sp4(_): return "jqs_sp4"
        case .jqs_sp5(_): return "jqs_sp5"
        case .jqs_sp6(_): return "jqs_sp6"
        case .jqs_sp7(_): return "jqs_sp7"

        case .bqc_sp00(_): return "bqc_sp00"
        case .bqc_sp01(_): return "bqc_sp01"
        case .bqc_sp03(_): return "bqc_sp03"
        case .bqc_sp10(_): return "bqc_sp10"
        case .bqc_sp11(_): return "bqc_sp11"
        case .bqc_sp13(_): return "bqc_sp13"
        case .bqc_sp30(_): return "bqc_sp30"
        case .bqc_sp31(_): return "bqc_sp31"
        case .bqc_sp33(_): return "bqc_sp33"

        case .bf_sp00(_): return "bf_sp00"
        case .bf_sp01(_): return "bf_sp01"
        case .bf_sp02(_): return "bf_sp02"
        case .bf_sp03(_): return "bf_sp03"
        case .bf_sp04(_): return "bf_sp04"
        case .bf_sp05(_): return "bf_sp05"
        case .bf_sp10(_): return "bf_sp10"
        case .bf_sp11(_): return "bf_sp11"
        case .bf_sp12(_): return "bf_sp12"
        case .bf_sp13(_): return "bf_sp13"
        case .bf_sp14(_): return "bf_sp14"
        case .bf_sp15(_): return "bf_sp15"
        case .bf_sp20(_): return "bf_sp20"
        case .bf_sp21(_): return "bf_sp21"
        case .bf_sp22(_): return "bf_sp22"
        case .bf_sp23(_): return "bf_sp23"
        case .bf_sp24(_): return "bf_sp24"
        case .bf_sp25(_): return "bf_sp25"
        case .bf_sp30(_): return "bf_sp30"
        case .bf_sp31(_): return "bf_sp31"
        case .bf_sp32(_): return "bf_sp32"
        case .bf_sp33(_): return "bf_sp33"
        case .bf_sp40(_): return "bf_sp40"
        case .bf_sp41(_): return "bf_sp41"
        case .bf_sp42(_): return "bf_sp42"
        case .bf_sp50(_): return "bf_sp50"
        case .bf_sp51(_): return "bf_sp51"
        case .bf_sp52(_): return "bf_sp52"
        case .bf_spA3(_): return "bf_spA3"
        case .bf_spA1(_): return "bf_spA1"
        case .bf_spA0(_): return "bf_spA0"
            
        case .sxds_spsd(_): return "sxds_spsd"
        case .sxds_spxd(_): return "sxds_spxd"
        case .sxds_spss(_): return "sxds_spss"
        case .sxds_spxs(_): return "sxds_spxs"
        }
    }

    /// sp赔率值
    var sp: Double {
        switch self {
        case let .spf_sp3(sp): return sp
        case let .spf_sp1(sp): return sp
        case let .spf_sp0(sp): return sp

        case let .rqspf_sp3(sp): return sp
        case let .rqspf_sp1(sp): return sp
        case let .rqspf_sp0(sp): return sp

        case let .jqs_sp0(sp): return sp
        case let .jqs_sp1(sp): return sp
        case let .jqs_sp2(sp): return sp
        case let .jqs_sp3(sp): return sp
        case let .jqs_sp4(sp): return sp
        case let .jqs_sp5(sp): return sp
        case let .jqs_sp6(sp): return sp
        case let .jqs_sp7(sp): return sp

        case let .bqc_sp00(sp): return sp
        case let .bqc_sp01(sp): return sp
        case let .bqc_sp03(sp): return sp
        case let .bqc_sp10(sp): return sp
        case let .bqc_sp11(sp): return sp
        case let .bqc_sp13(sp): return sp
        case let .bqc_sp30(sp): return sp
        case let .bqc_sp31(sp): return sp
        case let .bqc_sp33(sp): return sp

        case let .bf_sp00(sp): return sp
        case let .bf_sp01(sp): return sp
        case let .bf_sp02(sp): return sp
        case let .bf_sp03(sp): return sp
        case let .bf_sp04(sp): return sp
        case let .bf_sp05(sp): return sp
        case let .bf_sp10(sp): return sp
        case let .bf_sp11(sp): return sp
        case let .bf_sp12(sp): return sp
        case let .bf_sp13(sp): return sp
        case let .bf_sp14(sp): return sp
        case let .bf_sp15(sp): return sp
        case let .bf_sp20(sp): return sp
        case let .bf_sp21(sp): return sp
        case let .bf_sp22(sp): return sp
        case let .bf_sp23(sp): return sp
        case let .bf_sp24(sp): return sp
        case let .bf_sp25(sp): return sp
        case let .bf_sp30(sp): return sp
        case let .bf_sp31(sp): return sp
        case let .bf_sp32(sp): return sp
        case let .bf_sp33(sp): return sp
        case let .bf_sp40(sp): return sp
        case let .bf_sp41(sp): return sp
        case let .bf_sp42(sp): return sp
        case let .bf_sp50(sp): return sp
        case let .bf_sp51(sp): return sp
        case let .bf_sp52(sp): return sp
        case let .bf_spA3(sp): return sp
        case let .bf_spA1(sp): return sp
        case let .bf_spA0(sp): return sp
    
        case let .sxds_spsd(sp): return sp
        case let .sxds_spxd(sp): return sp
        case let .sxds_spss(sp): return sp
        case let .sxds_spxs(sp): return sp
        }
    }

    /// label显示名字
    var displayName: String {
        switch self {
        case .spf_sp3(_): fallthrough
        case .spf_sp1(_): fallthrough
        case .spf_sp0(_): fallthrough
        case .rqspf_sp3(_): fallthrough
        case .rqspf_sp1(_): fallthrough
        case .rqspf_sp0(_): return "\(name) \(sp.decimal(2))"
        default: return "\(name)\n\(sp.decimal(2))"
        }
    }

    /// 
    /// 此投注项根据赛果是否命中
    ///
    /// - Parameters:
    ///   - letBall: 让球
    ///   - homeScore: 主得分
    ///   - awayScore: 客得分
    ///   - homeHalfScore: 主半场得分
    ///   - awayHalfScore: 客半场得分
    /// - Returns: Bool
    func isHit(letBall: Int, homeScore: Int, awayScore: Int, homeHalfScore: Int, awayHalfScore: Int) -> Bool {
        switch self {
        case .spf_sp3(_): return homeScore > awayScore
        case .spf_sp1(_): return homeScore == awayScore
        case .spf_sp0(_): return homeScore < awayScore

        case .rqspf_sp3(_): return homeScore + letBall > awayScore
        case .rqspf_sp1(_): return homeScore + letBall == awayScore
        case .rqspf_sp0(_): return homeScore + letBall < awayScore

        case .jqs_sp0(_): return homeScore + awayScore == 0
        case .jqs_sp1(_): return homeScore + awayScore == 1
        case .jqs_sp2(_): return homeScore + awayScore == 2
        case .jqs_sp3(_): return homeScore + awayScore == 3
        case .jqs_sp4(_): return homeScore + awayScore == 4
        case .jqs_sp5(_): return homeScore + awayScore == 5
        case .jqs_sp6(_): return homeScore + awayScore == 6
        case .jqs_sp7(_): return homeScore + awayScore >= 7

        case .bqc_sp00(_): return homeHalfScore < awayHalfScore && homeScore < awayScore
        case .bqc_sp01(_): return homeHalfScore < awayHalfScore && homeScore == awayScore
        case .bqc_sp03(_): return homeHalfScore < awayHalfScore && homeScore > awayScore
        case .bqc_sp10(_): return homeHalfScore == awayHalfScore && homeScore < awayScore
        case .bqc_sp11(_): return homeHalfScore == awayHalfScore && homeScore == awayScore
        case .bqc_sp13(_): return homeHalfScore == awayHalfScore && homeScore > awayScore
        case .bqc_sp30(_): return homeHalfScore > awayHalfScore && homeScore < awayScore
        case .bqc_sp31(_): return homeHalfScore > awayHalfScore && homeScore == awayScore
        case .bqc_sp33(_): return homeHalfScore > awayHalfScore && homeScore > awayScore

        case .bf_sp00(_): return homeScore == 0 && awayScore == 0
        case .bf_sp01(_): return homeScore == 0 && awayScore == 1
        case .bf_sp02(_): return homeScore == 0 && awayScore == 2
        case .bf_sp03(_): return homeScore == 0 && awayScore == 3
        case .bf_sp04(_): return homeScore == 0 && awayScore == 4
        case .bf_sp05(_): return homeScore == 0 && awayScore == 5
        case .bf_sp10(_): return homeScore == 1 && awayScore == 0
        case .bf_sp11(_): return homeScore == 1 && awayScore == 1
        case .bf_sp12(_): return homeScore == 1 && awayScore == 2
        case .bf_sp13(_): return homeScore == 1 && awayScore == 3
        case .bf_sp14(_): return homeScore == 1 && awayScore == 4
        case .bf_sp15(_): return homeScore == 1 && awayScore == 5
        case .bf_sp20(_): return homeScore == 2 && awayScore == 0
        case .bf_sp21(_): return homeScore == 2 && awayScore == 1
        case .bf_sp22(_): return homeScore == 2 && awayScore == 2
        case .bf_sp23(_): return homeScore == 2 && awayScore == 3
        case .bf_sp24(_): return homeScore == 2 && awayScore == 4
        case .bf_sp25(_): return homeScore == 2 && awayScore == 5
        case .bf_sp30(_): return homeScore == 3 && awayScore == 0
        case .bf_sp31(_): return homeScore == 3 && awayScore == 1
        case .bf_sp32(_): return homeScore == 3 && awayScore == 2
        case .bf_sp33(_): return homeScore == 3 && awayScore == 3
        case .bf_sp40(_): return homeScore == 4 && awayScore == 0
        case .bf_sp41(_): return homeScore == 4 && awayScore == 1
        case .bf_sp42(_): return homeScore == 4 && awayScore == 2
        case .bf_sp50(_): return homeScore == 5 && awayScore == 0
        case .bf_sp51(_): return homeScore == 5 && awayScore == 1
        case .bf_sp52(_): return homeScore == 5 && awayScore == 2
        // 胜其他
        case .bf_spA3(_):
            return homeScore + awayScore > 7 && homeScore > awayScore
                    || homeScore == 4 && awayScore == 3
                    || homeScore == 6 && awayScore == 1
                    || homeScore == 7 && awayScore == 0
        // 平其他
        case .bf_spA1(_): return homeScore >= 4 && awayScore >= 4 && homeScore == awayScore
        // 负其他
        case .bf_spA0(_):
            return homeScore + awayScore > 7 && homeScore < awayScore
                    || homeScore == 3 && awayScore == 4
                    || homeScore == 1 && awayScore == 6
                    || homeScore == 0 && awayScore == 7
            
        // 上单  主客队进球数之和 >=3 上盘 else 下盘
        case .sxds_spsd(_): return (homeScore + awayScore) >= 3 && (homeScore + awayScore) % 2 == 1
        case .sxds_spxd(_): return (homeScore + awayScore) >= 3 && (homeScore + awayScore) % 2 == 0
        case .sxds_spss(_): return (homeScore + awayScore) < 3 && (homeScore + awayScore) % 2 == 1
        case .sxds_spxs(_): return (homeScore + awayScore) < 3 && (homeScore + awayScore) % 2 == 0
        }
       
    }
}
