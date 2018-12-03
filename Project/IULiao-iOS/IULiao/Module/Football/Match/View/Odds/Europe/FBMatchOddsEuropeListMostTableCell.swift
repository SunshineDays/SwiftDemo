//
//  FBMatchOddsEuropeListMostTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 最大值最小值cell
class FBMatchOddsEuropeListMostTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    
    @IBOutlet weak var contentViewYConstraint: NSLayoutConstraint!
    
    func configCell(title: String, europe: FBOddsEuropeModel, index: Int) {
        titleLabel.text = title
        winLabel.text = europe.win.decimal(2)
        drawLabel.text = europe.draw.decimal(2)
        lostLabel.text = europe.lost.decimal(2)
        
        if index == 0 {
            contentViewYConstraint.constant = 2
        } else if index == 2 {
            contentViewYConstraint.constant = -2
        } else {
            contentViewYConstraint.constant = 0
        }
    }
}
