//
//  Pl3RecentTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/17.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 排列三 近期开奖
class Pl3RecentTableCell: UITableViewCell {

    @IBOutlet var ballLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ballLabels.forEach {
            label in
            label.setCornerRadius(radius: label.width / 2, borderWidth: 0, backgroundColor: UIColor.ball.red, borderColor: UIColor.clear)
            label.textColor = UIColor.white
            label.text = "0"
        }
    }
    
    func configView(isShowBackground: Bool) {
        if isShowBackground {
            backgroundColor = UIColor(hex: 0xf5f5f5)
        } else {
            backgroundColor = UIColor.white
        }
    }
    
}
