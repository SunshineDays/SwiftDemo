//
//  OrderJczqTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/6.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 订单 竞彩足球 table cell
class OrderJczqTableCell: UITableViewCell {

    @IBOutlet weak var xidLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var mustBetImageView: UIImageView!
    
    static let defaultHeight: CGFloat = 50
    static let defaultBetLineHeight: CGFloat = 16
    
    func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType], isMustBet: Bool, letBall: Int) {
        xidLabel.text = "\(match.serial.prefix(2))\n\(match.serial.suffix(3))"
        mustBetImageView.isHidden = !isMustBet
        
        configTeamName(match: match, letBall: letBall)
        configScore(match: match)
        configBet(match: match, betKeyList: betKeyList, letBall: letBall)
    }
    
    private func configBet(match: JczqMatchModel, betKeyList: [JczqBetKeyType], letBall: Int) {
        var isHitList = [Bool]()
        if let homeHalfScore = match.homeHalfScore,
            let awayHalfScore = match.awayHalfScore,
            let homeScore = match.homeScore,
            let awayScore = match.awayScore {
        
            isHitList = betKeyList.map {
                bet in
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
        
        betLabel.attributedText = mutableAttr
    }
    
    private func configTeamName(match: SLMatchModelProtocol, letBall: Int) {
        let str = match.letBall > 0 ? "(+\(letBall))" : "(\(letBall))"
        let attr = NSMutableAttributedString()
        attr.append(NSAttributedString(string: "\(match.home)"))
        attr.append(NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor: letBall > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0]))
        homeLabel.attributedText = attr
        
        awayLabel.text = match.away
    }
    
    private func configScore(match: SLMatchModelProtocol) {
        
        let attr = NSMutableAttributedString()
        switch match.saleStatus {
        case .cancel: fallthrough
        case .delay: attr.append(NSAttributedString(string: match.saleStatus.name))
        default:
            if match.homeScore == nil && match.halfScore == nil {
                attr.append(NSAttributedString(string: "未开赛"))
            } else {
                if let homeHalfScore = match.homeHalfScore, let awayHalfScore = match.awayHalfScore {
                    attr.append(NSAttributedString(string: "半", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                    attr.append(NSAttributedString(string: "\(homeHalfScore):\(awayHalfScore)", attributes: [.foregroundColor: UIColor.grayGamut.gamut333333]))
                } else {
                    attr.append(NSAttributedString(string: "---", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                }
                
                if let homeScore = match.homeScore, let awayScore = match.awayScore {
                    attr.append(NSAttributedString(string: "\n全", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                    attr.append(NSAttributedString(string: "\(homeScore):\(awayScore)", attributes: [.foregroundColor: UIColor.grayGamut.gamut333333]))
                } else {
                    attr.append(NSAttributedString(string: "\n---", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                }
            }
        }
        scoreLabel.attributedText = attr
        
    }
}
