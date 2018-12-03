//
//  FBLeagueRankScoreStatisticsTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛 排行榜 积分(统计显示)
class FBLeagueRankScoreStatisticsTableCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticsLabelWidthConstraint: NSLayoutConstraint!
    
    private var needBackgroundColor = false
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            rankLabelLeftConstraint.constant = 4
            statisticsLabelWidthConstraint.constant = 60
        } else if TSScreen.currentWidth == TSScreen.iPhone6Width {
            rankLabelLeftConstraint.constant = 8
            statisticsLabelWidthConstraint.constant = 72
        } else if TSScreen.currentWidth == TSScreen.iPhone6PlusWidth {
            rankLabelLeftConstraint.constant = 12
            statisticsLabelWidthConstraint.constant = 84
        }
    }
    
    func configCell(score: FBLeagueRankScoreModel, rank: Int, needBackgroundColor: Bool = false, textColor: UIColor = TSColor.gray.gamut666666) {
        self.needBackgroundColor = needBackgroundColor
        
        rankLabel.text = "\(rank)"
        teamNameLabel.text = score.teamName
        totalLabel.text = "\(score.totalCount)"
        statisticsLabel.text = "\(score.winCount)/\(score.drawCount)/\(score.lostCount)"
        
        goalLabel.text = "\(score.goal)/\(score.fumble)"
        scoreLabel.text = "\(score.score)"
        

        teamNameLabel.textColor = textColor
        totalLabel.textColor = textColor
        statisticsLabel.textColor = textColor
        goalLabel.textColor = textColor
        scoreLabel.textColor = textColor
        
        
        if let grade = score.grade {
            rankLabel.backgroundColor = grade.color
            rankLabel.textColor = UIColor.white
            rankLabel.cornerRadius = rankLabel.width / 2
        } else {
            rankLabel.backgroundColor = UIColor.clear
            rankLabel.textColor = textColor
            rankLabel.cornerRadius = 0
        }
    }
}
