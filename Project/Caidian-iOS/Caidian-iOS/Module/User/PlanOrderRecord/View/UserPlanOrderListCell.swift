//
//  UserPlanOrderListCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class UserPlanOrderListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lotteryTypeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var moneyNumberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    public func configView(model: UserPlanOrderListModel?) {
        if let model = model {
            dateLabel.text = TSUtils.timestampToString(model.buy.createdTime, withFormat: "MM-dd HH:mm:ss")
            lotteryTypeLabel.text = model.detail.lotteryName
            authorLabel.text = model.plan.author + "发起"
            moneyNumberLabel.text = model.buy.buyMoney.moneyText()
//            if model.detail.winStatus == .win {
//                resultLabel.text = model.buy.bonus.moneyText(2) + "元"
//                resultLabel.isHidden = false
//            } else {
////                resultLabel.text = model.detail.winStatus.name
//                resultLabel.isHidden = true
//            }
            
            resultLabel.isHidden = false
            switch model.detail.winStatus {
            case .win:
                resultLabel.text = model.buy.bonus.moneyText(2) + "元"
            case .lost:
                resultLabel.isHidden = true
            case .notOpen:
                resultLabel.text = model.detail.winStatus.name
            }
            
            resultLabel.textColor = model.detail.winStatus.color
            resultImageView.image = model.detail.winStatus.image
            orderNumberLabel.text = model.buy.orderNum
        }
    }
    
    
}
