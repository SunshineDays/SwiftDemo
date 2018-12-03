//
//  FBMatchAnalyzeStatisticsNormalTableCell
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

private let kMinWidth: CGFloat = 8

/// 赛事分析 赛况 普通cell
class FBMatchAnalyzeStatisticsNormalTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeCountLabel: UILabel!
    @IBOutlet weak var awayCountLable: UILabel!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var awayView: UIView!
    
    @IBOutlet weak var homeCountLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayCountLabelWidthConstraint: NSLayoutConstraint!
    
    func configCell(title: String, homeCount: Int, awayCount: Int) {
        titleLabel.text = title
        homeCountLabel.text = "\(homeCount)"
        awayCountLable.text = "\(awayCount)"
        
        let total = homeCount + awayCount
        guard total > 0 else {
            homeCountLabelWidthConstraint.constant = kMinWidth
            awayCountLabelWidthConstraint.constant = kMinWidth
            return
        }
        
        let lightColor = UIColor(hex: 0xFCCA97)
        let darkColor = UIColor(hex: 0xFC7939)
        homeView.backgroundColor = lightColor
        awayView.backgroundColor = lightColor
        if homeCount > awayCount {
            homeView.backgroundColor = darkColor
        } else if homeCount < awayCount {
            awayView.backgroundColor = darkColor
        }
        let maxWidth = TSScreen.currentWidth / 2 - 60
        if homeCount == 0 {
            homeCountLabelWidthConstraint.constant = kMinWidth
        } else {
            homeCountLabelWidthConstraint.constant = CGFloat(homeCount) / CGFloat(total) * maxWidth
        }
        if awayCount == 0 {
            awayCountLabelWidthConstraint.constant = kMinWidth
        } else {
            awayCountLabelWidthConstraint.constant = CGFloat(awayCount) / CGFloat(total) * maxWidth
        }
        
    }
}
