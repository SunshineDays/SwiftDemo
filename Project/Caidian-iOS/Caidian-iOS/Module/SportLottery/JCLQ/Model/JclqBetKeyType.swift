//
// Created by tianshui on 2018/5/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 竞彩篮球投注key
enum JclqBetKeyType: SLBetKeyProtocol {

    /// 胜负赔率
    case sf_sp3(sp: Double)
    case sf_sp0(sp: Double)

    /// 让分胜负赔率
    case rfsf_sp3(sp: Double)
    case rfsf_sp0(sp: Double)

    /// 大小分赔率
    case dxf_sp3(sp: Double)
    case dxf_sp0(sp: Double)

    /// 胜分差 0主1客
    case sfc_sp11(sp: Double)
    case sfc_sp12(sp: Double)
    case sfc_sp13(sp: Double)
    case sfc_sp14(sp: Double)
    case sfc_sp15(sp: Double)
    case sfc_sp16(sp: Double)
    case sfc_sp01(sp: Double)
    case sfc_sp02(sp: Double)
    case sfc_sp03(sp: Double)
    case sfc_sp04(sp: Double)
    case sfc_sp05(sp: Double)
    case sfc_sp06(sp: Double)

    init?(key: String, sp: Double) {
        switch key {
        case "sf_sp3": self = .sf_sp3(sp: sp)
        case "sf_sp0": self = .sf_sp0(sp: sp)

        case "rfsf_sp3": self = .rfsf_sp3(sp: sp)
        case "rfsf_sp0": self = .rfsf_sp0(sp: sp)

        case "dxf_sp3": self = .dxf_sp3(sp: sp)
        case "dxf_sp0": self = .dxf_sp0(sp: sp)

        case "sfc_sp11": self = .sfc_sp11(sp: sp)
        case "sfc_sp12": self = .sfc_sp12(sp: sp)
        case "sfc_sp13": self = .sfc_sp13(sp: sp)
        case "sfc_sp14": self = .sfc_sp14(sp: sp)
        case "sfc_sp15": self = .sfc_sp15(sp: sp)
        case "sfc_sp16": self = .sfc_sp16(sp: sp)
        case "sfc_sp01": self = .sfc_sp01(sp: sp)
        case "sfc_sp02": self = .sfc_sp02(sp: sp)
        case "sfc_sp03": self = .sfc_sp03(sp: sp)
        case "sfc_sp04": self = .sfc_sp04(sp: sp)
        case "sfc_sp05": self = .sfc_sp05(sp: sp)
        case "sfc_sp06": self = .sfc_sp06(sp: sp)

        default: return nil
        }
    }

    var name: String {
        switch self {
        case .sf_sp3(_): return "主胜"
        case .sf_sp0(_): return "主负"

        case .rfsf_sp3(_): return "让分主胜"
        case .rfsf_sp0(_): return "让分主负"

        case .dxf_sp3(_): return "大分"
        case .dxf_sp0(_): return "小分"

        case .sfc_sp01(_): return "主胜1-5"
        case .sfc_sp02(_): return "主胜6-10"
        case .sfc_sp03(_): return "主胜11-15"
        case .sfc_sp04(_): return "主胜16-20"
        case .sfc_sp05(_): return "主胜21-25"
        case .sfc_sp06(_): return "主胜26+"
        case .sfc_sp11(_): return "客胜1-5"
        case .sfc_sp12(_): return "客胜6-10"
        case .sfc_sp13(_): return "客胜11-15"
        case .sfc_sp14(_): return "客胜16-20"
        case .sfc_sp15(_): return "客胜21-25"
        case .sfc_sp16(_): return "客胜26+"
        }
    }

    var key: String {
        switch self {
        case .sf_sp3(_): return "sf_sp3"
        case .sf_sp0(_): return "sf_sp0"

        case .rfsf_sp3(_): return "rfsf_sp3"
        case .rfsf_sp0(_): return "rfsf_sp0"

        case .dxf_sp3(_): return "dxf_sp3"
        case .dxf_sp0(_): return "dxf_sp0"

        case .sfc_sp01(_): return "sfc_sp01"
        case .sfc_sp02(_): return "sfc_sp02"
        case .sfc_sp03(_): return "sfc_sp03"
        case .sfc_sp04(_): return "sfc_sp04"
        case .sfc_sp05(_): return "sfc_sp05"
        case .sfc_sp06(_): return "sfc_sp06"
        case .sfc_sp11(_): return "sfc_sp11"
        case .sfc_sp12(_): return "sfc_sp12"
        case .sfc_sp13(_): return "sfc_sp13"
        case .sfc_sp14(_): return "sfc_sp14"
        case .sfc_sp15(_): return "sfc_sp15"
        case .sfc_sp16(_): return "sfc_sp16"
        }
    }

    var sp: Double {
        switch self {
        case let .sf_sp3(sp): return sp
        case let .sf_sp0(sp): return sp

        case let .rfsf_sp3(sp): return sp
        case let .rfsf_sp0(sp): return sp

        case let .dxf_sp3(sp): return sp
        case let .dxf_sp0(sp): return sp

        case let .sfc_sp11(sp): return sp
        case let .sfc_sp12(sp): return sp
        case let .sfc_sp13(sp): return sp
        case let .sfc_sp14(sp): return sp
        case let .sfc_sp15(sp): return sp
        case let .sfc_sp16(sp): return sp
        case let .sfc_sp01(sp): return sp
        case let .sfc_sp02(sp): return sp
        case let .sfc_sp03(sp): return sp
        case let .sfc_sp04(sp): return sp
        case let .sfc_sp05(sp): return sp
        case let .sfc_sp06(sp): return sp
        }
    }

    ///
    /// 此投注项根据赛果是否命中
    ///
    /// - Parameters:
    ///   - letScore: 让分
    ///   - dxfNum: 大小分
    ///   - homeScore: 主得分
    ///   - awayScore: 客得分
    /// - Returns: Bool
    func isHit(letScore: Double, dxfNum: Double, homeScore: Int, awayScore: Int) -> Bool {
        let homeScore = Double(homeScore)
        let awayScore = Double(awayScore)
        let diff = homeScore - awayScore

        switch self {
        case .sf_sp3(_): return homeScore > awayScore
        case .sf_sp0(_): return homeScore < awayScore

        case .rfsf_sp3(_): return homeScore + letScore > awayScore
        case .rfsf_sp0(_): return homeScore + letScore < awayScore

        case .dxf_sp3(_): return homeScore + awayScore > dxfNum
        case .dxf_sp0(_): return homeScore + awayScore < dxfNum

        case .sfc_sp01(_): return diff >= 1 && diff <= 5
        case .sfc_sp02(_): return diff >= 6 && diff <= 10
        case .sfc_sp03(_): return diff >= 11 && diff <= 15
        case .sfc_sp04(_): return diff >= 16 && diff <= 20
        case .sfc_sp05(_): return diff >= 21 && diff <= 25
        case .sfc_sp06(_): return diff >= 26
        case .sfc_sp11(_): return diff <= -1 && diff >= -5
        case .sfc_sp12(_): return diff <= -6 && diff >= -10
        case .sfc_sp13(_): return diff <= -11 && diff >= -15
        case .sfc_sp14(_): return diff <= -16 && diff >= -20
        case .sfc_sp15(_): return diff <= -21 && diff >= -25
        case .sfc_sp16(_): return diff <= -26
        }
    }
}
