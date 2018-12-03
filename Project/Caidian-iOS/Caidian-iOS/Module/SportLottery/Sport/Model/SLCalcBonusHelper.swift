//
//  SLCalcBonusHelper.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import JavaScriptCore

/// 竞技彩 计算奖金
class SLCalcBonusHelper {

    struct Result {
        var minBonus: Double = 0
        var maxBonus: Double = 0
        var betCount: Int = 0
    }

    static let shared = SLCalcBonusHelper()

    private init() {}

    private lazy var context: JSContext = {
        let ctx = JSContext()!
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "jcbonus", ofType: ".js", inDirectory: kTSResourceBundleName)!)
        let js = try! String(contentsOf: url)
        ctx.evaluateScript(js)
        return ctx
    }()
    
    /// 竞彩足球
    /// "spf-3@++1#1.39,spf-1@++1#4.20,spf-0@++1#5.80|nspf-3#2.33,nspf-1#3.30,nspf-0#2.52|jqs-3#3.70|bf-30#23.00,bf-33#60.00,bf-03#24.00|bqc-13#5.50"
    /// "spf-3@-1#4.40,spf-1@-1#3.95,spf-0@-1#1.54|nspf-3#2.15,nspf-1#3.40,nspf-0#2.70|jqs-4#4.90|bf-31#15.00,bf-13#22.00|bqc-11#5.60"
    /// "nspf-3#2.30,nspf-1#3.25,nspf-0#2.60|jqs-4#5.40|bf-31#18.00,bf-32#23.00,bf-1A#300.0,bf-13#22.00,bf-23#25.00|bqc-11#5.00"
    /// "spf-3@++1#1.39,spf-1@++1#4.20,spf-0@++1#5.80|nspf-3#2.33,nspf-1#3.30,nspf-0#2.52|jqs-3#3.70|bf-30#23.00,bf-33#60.00,bf-03#24.00|bqc-13#5.50"
    /// var opts = [
    ///     "spf-3@-1#3.95",
    ///     "nspf-1#3.30|spf-1@-1#3.55",
    ///     "nspf-3#1.57,nspf-0#4.80|spf-1@-1#3.35",
    ///     "nspf-3#2.20|spf-1@-1#3.95"
    /// ];
    /// var ggType = ["2串1", "3串1", "4串1"];
    /// var mutil = 1;
    /// var result = calc_jczq(opts, ggType, mutil);
    /// {min: minBouns, max: maxBouns, codeCount: codeCount};
    func jczq(buyModel: SLBuyModel<JczqMatchModel, JczqBetKeyType>) -> Result {
        var opts = [String]()
        let serialList = buyModel.selectedSerialList.map {
            $0.rawValue
        }
        let multiple = buyModel.multiple

        for combination in buyModel.matchList {
            var dict = [String: [String]]()
            let mustBet = combination.isMustBet ? "D" : ""
            let letBall = combination.match.letBall > 0 ? "+\(combination.match.letBall)" : "\(combination.match.letBall)"

            for betKey in combination.betKeyList {
                let sp = betKey.sp
                let arr = betKey.key.split(separator: "_")
                var k = arr[1].replacingOccurrences(of: "sp", with: "") // 3,1,0,33,
                var w = ""
                var str = ""

                switch betKey.playType {
                case .fb_spf:
                    w = "nspf"
                    str = "\(w)-\(k)#\(sp)"
                case .fb_rqspf:
                    w = "spf"
                    str = "\(w)-\(k)@\(letBall)#\(sp)"
                case .fb_bf:
                    w = "bf"
                    if betKey == .bf_spA3(sp: 0) {
                        k = "3A"
                    }
                    if betKey == .bf_spA1(sp: 0) {
                        k = "1A"
                    }
                    if betKey == .bf_spA0(sp: 0) {
                        k = "0A"
                    }
                    str = "\(w)-\(k)#\(sp)"
                case .fb_jqs:
                    w = "jqs"
                    str = "\(w)-\(k)#\(sp)"
                case .fb_bqc:
                    w = "bqc"
                    str = "\(w)-\(k)#\(sp)"
                default:
                    continue
                }
                if dict[w] == nil {
                    dict[w] = [String]()
                }
                dict[w]?.append(str)
            }
            opts.append(dict.mapValues { $0.joined(separator: ",") }.values.joined(separator: "|") + mustBet)
        }
        return calc(jsFuncName: "calc_jczq", opts: opts, serialList: serialList, multiple: multiple)
    }
    
    /// 竞彩篮球
    /// var opts = [
    ///    "sf-1#4.35,sf-2#1.09",
    ///    "sf-1#1.54,sf-2#2|rfsf-1@3.5#1.75",
    ///    "dxf-1#1.69",
    ///    "rfsf-1@-5.5#1.81",
    ///    "sfc-05#20,sfc-06#23,sfc-14#16"
    /// ];
    /// var ggType = ["2串1", "3串1"];
    /// var mutil = 1;
    /// var result = calc_jclq(opts, ggType, mutil);
    /// {min: minBouns, max: maxBouns, codeCount: codeCount};
    func jzlq(buyModel: SLBuyModel<JclqMatchModel, JclqBetKeyType>) -> Result {
        var opts = [String]()
        let serialList = buyModel.selectedSerialList.map {
            $0.rawValue
        }
        let multiple = buyModel.multiple
        for combination in buyModel.matchList {
            var dict = [String: [String]]()
            let mustBet = combination.isMustBet ? "D" : ""
            let letBall = combination.match.letBall > 0 ? "+\(combination.match.letBall)" : "\(combination.match.letBall)"
            
            for betKey in combination.betKeyList {
                let sp = betKey.sp
                let arr = betKey.key.split(separator: "_")
                var k = arr[1].replacingOccurrences(of: "sp", with: "") // 3,0,
                var w = ""
                var str = ""
                
                switch betKey.playType {
                case .bb_sf:
                    w = "sf"
                    if k == "3" {
                        k = "1"
                    } else if k == "0" {
                        k = "2"
                    }
                    str = "\(w)-\(k)#\(sp)"
                case .bb_rfsf:
                    w = "rfsf"
                    if k == "3" {
                        k = "1"
                    } else if k == "0" {
                        k = "2"
                    }
                    str = "\(w)-\(k)@\(letBall)#\(sp)"
                case .bb_dxf:
                    w = "dxf"
                    if k == "3" {
                        k = "1"
                    } else if k == "0" {
                        k = "2"
                    }
                    str = "\(w)-\(k)#\(sp)"
                case .bb_sfc:
                    w = "sfc"
                    str = "\(w)-\(k)#\(sp)"
                default:
                    continue
                }
                if dict[w] == nil {
                    dict[w] = [String]()
                }
                dict[w]?.append(str)
            }
            opts.append(dict.mapValues { $0.joined(separator: ",") }.values.joined(separator: "|") + mustBet)
        }
        return calc(jsFuncName: "calc_jclq", opts: opts, serialList: serialList, multiple: multiple)
    }

    
    /// 通过js计算奖金
    ///
    /// - Parameters:
    ///   - jsFuncName: js方法名
    ///   - opts: 投注项信息
    ///   - serialList: 串关
    ///   - multiple: 倍数
    /// - Returns:
    private func calc(jsFuncName: String, opts: [String], serialList: [String], multiple: Int) -> Result {
        print(jsFuncName, opts, serialList, multiple)
        let calc = context.objectForKeyedSubscript(jsFuncName)
        guard let result = calc?.call(withArguments: [opts, serialList, multiple]).toDictionary() else {
            return Result()
        }
        var minBonus: Double = 0
        var maxBonus: Double = 0
        var betCount: Int = 0

        if let min = result["min"] as? Double {
            minBonus = min
        }
        if let max = result["max"] as? Double {
            maxBonus = max
        }
        if let count = result["codeCount"] as? Int {
            betCount = count
        }
        return Result(minBonus: minBonus, maxBonus: maxBonus, betCount: betCount)
    }
    
    
}
