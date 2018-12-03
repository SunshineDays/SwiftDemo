//
//  Utils.swift
//  HuaXia
//
//  Created by tianshui on 15/11/2.
// 
//

import Foundation

/// 工具 静态方法
final class Utils {
    
    /**
     生成一个随机字符串(a-zA-Z0-9)
     - parameter length: 字符串长度
     - returns: 随机字符串
     */
    static func randomString(_ length: Int = 32) -> String {
        
        func generate(start: UnicodeScalar, end: UnicodeScalar) -> [String] {
            var chars: [String] = []
            for ascii in start.value...end.value {
                let char = Character(UnicodeScalar(ascii)!)
                chars.append("\(char)")
            }
            return chars
        }
        
        var chars: [String] = []
        chars += generate(start: "a", end: "z")
        chars += generate(start: "A", end: "Z")
        chars += generate(start: "0", end: "9")
        
        var output = ""
        for _ in 0..<length {
            let randomNum = Int(arc4random() % UInt32(chars.count))
            output += chars[randomNum]
        }
        
        return output
    }
}
