//
//  UserBuyListTableViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 投注记录的cell
class UserBuyListTableViewCell: UITableViewCell {

    @IBOutlet weak var lotteryTypeLabel: UILabel!
    @IBOutlet weak var buyTypeLabel: UILabel!
    @IBOutlet weak var winStatusLabel: UILabel!
    @IBOutlet weak var bonusConstraint: NSLayoutConstraint!
    @IBOutlet weak var bonusLebal: UILabel!
    @IBOutlet weak var buyMoneyLabel: UILabel!
    
    func configCell(userSingleOrderModel: UserSingleOrderModel){
        
        self.lotteryTypeLabel.text = userSingleOrderModel.order.lottery.description
        self.buyTypeLabel.text = userSingleOrderModel.order.orderBuyType.description
        self.winStatusLabel.text =  userSingleOrderModel.order.winStatus.name
        buyMoneyLabel.text = "\(userSingleOrderModel.buy.buyMoney.moneyText(0))元"
        
        if userSingleOrderModel.order.revokeStatus != OrderRevokeStatusType.normal{
             self.winStatusLabel.text =  "已撤单"
             bonusConstraint.constant = 10
             bonusLebal.isHidden = true
             return
        }
    
        // 已中奖
        bonusLebal.textColor = UIColor.logo
        winStatusLabel.textColor = UIColor.black
        if userSingleOrderModel.order.bonus != 0.00 {
            bonusConstraint.constant = 20
            bonusLebal.isHidden = false
            bonusLebal.text = "\(userSingleOrderModel.order.bonus.moneyText(2))"
        }else{
            bonusConstraint.constant = 10
            bonusLebal.isHidden = true
            
        }
        
        
        
    }

}
