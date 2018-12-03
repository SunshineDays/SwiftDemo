//
//  CommonExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/23.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

extension Int {
    /// 让球数字符串
    var letBallString: String {
        return self > 0 ? ("+" + self.string) : self.string
    }
}

extension String {
    /// 获取比分
    var score: (home: Int, away: Int) {
        if isEmpty {
            return (0, 0)
        }
        var index = 0
        for (i, s) in enumerated() {
            if s == ":" {
                index = i
                break
            }
        }
        let homeScore = substring(to: index)
        let awayScore = substring(from: index + 1)
        return ((Int(homeScore) ?? 0), (Int(awayScore) ?? 0))
    }
}
