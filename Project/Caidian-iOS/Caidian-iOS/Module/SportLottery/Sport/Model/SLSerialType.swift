//
//  SLSerialType.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 串关类型
enum SLSerialType: String {
    
    case m1n1 = "1串1"
    case m2n1 = "2串1"
    case m3n1 = "3串1"
    case m4n1 = "4串1"
    case m5n1 = "5串1"
    case m6n1 = "6串1"
    case m7n1 = "7串1"
    case m8n1 = "8串1"
    case m9n1 = "9串1"
    case m10n1 = "10串1"
    case m11n1 = "11串1"
    case m12n1 = "12串1"
    case m13n1 = "13串1"
    case m14n1 = "14串1"
    case m15n1 = "15串1"
    
    init?(string: String) {
        if string == "单关" {
            self = .m1n1
        } else {
            self.init(rawValue: string)
        }
    }
    
    /// m串1
    init?(m: Int) {
        self.init(string: "\(m)串1")
    }
    
    /// 显示名
    var displayName: String {
        switch self {
        case .m1n1:
            return "单关"
        default:
            return rawValue
        }
    }
    
    /// m串n 中的m
    var m: Int {
        return Int(String(rawValue.split(separator: "串")[safe: 0] ?? "0")) ?? 0
    }
    
    /// m串n 中的n
    var n: Int {
        return Int(String(rawValue.split(separator: "串")[safe: 0] ?? "0")) ?? 0
    }
    
    /// 生成可能的串关方式 m串1
    static func generalProbableSerialList(m: Int, minSerial: Int = 1) -> [SLSerialType] {
        if m < minSerial {
            return []
        }
        var result = [SLSerialType]()
        for i in minSerial...m {
            if let serial = SLSerialType.init(m: i) {
                result.append(serial)
            }
        }
        return result
    }
}
