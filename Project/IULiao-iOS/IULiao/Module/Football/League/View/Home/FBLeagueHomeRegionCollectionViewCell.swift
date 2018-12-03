//
//  FBLeagueHomeRegionCollectionViewCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 洲际赛事联赛(国际赛)
class FBLeagueHomeRegionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                leagueNameLabel.backgroundColor = UIColor(hex: 0xFCE3CA)
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.1,
                    options: .curveEaseInOut,
                    animations: {
                        self.leagueNameLabel.backgroundColor = UIColor.white
                },
                    completion: nil
                )
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                leagueNameLabel.backgroundColor = UIColor(hex: 0xFCE3CA)
            } else {
                leagueNameLabel.backgroundColor = UIColor.white
            }
        }
    }
    
    func configCell(league: FBLeagueModel) {
        leagueNameLabel.text = league.name
    }
}
