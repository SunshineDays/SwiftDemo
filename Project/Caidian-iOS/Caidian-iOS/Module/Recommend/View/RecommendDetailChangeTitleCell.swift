//
//  RecommendDetailChangeTitleCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/15.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class RecommendDetailChangeTitleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    public func configCell(model: RecommendDetailhistoryListtModel, isShow: Bool, isFirstRow: Bool) {
        if isShow {
            titleLabel.textColor = UIColor.logo
            lineView.backgroundColor = UIColor.logo
        } else {
            if isFirstRow {
                titleLabel.textColor = UIColor(hex: 0x4D4D4D)
                lineView.backgroundColor = UIColor.clear
            } else {
                titleLabel.textColor = UIColor(hex: 0xB3B3B3)
                lineView.backgroundColor = UIColor.clear
            }
        }
        titleLabel.text = model.stage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
