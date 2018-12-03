//
//  PlanOrderCopyTableCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/29.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 计划跟单 首页Cell（未开奖）
class PlanOrderCopyTableCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var oneMoneyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    
    @IBOutlet weak var lineUIView: UIView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var followMoneyLabel: UILabel!
    @IBOutlet weak var saleTimeLabel: UILabel!
    @IBOutlet weak var statueDescribeView: UIView!
    @IBOutlet weak var userBuyMoneyLabel: UILabel!
    @IBOutlet weak var statueDescribeConstraint: NSLayoutConstraint!
    // 跟单回调
    var followBtnActionBlock:((_ btn: UIButton) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    @IBAction func followBtnAction(_ sender: UIButton) {
        followBtnActionBlock?(sender)
    }
    
    

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        lineUIView.backgroundColor = UIColor.cellSeparatorBackground
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineUIView.backgroundColor = UIColor.cellSeparatorBackground
    }

    func configView(planDetailModel : PlanOrderDetailModel, planModel : PlanModel?){
        
        // 购买金额
        var money = 0
        planDetailModel.buyList.forEach{
            money += $0.buyMoney
        }
        userBuyMoneyLabel.text = money.moneyText()
        
        // 已截止 &&  未开奖
        if planDetailModel.saleEndTime  < NSDate().timeIntervalSince1970 && planDetailModel.winStatus == OrderWinStatusType.notOpen {

            followBtn.bgColorForDisabledState = UIColor.grayGamut.gamutCCCCCC
            followBtn.setTitle("已截止", for: .disabled)
            followBtn.isEnabled = false
        } else {
            
            followBtn.isEnabled = true
            followBtn.bgColorForSelectedState = UIColor.grayGamut.gamutCCCCCC
            followBtn.bgColorForNormalState = UIColor.logo
            followBtn.setTitle("立即跟单", for: .normal)
            followBtn.setTitle("立即跟单", for: .selected)
        
        }
        
        
        // 未购买
        if planDetailModel.buyList.isEmpty {
            statueDescribeConstraint.constant = 0
            statueDescribeView.isHidden = true
        } else {
            statueDescribeConstraint.constant = 41
            statueDescribeView.isHidden = false
        }
    

        dateLabel.text = TSUtils.timestampToString(planDetailModel.saleEndTime, withFormat: "MM-dd")
        saleTimeLabel.text = TSUtils.timestampToString(planDetailModel.saleEndTime, withFormat: "HH:mm")
        lotteryLabel.text = planDetailModel.lotteryName
        

        if planModel != nil {
            userNameLabel.text = "\(planModel!.author)发起"
        }

        titleLabel.text = "\(planDetailModel.title)"
        followMoneyLabel.text = planDetailModel.followMoney.moneyText()
        followCountLabel.text = "\(planDetailModel.followUser)"
        
        
    }
}
