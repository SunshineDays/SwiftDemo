//
//  FBRecommendSponsorMatchJIngcaiFooterView.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 竞彩 赛事选择 下一步
class FBRecommendSponsorMatchJIngcaiFooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextButton.setBackgroundColor(UIColor(hex: 0x666666), forState: .normal)
        nextButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
    }
    
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
}
