//
//  UserBuyListSectionView.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class UserBuyListSectionView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setDate(date: String) {
        dateLabel.text = date
    }

}
