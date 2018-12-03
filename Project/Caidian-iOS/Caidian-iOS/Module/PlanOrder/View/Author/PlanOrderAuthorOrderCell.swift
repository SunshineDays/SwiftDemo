//
//  PlanOrderAuthorOrderCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 圣手计划近30天战绩
class PlanOrderAuthorOrderCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var buyMoneyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    
    
    public func configCell(model: PlanOrderAuthorOrderModel) {
        dateLabel.text = TSUtils.timestampToString(model.saleEndTime, withFormat: "MM-dd", isIntelligent: false)
        buyMoneyLabel.text = model.analogMoney.moneyText()
        resultLabel.text = model.winStatus.title
        bonusLabel.text = model.analogBonus.moneyText(2)
        
        
        if model.winStatus == .win {
            dateLabel.textColor = UIColor.navigationBarTintColor
            buyMoneyLabel.textColor = UIColor.navigationBarTintColor
            resultLabel.textColor = UIColor.navigationBarTintColor
            bonusLabel.textColor = UIColor.navigationBarTintColor
        } else {
            dateLabel.textColor = UIColor(hex: 0x4D4D4D)
            buyMoneyLabel.textColor = UIColor(hex: 0x4D4D4D)
            resultLabel.textColor = UIColor(hex: 0x4D4D4D)
            bonusLabel.textColor = UIColor(hex: 0x4D4D4D)
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
