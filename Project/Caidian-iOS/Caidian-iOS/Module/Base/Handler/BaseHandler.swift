//
//  BaseHandler.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import Foundation

/// handler基类
class BaseHandler: NSObject {

    typealias FailedBlock = ((NSError) -> Void)
    
    // 默认的请求管理
    lazy var defaultRequestManager = TSRequestManager()
    
    deinit {
        log.info("deinit ---------- " + description)
    }
    
    /// Cancels the request.
    func cancel() {
        defaultRequestManager.requestHandler?.cancel()
    }
}
