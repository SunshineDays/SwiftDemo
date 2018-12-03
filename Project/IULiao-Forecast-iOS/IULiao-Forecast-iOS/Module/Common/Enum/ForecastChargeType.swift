//
//  ForecastChargeType.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测的帖子收费类型
enum ForecastChargeType: Int {
    /// 免费
    case free = 0
    /// 不中包退
    case lostWithDraw = 1
    /// 不中不退
    case lostOver = 2
}
