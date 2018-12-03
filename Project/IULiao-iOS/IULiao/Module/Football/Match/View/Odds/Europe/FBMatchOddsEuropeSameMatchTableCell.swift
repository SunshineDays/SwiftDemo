//
//  FBMatchOddsEuropeSameMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 相同赔率赛事cell
class FBMatchOddsEuropeSameMatchTableCell: UITableViewCell {
    
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var winFirstLabel: UILabel!
    @IBOutlet weak var winSecondLabel: UILabel!
    @IBOutlet weak var drawFirstLabel: UILabel!
    @IBOutlet weak var drawSecondLabel: UILabel!
    @IBOutlet weak var lostFirstLabel: UILabel!
    @IBOutlet weak var lostSecondLabel: UILabel!
    
    @IBOutlet weak var timeLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreLableWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lostFirstLableRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lostFirstLableWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var drawFirstLableWidthConstraint: NSLayoutConstraint!
    
    private var oddsType = OddsType.europe {
        didSet {
            configConstraint()
        }
    }
    private var needBackgroundColor = false

    override func awakeFromNib() {
        super.awakeFromNib()
        configConstraint()
    }
    
    private func configConstraint() {
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            timeLabelWidthConstraint.constant = 70
            timeLabelLeftConstraint.constant = 2
            timeLabelRightConstraint.constant = 2
            scoreLableWidthConstraint.constant = 32
            lostFirstLableRightConstraint.constant = 2
        } else if TSScreen.currentWidth > TSScreen.iPhone6Width {
            lostFirstLableWidthConstraint.constant = 38
        }
        if oddsType == .asia {
            drawFirstLableWidthConstraint.constant = 20
        }
    }
    
    func configCell(match: FBMatchModel, europe: FBOddsEuropeSetModel, needBackgroundColor: Bool) {
        
        oddsType = .europe
        configCommon(match: match, needBackgroundColor: needBackgroundColor)
        
        let initOdds = europe.initOdds
        let lastOdds = europe.lastOdds
        
        if let homeScore = match.homeScore, let awayScore = match.awayScore {
            let result = FBMatchResultEuropeType(homeScore: homeScore, awayScore: awayScore)
            scoreLabel.text = "\(homeScore)-\(awayScore)"
            resultLabel.text = result.description
            resultLabel.textColor = result.color
            
        } else {
            scoreLabel.text = "VS"
            resultLabel.text = "-"
            resultLabel.textColor = TSColor.gray.gamut333333
        }
        
        winFirstLabel.text = initOdds.win.decimal(2)
        drawFirstLabel.text = initOdds.draw.decimal(2)
        lostFirstLabel.text = initOdds.lost.decimal(2)
        
        winSecondLabel.text = lastOdds.win.decimal(2)
        winSecondLabel.textColor = TSOddsHelper.trendColor(trend: europe.winTrend)
        drawSecondLabel.text = lastOdds.draw.decimal(2)
        drawSecondLabel.textColor = TSOddsHelper.trendColor(trend: europe.drawTrend)
        lostSecondLabel.text = lastOdds.lost.decimal(2)
        lostSecondLabel.textColor = TSOddsHelper.trendColor(trend: europe.lostTrend)
        
    }
    
    func configCell(match: FBMatchModel, asia: FBOddsAsiaSetModel, needBackgroundColor: Bool) {
        
        oddsType = .asia
        configCommon(match: match, needBackgroundColor: needBackgroundColor)
        
        let initOdds = asia.initOdds
        let lastOdds = asia.lastOdds
        
        if let homeScore = match.homeScore, let awayScore = match.awayScore {
            scoreLabel.text = "\(homeScore)-\(awayScore)"
            resultLabel.text = initOdds.result?.description
            resultLabel.textColor = initOdds.result?.color
            
        } else {
            scoreLabel.text = "VS"
            resultLabel.text = "-"
            resultLabel.textColor = TSColor.gray.gamut333333
        }
        
        
        winFirstLabel.text = initOdds.above.decimal(2)
        drawFirstLabel.text = initOdds.handicap
        lostFirstLabel.text = initOdds.below.decimal(2)
        
        winSecondLabel.text = lastOdds.above.decimal(2)
        winSecondLabel.textColor = TSOddsHelper.trendColor(trend: asia.aboveTrend)
        drawSecondLabel.text = lastOdds.handicap
        drawSecondLabel.textColor = TSOddsHelper.trendColor(trend: Double(asia.handicapTrend))
        lostSecondLabel.text = lastOdds.below.decimal(2)
        lostSecondLabel.textColor = TSOddsHelper.trendColor(trend: asia.belowTrend)
        
    }
    
    private func configCommon(match: FBMatchModel, needBackgroundColor: Bool) {
        self.needBackgroundColor = needBackgroundColor
        contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
        
        leagueLabel.text = match.league.name
        leagueLabel.textColor = match.league.color
        timeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "YYYY-MM-dd", isIntelligent: false)
        
        homeLabel.text = match.home
        awayLabel.text = match.away
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.contentView.backgroundColor = self.needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
            },
                completion: nil
            )
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
        }
    }
}
