//
//  UserCopyOrderHistoryCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class UserCopyOrderHistoryCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var buyMoneyLabel: UILabel!
    
    @IBOutlet weak var copyNumberLabel: UILabel!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var copyButton: UIButton!
    
    @IBOutlet weak var winMoneyLabel: UILabel!
    
    @IBAction func copyAction(_ sender: UIButton) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configCell(model: UserCopyOrderUserHistoryModel) {
        
        dateLabel.text = TSUtils.timestampToString(model.createTime, withFormat: "MM-dd", isIntelligent: false)
        
        rateLabel.text = "\(model.rate.decimal(2))倍"
        buyMoneyLabel.text = "\(model.totalMoney.moneyText())"
        copyNumberLabel.text = "\(model.follow)"
        
        // 未截止
        if model.endTime > NSDate().timeIntervalSince1970 {
            
            endTimeLabel.text = "\(TSUtils.timestampToString(model.endTime, withFormat: "MM-dd HH:mm", isIntelligent: false)) 截止"

            copyButton.isHidden = false

            resultImageView.isHidden = true
            winMoneyLabel.isHidden = true
        } else{
            endTimeLabel.text = "已截止"
            
            copyButton.isHidden = true
            
            resultImageView.isHidden = false
            resultImageView.image = model.winStatus.image

            winMoneyLabel.isHidden = false
            winMoneyLabel.textColor = model.winStatus.color

            switch model.winStatus {
            case .win:
                winMoneyLabel.text = "\(model.bonus.decimal(2))元"
            case .lost:
                winMoneyLabel.isHidden = true
            case .notOpen:
                winMoneyLabel.text = model.winStatus.name
            }
        }

        
    }
    
}
