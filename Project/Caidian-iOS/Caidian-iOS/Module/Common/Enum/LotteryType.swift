//
//  LotteryType.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/9.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import UIKit

/// 彩种类型
enum LotteryType: Int {

    /// 未知
    case none = 0
    // --------------------------------------------------
    // 竞技彩
    // --------------------------------------------------

    /// 足彩 胜负彩
    case zcsfc = 11

    /// 足彩 半全场
    case zcbqc = 16

    /// 足彩 进球彩
    case zcjqc = 18

    /// 足彩 任九
    case zcr9 = 19

    /// 竞彩足球
    case jczq = 42

    /// 北单
    case bd = 41

    /// 竞彩篮球
    case jclq = 43

    // --------------------------------------------------
    // 数字彩
    // --------------------------------------------------

    /// 大乐透
    case dlt = 102

    /// 双色球
    case ssq = 101

    /// 七星彩
    case qxc = 103

    /// 七乐彩
    case qlc = 104

    /// 3d
    case d3 = 105

    /// 排列3
    case pl3 = 106

    /// 排列5
    case pl5 = 107

    // --------------------------------------------------
    // 快频彩
    // --------------------------------------------------

    /// 山东11选5 11运夺金
    case d11x5ShanDong = 201

    /// 广东11选5
    case d11x5GuangDong = 202

    /// 新11选5
    case d11x5 = 203

    /// 新快三
    case k3 = 211

    /// 幸运快三
    case k3XinYun = 212

    /// 时时彩
    case ssc = 221

    var name: String {
        switch self {
        case .zcsfc: return "胜负彩"
        case .zcbqc: return "半全场"
        case .zcjqc: return "进球彩"
        case .zcr9: return "任九"
        case .jczq: return "竞彩足球"
        case .bd: return "北京单场"
        case .jclq: return "竞彩篮球"

        case .dlt: return "大乐透"
        case .ssq: return "双色球"
        case .qxc: return "七星彩"
        case .qlc: return "七乐彩"
        case .d3: return "福彩3d"
        case .pl3: return "排列3"
        case .pl5: return "排列5"

        case .d11x5ShanDong: return "11运夺金"
        case .d11x5GuangDong: return "广东11选5"
        case .d11x5: return "新11选5"
        case .k3: return "新快三"
        case .k3XinYun: return "幸运快三"
        case .ssc: return "时时彩"

        case .none: return "未知"
        }
    }
    
    /// 彩种logo
    var logo: UIImage {
        switch self {
        case .jczq: return R.image.lottery.jczq()!
        case .jclq: return R.image.lottery.jclq()!
        case .zcsfc: return R.image.lottery.jczq()!
        case .zcbqc: return R.image.lottery.bqc()!
        case .zcjqc: return R.image.lottery.jqc()!
        case .zcr9: return R.image.lottery.rx9()!
        case .bd: return R.image.lottery.bjdc()!
            
        case .dlt: return R.image.lottery.dlt()!
        case .ssq: return R.image.lottery.ssq()!
        case .qxc: return R.image.lottery.ssq()!
        case .qlc: return R.image.lottery.ssq()!
        case .d3: return R.image.lottery.fc3d()!
        case .pl3: return R.image.lottery.fc3d()!
        case .pl5: return R.image.lottery.fc3d()!
            
        case .d11x5ShanDong: return R.image.lottery.fc3d()!
        case .d11x5GuangDong: return R.image.lottery.fc3d()!
        case .d11x5: return R.image.lottery.fc3d()!
        case .k3: return R.image.lottery.fc3d()!
        case .k3XinYun: return R.image.lottery.fc3d()!
        case .ssc: return R.image.lottery.fc3d()!
            
        case .none: return R.image.lottery.other()!
        }
    }
    
    

    /// 竞技彩 最大串关
    func maxSerial(play: PlayType) -> Int {
        switch self {
        case .jczq:
            switch play {
            case .fb_spf: return 8
            case .fb_rqspf: return 8
            case .fb_jqs: return 6
            case .fb_bf: return 4
            case .fb_bqc: return 4
            default: return 0
            }
        case .jclq:
            switch play {
            case .bb_sf: return 8
            case .bb_rfsf: return 8
            case .bb_dxf: return 4
            case .bb_sfc: return 4
            default: return 0
            }
        case .bd:
            switch play {
            case .fb_spf: return 15
            case .fb_jqs: return 6
            case .fb_bf: return 3
            case .fb_bqc: return 6
            case .fb_sxds: return 6
            default: return 0
            }
        default:
            return 0
        }
    }

//    func allowBallKey(play: PlayType) -> [NLBallKey] {
//        switch self {
//            case .dlt:
//        }
//    }
}

extension LotteryType: CustomStringConvertible {
    var description: String {
        return name
    }
    
    
}
