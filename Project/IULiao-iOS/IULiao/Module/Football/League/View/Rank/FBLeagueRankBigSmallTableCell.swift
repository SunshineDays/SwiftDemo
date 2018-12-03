//
//  FBLeagueRankAsiaTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛 排行榜 大小球
class FBLeagueRankBigSmallTableCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    
    @IBOutlet var resultLabels: [UILabel]!
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticsLabelWidthConstraint: NSLayoutConstraint!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.contentView.backgroundColor = UIColor.white
            },
                completion: nil
            )
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            rankLabelLeftConstraint.constant = 8
            statisticsLabelWidthConstraint.constant = 60
        } else if TSScreen.currentWidth == TSScreen.iPhone6Width {
            rankLabelLeftConstraint.constant = 12
            statisticsLabelWidthConstraint.constant = 72
        } else if TSScreen.currentWidth == TSScreen.iPhone6PlusWidth {
            rankLabelLeftConstraint.constant = 16
            statisticsLabelWidthConstraint.constant = 84
        }
    }
    
    func configCell(bigSmall: FBLeagueRankBigSmallModel, rank: Int) {
        rankLabel.text = "\(rank)"
        teamNameLabel.text = bigSmall.teamName
        totalLabel.text = "\(bigSmall.totalCount)"
        statisticsLabel.text = "\(bigSmall.bigCount)/\(bigSmall.drawCount)/\(bigSmall.smallCount)"
        
        for index in bigSmall.matchResults.count..<resultLabels.count {
            let label = resultLabels[index]
            label.text = "-"
            label.backgroundColor = UIColor(hex: 0xC2C2C2)
        }
        
        for (index, result) in bigSmall.matchResults.enumerated() {
            guard index < resultLabels.count else {
                break
            }
            let label = resultLabels[index]
            label.text = result.description
            var color: UIColor!
            switch result {
            case .big: color = UIColor(hex: 0xE56565)
            case .draw: color = UIColor(hex: 0xE5BC65)
            case .small: color = UIColor(hex: 0x45A1E8)
            }
            label.backgroundColor = color
        }
        
    }
}
