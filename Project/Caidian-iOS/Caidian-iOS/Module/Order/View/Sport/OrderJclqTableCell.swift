//
//  OrderJclqTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/6.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 订单 竞彩足球 table cell
class OrderJclqTableCell: UITableViewCell {

    @IBOutlet weak var xidLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var mustBetImageView: UIImageView!
    
    static let defaultHeight: CGFloat = 50
    static let defaultBetLineHeight: CGFloat = 16
    
    func configCell(match: JclqMatchModel, betKeyList: [JclqBetKeyType], isMustBet: Bool, letScore: Double, dxfNum: Double) {
        xidLabel.text = "\(match.serial.prefix(2))\n\(match.serial.suffix(3))"
        mustBetImageView.isHidden = !isMustBet
        
        configTeamName(match: match, letScore: letScore)
        configScore(match: match, dxfNum: dxfNum)
        configBet(match: match, betKeyList: betKeyList, letScore: letScore, dxfNum: dxfNum)
    }
    
    private func configBet(match: JclqMatchModel, betKeyList: [JclqBetKeyType], letScore: Double, dxfNum: Double) {
        var isHitList = [Bool]()
        if let homeScore = match.homeScore, let awayScore = match.awayScore {
            isHitList = betKeyList.map {
                bet in
                let isHit = bet.isHit(letScore: letScore, dxfNum: dxfNum, homeScore: homeScore, awayScore: awayScore)
                return isHit
            }
        }
        let mutableAttr = NSMutableAttributedString()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 0
        paragraph.alignment = .center
        paragraph.maximumLineHeight = OrderJclqTableCell.defaultBetLineHeight
        paragraph.minimumLineHeight = OrderJclqTableCell.defaultBetLineHeight - 1
        
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
    
    private func configTeamName(match: SLMatchModelProtocol, letScore: Double) {
        let str = match.letBall > 0 ? "(+\(letScore))" : "(\(letScore))"
        let attr = NSMutableAttributedString()
        attr.append(NSAttributedString(string: "\(match.home)"))
        attr.append(NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor: letScore > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0]))
        homeLabel.attributedText = attr
        
        awayLabel.text = match.away
    }
    
    private func configScore(match: SLMatchModelProtocol, dxfNum: Double) {
        
        let attr = NSMutableAttributedString()
        switch match.saleStatus {
        case .cancel: fallthrough
        case .delay: attr.append(NSAttributedString(string: match.saleStatus.name))
        default:
            if match.homeScore == nil {
                attr.append(NSAttributedString(string: "未开赛"))
            } else {
                if let homeScore = match.homeScore, let awayScore = match.awayScore {
                    attr.append(NSAttributedString(string: "全", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                    attr.append(NSAttributedString(string: "\(awayScore):\(homeScore)", attributes: [.foregroundColor: UIColor.grayGamut.gamut333333]))
                } else {
                    attr.append(NSAttributedString(string: "---", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
                }
            }
//            attr.append(NSAttributedString(string: "大小分", attributes: [.foregroundColor: UIColor.grayGamut.gamut666666]))
            attr.append(NSAttributedString(string: "\n\(dxfNum.decimal(1))", attributes: [.foregroundColor: UIColor.grayGamut.gamut333333]))
        }
        scoreLabel.attributedText = attr
        
    }
}
