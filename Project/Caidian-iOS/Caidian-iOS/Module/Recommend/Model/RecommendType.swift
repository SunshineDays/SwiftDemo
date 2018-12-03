//
//  RecommendType.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐命中状态
enum RecommendWinStatusType: Int {
    case notOpen = 0
    
    case win = 1
    
    case lost = -1
    
    var name: String {
        switch self {
        case .notOpen: return "未开奖"
        case .win: return "命中"
        case .lost: return "未命中"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .notOpen: return nil
        case .win: return R.image.recommend_result_win()
        case .lost: return R.image.recommend_result_lost()
        }
    }
    
    var recommendImage: UIImage? {
        switch self {
        case .notOpen: return nil
        case .win: return R.image.recommend_win()
        case .lost: return R.image.recommend_lost()
        }
    }
}

