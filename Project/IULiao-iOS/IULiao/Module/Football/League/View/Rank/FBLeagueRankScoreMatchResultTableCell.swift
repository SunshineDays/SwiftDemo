//
//  FBLeagueRankScoreMatchResultTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛 排行榜 积分(近期战绩显示)
class FBLeagueRankScoreMatchResultTableCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet var resultLabels: [UILabel]!
    
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchResultViewWidthConstraint: NSLayoutConstraint!
    
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
            matchResultViewWidthConstraint.constant = 190
        } else if TSScreen.currentWidth == TSScreen.iPhone6Width {
            rankLabelLeftConstraint.constant = 8
            matchResultViewWidthConstraint.constant = 202
        } else if TSScreen.currentWidth == TSScreen.iPhone6PlusWidth {
            rankLabelLeftConstraint.constant = 12
            matchResultViewWidthConstraint.constant = 214
        }
    }

    func configCell(score: FBLeagueRankScoreModel, rank: Int, needBackgroundColor: Bool = false, textColor: UIColor = TSColor.gray.gamut666666) {
        self.needBackgroundColor = needBackgroundColor
        
        rankLabel.text = "\(rank)"
        teamNameLabel.text = score.teamName
        
        rankLabel.textColor = textColor
        teamNameLabel.textColor = textColor
    
        
        if let grade = score.grade {
            rankLabel.backgroundColor = grade.color
            rankLabel.textColor = UIColor.white
            rankLabel.cornerRadius = rankLabel.width / 2
        } else {
            rankLabel.backgroundColor = UIColor.clear
            rankLabel.textColor = textColor
            rankLabel.cornerRadius = 0
        }
        
        for index in score.matchResults.count..<resultLabels.count {
            let label = resultLabels[index]
            label.text = "-"
            label.backgroundColor = UIColor(hex: 0xC2C2C2)
        }
        
        for (index, result) in score.matchResults.enumerated() {
            guard index < resultLabels.count else {
                break
            }
            let label = resultLabels[index]
            label.text = result.description
            var color: UIColor!
            switch result {
            case .win: color = UIColor(hex: 0xEE4848)
            case .draw: color = UIColor(hex: 0xE5BC65)
            case .lost: color = UIColor(hex: 0x5A1E8)
            }
            label.backgroundColor = color
        }
        
    }
    
}
