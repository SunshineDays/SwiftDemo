//
//  PlayType.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/9.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 玩法类型
enum PlayType: Int {

    /// 无
    case none = 0

    /// 混合玩法
    case hh = 7

    // --------------------------------------------------
    // 足球 竞彩,北单
    // --------------------------------------------------

    /// 足球 胜平负 fb:football
    case fb_spf = 1

    /// 足球 让球胜平负
    case fb_rqspf = 2

    /// 足球 总进球数
    case fb_jqs = 3

    /// 足球 比分
    case fb_bf = 4

    /// 足球 半全场
    case fb_bqc = 5

    /// 足球 上下单双
    case fb_sxds = 6

    // --------------------------------------------------
    // 篮球
    // --------------------------------------------------

    /// 篮球 胜负 bb:basketball
    case bb_sf = 21

    /// 篮球 让分胜负
    case bb_rfsf = 22

    /// 篮球 大小分
    case bb_dxf = 23

    /// 篮球 胜分差
    case bb_sfc = 24

    // --------------------------------------------------
    // 数字彩 排3,3d
    // --------------------------------------------------

    /// 排三,3d 直选 d3:3d
    case d3_zx = 101

    /// 排三,3d 组3
    case d3_zu3 = 102

    /// 排三,3d 组6
    case d3_zu6 = 103

    // --------------------------------------------------
    // 数字彩 11选5
    // --------------------------------------------------

    /// 11选5 前1 d11x5: 11选5
    case d11x5_zhi1 = 201

    /// 11选5 任2
    case d11x5_r2 = 202

    /// 11选5 任3
    case d11x5_r3 = 203

    /// 11选5 任4
    case d11x5_r4 = 204

    /// 11选5 任5
    case d11x5_r5 = 205

    /// 11选5 任6
    case d11x5_r6 = 206

    /// 11选5 任7
    case d11x5_r7 = 207

    /// 11选5 任8
    case d11x5_r8 = 208

    /// 11选5 前2组选
    case d11x5_zu2 = 211

    /// 11选5 前3组选
    case d11x5_zu3 = 212

    /// 11选5 前2直选
    case d11x5_zhi2 = 213

    /// 11选5 前3直选
    case d11x5_zhi3 = 214

    // --------------------------------------------------
    // 数字彩 新快3,幸运快3
    // --------------------------------------------------

    /// 快3 k3 和值
    case k3_hz = 301

    /// 快3 三同号通选
    case k3_3th_tx = 302

    /// 快3 三同号单选
    case k3_3th_dx = 303

    /// 快3 三不同号
    case k3_3bth = 304

    /// 快3 三连号通选
    case k3_3lh_tx = 305

    /// 快3 二同号复选
    case k3_2th_fx = 306

    /// 快3 二同号单选
    case k3_2th_dx = 307

    /// 快3 二不同号
    case k3_2bth = 308

    // --------------------------------------------------
    // 数字彩 时时彩
    // --------------------------------------------------

    /// 时时彩 一星直选 ssc:时时彩
    case ssc_zhi1 = 401

    /// 时时彩 二星直选
    case ssc_zhi2 = 402

    /// 时时彩 三星直选
    case ssc_zhi3 = 403

    /// 时时彩 五星直选
    case ssc_zhi5 = 405

    /// 时时彩 二星组选
    case ssc_zu2 = 406

    /// 时时彩 五星通选
    case ssc_tx = 407

    /// 时时彩 大小单双
    case ssc_dxds = 408

    /// 根据bet key确定类型 仅竞技彩
    init(betKey: String) {
        switch betKey {
        case "spf": self = .fb_spf
        case "rqspf": self = .fb_rqspf
        case "jqs": self = .fb_jqs
        case "bqc": self = .fb_bqc
        case "bf": self = .fb_bf
        case "sxds": self = .fb_sxds

        case "sf": self = .bb_sf
        case "rfsf": self = .bb_rfsf
        case "dxf": self = .bb_dxf
        case "sfc": self = .bb_sfc
        default: self = .none
        }
    }

