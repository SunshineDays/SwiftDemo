//
//  TSDBHelper.swift
//  HuaXia
//
//  Created by tianshui on 16/1/14.
// 
//

/*
import Foundation
import SQLite

class TSDBHelper: NSObject {
    
    static let dbURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last()!.URLByAppendingPathComponent("db.sqlite3")
    
    private static var connection: Connection?
    
    static var db: Connection {
        if TSDBHelper.connection == nil {
            do {
                TSDBHelper.connection = try Connection(TSDBHelper.dbURL.absoluteString)
            } catch {
                print("数据库连接失败")
            }
        }
        return TSDBHelper.connection!
    }
    
    static func setupDatabases() {
    }
    
    private override init() {
        super.init()
    }
}
*/