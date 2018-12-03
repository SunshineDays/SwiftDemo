//
//  FBMatchAnalyzeEventAwayNormalTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 比赛事件 客队普通cell
class FBMatchAnalyzeEventAwayNormalTableCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNameLabelOffsetConstraint: NSLayoutConstraint!
    
    func configCell(event: FBMatchAnalyzeEventModel.Event) {
        let eventType = event.type
        timeLabel.text = event.time + "'"
        playerNameLabel.text = event.text
        typeImageView.image = eventType.image
        
        if eventType == .goal || eventType == .penalty || eventType == .ownGoal {
            goalTypeLabel.isHidden = false
            playerNameLabelOffsetConstraint.constant = 56
            goalTypeLabel.text = eventType.goalDescription
            goalTypeLabel.backgroundColor = eventType.goalColor
        } else {
            goalTypeLabel.isHidden = true
            playerNameLabelOffsetConstraint.constant = 20
        }
    }
}
