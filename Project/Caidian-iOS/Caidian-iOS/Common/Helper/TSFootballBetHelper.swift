//
//  TSFootballBetHelper.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/16.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class TSFootballBetHelper: NSObject {
    
    /// 足球投注
    ///
    /// - Parameters:
    ///   - match: 赛事模型
    ///   - betKeyList: 投注内容数组
    ///   - letBall: 让球数
    /// - Returns: 投注内容的字符串（NSMutableAttributedString）
    class func betAttributedString(match: JczqMatchModel, betKeyList: [JczqBetKeyType], letBall: Int) -> NSMutableAttributedString {
        var isHitList = [Bool]()
        if let homeHalfScore = match.homeHalfScore,
            let awayHalfScore = match.awayHalfScore,
            let homeScore = match.homeScore,
            let awayScore = match.awayScore {
            isHitList = betKeyList.map { bet in
                let isHit = bet.isHit(letBall: letBall, homeScore: homeScore, awayScore: awayScore, homeHalfScore: homeHalfScore, awayHalfScore: awayHalfScore)
                return isHit
            }
        }
        let mutableAttr = NSMutableAttributedString()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 0
        paragraph.alignment = .center
        paragraph.maximumLineHeight = OrderJczqTableCell.defaultBetLineHeight
        paragraph.minimumLineHeight = OrderJczqTableCell.defaultBetLineHeight - 1
        
        for (index, bet) in betKeyList.enumerated() {
            let isHit = isHitList[safe: index] ?? false
            let color = isHit ? UIColor.logo : UIColor.grayGamut.gamut333333
            let attr = NSAttributedString(string: "\(index > 0 ? "\n" : "")\(bet.name)(\(bet.sp.decimal(2)))", attributes: [
                .foregroundColor: color,
                .paragraphStyle: paragraph
                ])
            mutableAttr.append(attr)
        }
        return mutableAttr
    }
    
}
