//
//  FBLeagueScheduleStageTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/24.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 阶段筛选
class FBLeagueScheduleStageTableCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var stageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

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

    func configCell(stage: FBLeagueStageModel) {
        stageNameLabel.text = stage.name
    }
}
