//
//  TSOddsHelper.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赔率相关帮助类
class TSOddsHelper: NSObject {

    
    /// 趋势颜色
    ///
    /// - Parameter trend: 趋势 >0 <0 =0
    /// - Returns:
    static func trendColor(trend: Double) -> UIColor {
        if trend > 0 {
            return TSColor.matchResult.win
        } else if trend < 0 {
            return TSColor.matchResult.draw
        }
        return TSColor.gray.gamut333333
    }


    /// 趋势颜色
    ///
    /// - Parameters:
    ///   - prevValue: 上一个值
    ///   - currentValue: 当前值
    /// - Returns:
    static func trendColor(prevValue: Double, currentValue: Double) -> UIColor {
        return TSOddsHelper.trendColor(trend: currentValue - prevValue)
    }
}
