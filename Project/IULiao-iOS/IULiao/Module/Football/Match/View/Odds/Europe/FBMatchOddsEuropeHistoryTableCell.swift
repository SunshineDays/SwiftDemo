//
//  FBMatchOddsEuropeHistoryTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 详细(历史) cell
class FBMatchOddsEuropeHistoryTableCell: UITableViewCell {

    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gapLabel: UILabel!
    
    @IBOutlet weak var drawLabelWidthConstraint: NSLayoutConstraint!
    
    func configCell(matchInfo: FBMatchModel, europe: FBOddsEuropeModel, prevEurope: FBOddsEuropeModel, isFirstOdds: Bool, needBackgroundColor: Bool) {

        configCommon(matchInfo: matchInfo, isFirstOdds: isFirstOdds, needBackgroundColor: needBackgroundColor, oddsTime: europe.time)
        drawLabelWidthConstraint.constant = 0
        
        winLabel.text = europe.win.decimal(2)
        drawLabel.text = europe.draw.decimal(2)
        lostLabel.text = europe.lost.decimal(2)
        
        winLabel.textColor = TSOddsHelper.trendColor(prevValue: prevEurope.win, currentValue: europe.win)
        drawLabel.textColor = TSOddsHelper.trendColor(prevValue: prevEurope.draw, currentValue: europe.draw)
        lostLabel.textColor = TSOddsHelper.trendColor(prevValue: prevEurope.lost, currentValue: europe.lost)
    
    }

    func configCell(matchInfo: FBMatchModel, asia: FBOddsAsiaModel, prevAsia: FBOddsAsiaModel, isFirstOdds: Bool, needBackgroundColor: Bool) {

        configCommon(matchInfo: matchInfo, isFirstOdds: isFirstOdds, needBackgroundColor: needBackgroundColor, oddsTime: asia.time)
        drawLabelWidthConstraint.constant = 20

        winLabel.text = asia.above.decimal(2)
        drawLabel.text = asia.handicap
        lostLabel.text = asia.below.decimal(2)

        let trend = FBOddsAsiaSetModel.handicapTrend(initBet: prevAsia.bet, lastBet: asia.bet)
        winLabel.textColor = TSOddsHelper.trendColor(prevValue: prevAsia.above, currentValue: asia.above)
        drawLabel.textColor = TSOddsHelper.trendColor(trend: Double(trend))
        lostLabel.textColor = TSOddsHelper.trendColor(prevValue: prevAsia.below, currentValue: asia.below)

    }
    
    func configCell(matchInfo: FBMatchModel, bigSmall: FBOddsBigSmallModel, prevBigSmall: FBOddsBigSmallModel, isFirstOdds: Bool, needBackgroundColor: Bool) {
        
        configCommon(matchInfo: matchInfo, isFirstOdds: isFirstOdds, needBackgroundColor: needBackgroundColor, oddsTime: bigSmall.time)
        drawLabelWidthConstraint.constant = 20
        
        winLabel.text = bigSmall.big.decimal(2)
        drawLabel.text = bigSmall.handicap
        lostLabel.text = bigSmall.small.decimal(2)
        
        winLabel.textColor = TSOddsHelper.trendColor(prevValue: prevBigSmall.big, currentValue: bigSmall.big)
        drawLabel.textColor = TSOddsHelper.trendColor(prevValue: Double(prevBigSmall.bet), currentValue: Double(bigSmall.bet))
        lostLabel.textColor = TSOddsHelper.trendColor(prevValue: prevBigSmall.small, currentValue: bigSmall.small)
        
    }

    private func configCommon(matchInfo: FBMatchModel, isFirstOdds: Bool, needBackgroundColor: Bool, oddsTime: TimeInterval) {
        contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white

        timeLabel.text = TSUtils.timestampToString(oddsTime, withFormat: "MM-dd HH:mm", isIntelligent: false)

        if isFirstOdds {
            gapLabel.text = "初赔"
        } else {
            let diff = matchInfo.matchTime - oddsTime
            var time = ""
            if diff <= 0 {
                time = "0 分钟"
            } else if diff < 60 * 60 {
                time = String(format: "%2d分钟", Int(diff / 60))
            } else {
                time = String(format: "%2d小时 %02d分钟", Int(diff / 60 / 60), Int(diff.truncatingRemainder(dividingBy: 60 * 60) / 60))
            }
            gapLabel.text = time
        }
    }

}
