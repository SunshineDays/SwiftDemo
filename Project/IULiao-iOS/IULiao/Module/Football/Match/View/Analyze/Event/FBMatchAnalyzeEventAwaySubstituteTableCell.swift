//
//  FBMatchAnalyzeEventAwaySubstituteTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 比赛事件 客队换人cell
class FBMatchAnalyzeEventAwaySubstituteTableCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var enterPlayerLabel: UILabel!
    @IBOutlet weak var leavePlayerLabel: UILabel!
    
    
    func configCell(event: FBMatchAnalyzeEventModel.Event) {
        let eventType = event.type
        timeLabel.text = event.time + "'"
        typeImageView.image = eventType.image
        
        enterPlayerLabel.text = event.enterPlayer
        leavePlayerLabel.text = event.leavePlayer
    }
}
