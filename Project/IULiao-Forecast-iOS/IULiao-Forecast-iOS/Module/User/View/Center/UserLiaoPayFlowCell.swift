//
//  UserLiaoPayFlowCell.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/21.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 交易流水Cell
class UserLiaoPayFlowCell: UITableViewCell {

    @IBOutlet weak var orderNumLabel: UILabel!
    
    @IBOutlet weak var tradeTypeLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    @IBOutlet weak var payLiaoNumLabel: UILabel!
    
    @IBOutlet weak var liaoBalanceLabel: UILabel!
    
    public var model: UserLiaoPayFlowListModel! {
        didSet {
            orderNumLabel.text = model.tradeNum
            tradeTypeLabel.text = model.tradeTypeName
            createTimeLabel.text = model.createTime.timeString(with: "yyyy-MM-dd HH:mm")
            payLiaoNumLabel.text = (model.tradeTypeIsPlus ? "+" : "-") + model.tradeCoin.decimal(0)
            payLiaoNumLabel.textColor = model.tradeTypeIsPlus ? UIColor.logo : UIColor.colour.gamut333333
            liaoBalanceLabel.text = model.remainCoin.decimal(0) + "料豆"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
