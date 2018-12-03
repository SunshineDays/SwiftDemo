//
//  FBPlayerMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员 比赛表现
class FBPlayerMatchTableCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            bgView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            bgView.backgroundColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            bgView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.bgView.backgroundColor = UIColor.white
            },
                completion: nil
            )
        }
    }
    
    func configCell(match: FBPlayerMatchModel) {
        dateLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "MM-dd", isIntelligent: false)
        leagueLabel.text = match.league.name
        homeLabel.text = match.home
        awayLabel.text = match.away
        if let home = match.homeScore, let away = match.awayScore {
            scoreLabel.text = "\(home):\(away)"
        } else {
            scoreLabel.text = "vs"
        }
        
        rateLabel.text = match.rate > 0 ? "\(match.rate)" : "/"
        rateLabel.backgroundColor = match.gradeColor
    }
}
