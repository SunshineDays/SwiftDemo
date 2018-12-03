//
//  FBLeagueDetailGoalAverageView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛详情 场均进球
class FBLeagueDetailGoalAverageView: UIView {

    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var homeProgressView: UIView!
    @IBOutlet weak var homeProgressViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayProgressViewWidthConstraint: NSLayoutConstraint!
 
    func configView(statistics: FBLeagueDetailModel.MatchStatistics) {
        homeScoreLabel.text = statistics.homeScore.decimal(2)
        awayScoreLabel.text = statistics.awayScore.decimal(2)
        
        let maxWidth = homeProgressView.width
        let homeScore = statistics.homeScore
        let awayScore = statistics.awayScore
        if homeScore > 0 && awayScore > 0 {
            homeProgressViewWidthConstraint.constant = CGFloat(homeScore / (homeScore + awayScore)) * maxWidth
            awayProgressViewWidthConstraint.constant = CGFloat(awayScore / (homeScore + awayScore)) * maxWidth
        } else {
            homeProgressViewWidthConstraint.constant = 1
            awayProgressViewWidthConstraint.constant = 1
        }
    }
}
