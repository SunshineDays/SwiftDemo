//
//  FBMatchAnalyzeLineupBackupTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 赛况 阵容 替补cell
class FBMatchAnalyzeLineupBackupTableCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = TSColor.cellHighlightedBackground
        } else {
            backgroundColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.backgroundColor = UIColor.white
            },
                completion: nil
            )
        }
    }
    
    func configCell(player: FBMatchAnalyzeLineupModel.Player) {
        playerNameLabel.text = player.name
        numberLabel.text = player.number == nil ? "-" : "\(player.number!)"
        rateLabel.text = player.rate == 0 ? "-" : player.rate.decimal(1)
        rateLabel.backgroundColor = player.grade.color
    }
}
