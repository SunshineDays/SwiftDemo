//
//  Func.swift
//  
// 
//  业务无关的 函数
//
//  Created by tianshui on 15/5/14.
// 
//

import Foundation

/// 延时毫秒后执行
func dispatch_after_time(_ millisecond: Int, block: @escaping () -> ()) {
    let time = DispatchTime.now() + Double(Int64(UInt64(millisecond) * NSEC_PER_MSEC)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
}

/// 多线程加锁 类似于objc中的 @synchronized(anObj) {}
func synchronized(_ lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

/// 随机数 包含min和max
func random(min: Int = 0, max: Int) -> Int {
    return Int(arc4random()) % (max - min + 1) + min
}

