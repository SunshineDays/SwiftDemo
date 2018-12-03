//
//  FBLeagueHotCollectionCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 热门联赛
class FBLeagueHotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var logoImageRightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            logoImageRightConstraint.constant = 0
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                contentView.backgroundColor = UIColor(hex: 0xFCE3CA)
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
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor(hex: 0xFCE3CA)
            } else {
                contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    func configCell(league: FBLeagueModel) {
        
        leagueNameLabel.text = league.name
        
        if let url = TSImageURLHelper(string: league.logo).size(w: 80, h: 80).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image40x40(), completed: nil)
        }
    }
    
}
