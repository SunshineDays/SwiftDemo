//
//  FBLeagueScheduleRoundCollectionViewCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛 赛程 轮次
class FBLeagueScheduleRoundCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                nameLabel.backgroundColor = UIColor(hex: 0xd9d9d9)
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.1,
                    options: .curveEaseInOut,
                    animations: {
                        self.nameLabel.backgroundColor = UIColor.white
                },
                    completion: nil
                )
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                let color = UIColor(hex: 0xFC9A39)
                nameLabel.textColor = color
                nameLabel.borderColor = color
                nameLabel.borderWidthPixel = 1
            } else {
                nameLabel.borderWidthPixel = 0
            }
        }
    }
    
    func configCell(round: FBLeagueStageModel.GroupModel, isSelected: Bool) {
        
        nameLabel.text = "第\(round.name)轮"
        self.isSelected = isSelected
    }
}
