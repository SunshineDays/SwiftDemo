//
//  TSPerformance.swift
//  HuaXia
//
//  Created by tianshui on 16/1/6.
// 
//

import Foundation

/// 性能测试
class TSPerformance: NSObject {
    
    private static var groups = [String: TimeInterval]()
    
    static func start(_ group: String = "default") {
        let time = CACurrentMediaTime()
        groups.updateValue(time, forKey: group)
    }
    
    static func end(_ group: String = "default") {
        if let s = groups[group] {
            let time = CACurrentMediaTime()
            log.info("\(group)相对于最后一次调用start的时间间隔---\((time - s) * 1000)ms")
            
        } else {
            log.info("\(group)没有开始的运行时间,请先使用TSPerformance.start()")
        }
    }
}
