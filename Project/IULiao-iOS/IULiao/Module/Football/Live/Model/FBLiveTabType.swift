//
//  FBLiveTabType.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

// 比分标签
enum FBLiveTabType: String {
//    case all = "全部"
//    case over = "完场"
//    case notStarted = "未开始"
//    case playing = "进行中"
//    case attention = "关注"
//
//    var liveStateTypes: [FBLiveStateType] {
//        var result = [FBLiveStateType]()
//        switch self {
//        case .over:
//            result = [.over]
//        case .notStarted:
//            result = [.notStarted]
//        case .playing:
//            result = [.uptHalf, .downHalf, .halfTime]
//        case .all: fallthrough
//        case .attention:
//            result = [.notStarted, .uptHalf, .halfTime, .downHalf, .over, .cancel, .delaye, .pause]
//
//        }
//        return result
//    }
    
    case all = "即时比分"
    case over = "已完赛"
    case attention = "我的关注"
    
    var liveStateTypes: [FBLiveStateType] {
        var result = [FBLiveStateType]()
        switch self {
        case .all:
            fallthrough
        case .over:
            result = [.over]
        case .attention:
            result = [.notStarted, .uptHalf, .halfTime, .downHalf, .over, .cancel, .delaye, .pause]
        }
        return result
    }
    
    static let allTabs: [FBLiveTabType] = [.all, .over, .attention]
}


enum FBLive2TabType: String {
    case all = "即时比分"
    case over = "已完赛"
    case attention = "我的关注"
    
    var liveStatTypes: [FBLiveStateType] {
        var result = [FBLiveStateType]()
        switch self {
        case .all:
            fallthrough
        case .over:
            result = [.over]
        case .attention:
            result = [.notStarted, .uptHalf, .halfTime, .downHalf, .over, .cancel, .delaye, .pause]
        }
        return result
    }
    static let allTabs: [FBLive2TabType] = [.all, .over, .attention]
}
