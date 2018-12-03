//
//  SLBetKeyProtocol.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 投注项
protocol SLBetKeyProtocol { // }: Equatable {
    
    /// 显示名
    var name: String { get }
    
    /// 投注key 唯一
    var key: String { get }
    
    /// sp赔率值
    var sp: Double { get }
    
    /// 所属玩法
    var playType: PlayType { get }
}

extension SLBetKeyProtocol {

    var playType: PlayType {
        let str = String(key.split(separator: "_")[0])
        return PlayType(betKey: str)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.key == rhs.key
    }
}
