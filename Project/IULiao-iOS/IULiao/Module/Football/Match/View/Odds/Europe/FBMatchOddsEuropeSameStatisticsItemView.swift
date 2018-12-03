//
//  FBMatchOddsEuropeSameStatisticsItemView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 相同赔率统计item
class FBMatchOddsEuropeSameStatisticsItemView: UIView {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var innerViewWidthConstraint: NSLayoutConstraint!
    
    var percent: Double = 0 {
        didSet {
            percentLabel.text = "\((percent * 100).decimal(0))%"
            if percent > 0 {
                innerViewWidthConstraint.constant = (TSScreen.currentWidth - 72) / 3 * CGFloat(percent)
            }
        }
    }
}
