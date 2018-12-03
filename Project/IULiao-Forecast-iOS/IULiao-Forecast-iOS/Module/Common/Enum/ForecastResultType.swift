//
//  ForecastResultType.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测帖子中奖结果
enum ForecastResultType: Int {
    /// 未开奖
    case notOpen = 0
    /// 命中
    case win = 1
    /// 未中
    case lost = -1

    
    var name: String {
        switch self {
        case .notOpen: return "未开奖"
        case .win: return "命中"
        case .lost: return "未中"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .notOpen: return nil
        case .win: return R.image.forecast.result_true()
        case .lost: return R.image.forecast.result_false()
        }
    }
}