    var name: String {
        switch self {
        case .none: return ""
        case .hh: return "混合投注"

        case .fb_spf: return "胜平负"
        case .fb_rqspf: return "让球胜平负"
        case .fb_jqs: return "总进球数"
        case .fb_bf: return "比分"
        case .fb_bqc: return "半全场"
        case .fb_sxds: return "上下单双"

        case .bb_sf: return "胜负"
        case .bb_rfsf: return "让分胜负"
        case .bb_dxf: return "大小分"
        case .bb_sfc: return "胜分差"

        case .d3_zx: return "直选"
        case .d3_zu3: return "组三"
        case .d3_zu6: return "组六"

        case .d11x5_r2: return "任二"
        case .d11x5_r3: return "任三"
        case .d11x5_r4: return "任四"
        case .d11x5_r5: return "任五"
        case .d11x5_r6: return "任六"
        case .d11x5_r7: return "任七"
        case .d11x5_r8: return "任八"
        case .d11x5_zhi1: return "前一" // 前一直选
        case .d11x5_zu2: return "前二组选"
        case .d11x5_zhi2: return "前二直选"
        case .d11x5_zu3: return "前三组选"
        case .d11x5_zhi3: return "前三直选"

        case .k3_hz: return "和值"
        case .k3_3th_tx: return "三同号通选"
        case .k3_3th_dx: return "三同号单选"
        case .k3_3bth: return "三不同号"
        case .k3_3lh_tx: return "三连号通选"
        case .k3_2th_fx: return "二同号复选"
        case .k3_2th_dx: return "二同号单选"
        case .k3_2bth: return "二不同号"

        case .ssc_zhi1: return "一星直选"
        case .ssc_zhi2: return "二星直选"
        case .ssc_zhi3: return "三星直选"
        case .ssc_zhi5: return "五星直选"
        case .ssc_zu2: return "二星组选"
        case .ssc_tx: return "五星通选"
        case .ssc_dxds: return "大小单双"
        }
    }

}

extension PlayType: CustomStringConvertible {
    var description: String {
        return name
    }
    
    func getPlayType(playId :Int) -> PlayType {
        
        switch playId {

        case PlayType.fb_spf.rawValue: return .fb_spf
        case PlayType.fb_rqspf.rawValue: return .fb_rqspf
        case PlayType.fb_jqs.rawValue: return .fb_jqs
        case PlayType.fb_bf.rawValue: return .fb_bf
        case PlayType.fb_bqc.rawValue: return .fb_bqc
        case PlayType.fb_sxds.rawValue: return .fb_sxds
            
        case PlayType.bb_sf.rawValue:   return .bb_sf
        case PlayType.bb_rfsf.rawValue: return .bb_rfsf
        case PlayType.bb_dxf.rawValue:  return .bb_dxf
        case PlayType.bb_sfc.rawValue:  return .bb_sfc
            
        case PlayType.d3_zx.rawValue:  return .d3_zx
        case PlayType.d3_zu3.rawValue: return .d3_zu3
        case PlayType.d3_zu6.rawValue: return .d3_zu6
            
        case PlayType.d11x5_r2.rawValue: return .d11x5_r2
        case PlayType.d11x5_r3.rawValue: return .d11x5_r3
        case PlayType.d11x5_r4.rawValue: return .d11x5_r4
        case PlayType.d11x5_r5.rawValue: return .d11x5_r5
        case PlayType.d11x5_r6.rawValue: return .d11x5_r6
        case PlayType.d11x5_r7.rawValue: return .d11x5_r7
        case PlayType.d11x5_r8.rawValue: return .d11x5_r8
            
        case PlayType.d11x5_zhi1.rawValue: return .d11x5_zhi1 // 前一直选
        case PlayType.d11x5_zu2.rawValue: return .d11x5_zu2
        case PlayType.d11x5_zhi2.rawValue: return .d11x5_zhi2
        case PlayType.d11x5_zu3.rawValue: return .d11x5_zu3
        case PlayType.d11x5_zhi3.rawValue: return .d11x5_zhi3
            
        case PlayType.k3_hz.rawValue: return .k3_hz
        case PlayType.k3_3th_tx.rawValue: return .k3_3th_tx
        case PlayType.k3_3th_dx.rawValue: return .k3_3th_dx
        case PlayType.k3_3bth.rawValue: return .k3_3bth
        case PlayType.k3_3lh_tx.rawValue: return .k3_3lh_tx
        case PlayType.k3_2th_fx.rawValue: return .k3_2th_fx
        case PlayType.k3_2th_dx.rawValue: return .k3_2th_dx
        case PlayType.k3_2bth.rawValue: return .k3_2bth
            
        case PlayType.ssc_zhi1.rawValue: return .ssc_zhi1
        case PlayType.ssc_zhi2.rawValue: return .ssc_zhi2
        case PlayType.ssc_zhi3.rawValue: return .ssc_zhi3
        case PlayType.ssc_zhi5.rawValue: return .ssc_zhi5
        case PlayType.ssc_zu2.rawValue: return .ssc_zu2
        case PlayType.ssc_tx.rawValue: return .ssc_tx
        case PlayType.ssc_dxds.rawValue: return .ssc_dxds
        case PlayType.hh.rawValue: return .hh
        default:  return .none
        }
    }
}
