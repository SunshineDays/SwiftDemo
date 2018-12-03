//
//  FBRecommendSponsorMatchSelectCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/16.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 赛事筛选 UICollectionViewCell
class FBRecommendSponsorMatchSelectCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderWidthPixel = 1
        cornerRadius = 1
    }

    /// 赛事筛选
    public func setupConfigView(model: FBRecommendSponsorMatchModel, flag: Bool) {
        
        self.titleLabel.text = model.lName
        if flag {
            borderColor = UIColor(hex: 0xFC9A39)
            titleLabel.textColor = UIColor(hex: 0xFC9A39)
            flagImageView.isHidden = false
        }
        else {
            self.layer.borderColor = UIColor(hex: 0x999999).cgColor
            titleLabel.textColor = UIColor(hex: 0x666666)
            flagImageView.isHidden = true
        }
    }
    
    /// 投注选择
    public func setupConfigView(betModel: FBRecommendSponsorMatchModel, flag: Bool) {
        
    }
    
    public func setupConfigView(name: String, flag: Bool) {
        
        self.titleLabel.text = name
        if flag {
            borderColor = UIColor(hex: 0xFC9A39)
            titleLabel.textColor = UIColor(hex: 0xFC9A39)
            flagImageView.isHidden = false
        }
        else {
            self.layer.borderColor = UIColor(hex: 0x999999).cgColor
            titleLabel.textColor = UIColor(hex: 0x666666)
            flagImageView.isHidden = true
        }
    }
    
    
}
