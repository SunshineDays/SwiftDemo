//
//  LOG.swift
//  Uther
//
//  Created by why on 7/30/15.
//  Copyright (c) 2015 callmewhy. All rights reserved.
//

import UIKit
import XCGLogger

/// 日志
let log: XCGLogger = {
    let log = XCGLogger.default
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    let cacheDirectory = urls.last!
    let logPath = cacheDirectory.appendingPathComponent("XCGLogger.Log")

#if DEBUG
    log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath, fileLevel: .info)
#else
    log.setup(level: .severe, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
#endif
    
    return log
}()

