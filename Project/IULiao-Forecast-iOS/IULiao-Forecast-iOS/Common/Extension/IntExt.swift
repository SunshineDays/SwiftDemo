//
//  IntExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/6.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

extension Int {
    /// 数字转字符串
    var string: String {
        return "\(self)"
    }
    
    /// 金额（每三位用，隔开）
    var moneyText: String {
        var result = ""
        let moneyStr = self.string.reversed()
        for (index, m) in moneyStr.enumerated() {
            result = result + String(m)
            if (index + 1) % 3 == 0 && index + 1 != moneyStr.count {
                result = result + ","
            }
        }
        result = String(result.reversed())
        return result
    }
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}

