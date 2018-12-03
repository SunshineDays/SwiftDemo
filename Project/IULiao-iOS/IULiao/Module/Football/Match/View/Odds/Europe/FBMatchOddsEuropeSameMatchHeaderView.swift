//
//  FBMatchOddsEuropeSameMatchHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/19.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 相同赔率赛事header
class FBMatchOddsEuropeSameMatchHeaderView: UIView {
    
    @IBOutlet weak var timeLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lostFirstLabeRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var oddsLabelWidthConstraint: NSLayoutConstraint!
    
    var oddsType = OddsType.europe {
        didSet {
            configConstraint()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configConstraint()
    }
    
    private func configConstraint() {
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            timeLabelWidthConstraint.constant = 70
            timeLabelLeftConstraint.constant = 2
            timeLabelRightConstraint.constant = 2
            scoreLabelWidthConstraint.constant = 32
            lostFirstLabeRightConstraint.constant = 2
            
            if oddsType == .asia {
                oddsLabelWidthConstraint.constant = 34 * 3 + 20 + 20
            } else {
                oddsLabelWidthConstraint.constant = 34 * 3 + 20
            }
        } else if TSScreen.currentWidth > TSScreen.iPhone6Width {
            
            if oddsType == .asia {
                oddsLabelWidthConstraint.constant = 38 * 3 + 20 + 20
            } else {
                oddsLabelWidthConstraint.constant = 38 * 3 + 20
            }
        }
        
    }
}
