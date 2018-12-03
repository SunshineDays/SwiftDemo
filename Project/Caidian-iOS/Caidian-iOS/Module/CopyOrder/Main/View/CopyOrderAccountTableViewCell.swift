//
//  CopyOrderAccountTableViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/24.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 跟单用户
class CopyOrderAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(copyOrderAccount: CopyOrderAccountModel) {
        userNameLabel.text = copyOrderAccount.userName[0...1] + "****"
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSAttributedString(string: copyOrderAccount.totalMoney.decimal(0), attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrStr.append(NSAttributedString(string: "元", attributes: [NSAttributedStringKey.foregroundColor: UIColor.grayGamut.gamut333333]))

        moneyLabel.attributedText = attrStr
        timeLabel.text = TSUtils.timestampToString(copyOrderAccount.createdTime, withFormat: "MM-dd HH:mm")

    }
    
    //// 计划单跟单信息
    
    func configCell(planOrderFollowAccountModel: PlanOrderFollowAccountModel) {
        userNameLabel.text = planOrderFollowAccountModel.nickName[0...1] + "****"
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSAttributedString(string: planOrderFollowAccountModel.buyMoney.moneyText(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrStr.append(NSAttributedString(string: "元", attributes: [NSAttributedStringKey.foregroundColor: UIColor.grayGamut.gamut333333]))
        
        moneyLabel.attributedText = attrStr
        timeLabel.text = TSUtils.timestampToString(planOrderFollowAccountModel.createdTime, withFormat: "MM-dd HH:mm")
        
    }
}

