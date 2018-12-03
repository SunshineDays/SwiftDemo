//
//  UserWithdrawListTableViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 提现列表cell
class UserWithdrawListTableViewCell: UITableViewCell {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!


    func configCell(userWithdrawModel: UserWithDrawModel) {
        orderLabel.text = userWithdrawModel.codeNum
        timeLabel.text = TSUtils.timestampToString(userWithdrawModel.createdTime)
        moneyLabel.text = "\(userWithdrawModel.money.decimal(2))元"
        statusLabel.text = userWithdrawModel.status.description
        statusLabel.textColor = userWithdrawModel.status.color
        remarkLabel.text = userWithdrawModel.remark
    }

}
