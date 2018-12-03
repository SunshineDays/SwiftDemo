//
//  FBLeagueScheduleMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/24.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛程 赛事cell
class FBLeagueScheduleMatchTableCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func configCell(match: FBMatchModel) {
        timeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "yyyy/MM/dd HH:mm", isIntelligent: false)
        homeLabel.text = match.home
        awayLabel.text = match.away
        if let hscore = match.homeScore, let ascore = match.awayScore {
            scoreLabel.text = "\(hscore)-\(ascore)"
        } else {
            scoreLabel.text = "vs"
        }
    }
}
