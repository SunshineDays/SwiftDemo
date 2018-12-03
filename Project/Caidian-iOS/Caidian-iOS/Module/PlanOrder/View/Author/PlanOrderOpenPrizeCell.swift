//
//  PlanOrderOpenPrizeCell.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 计划跟单 首页Cell（已开奖）
class PlanOrderOpenPrizeCell: UITableViewCell {

    @IBOutlet weak var resultLostView: UILabel!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var totalBonusLabel: UILabel!

    @IBOutlet weak var spLabel: UILabel!
    
    @IBOutlet weak var dateDescribeLabel: UILabel!
    
    @IBOutlet weak var buyDescribeLabel: UILabel!
    
    @IBOutlet weak var lineUIView: UIView!
    @IBOutlet weak var statueDescibeConstraint: NSLayoutConstraint!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var statueImageView: UIImageView!
    @IBOutlet weak var statueDescibeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        statueImageView.image = R.image.order.hit()
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        lineUIView.backgroundColor = UIColor.cellSeparatorBackground
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineUIView.backgroundColor = UIColor.cellSeparatorBackground
    }
    
    
    func configView(planDetailModel : PlanOrderDetailModel, planModel : PlanModel?)  {
             
        dateDescribeLabel.text = TSUtils.timestampToString(planDetailModel.saleEndTime, withFormat: "MM-dd")  + "  \(planDetailModel.lotteryName) "
        if planModel != nil {
            authorLabel.text = "\(planModel!.author)发起"
        }
        

        // 中奖
        if  planDetailModel.winStatus == OrderWinStatusType.win{
            resultLostView.isHidden = true
            resultView.isHidden = false
            
            totalBonusLabel.text = planDetailModel.bonus.moneyText(2)

            spLabel.text = planDetailModel.sp
            
//            totalBonusLabel.textColor = UIColor.matchResult.win
            statueImageView.image = R.image.order.plan_statue_win()

        } else{
            statueImageView.image = R.image.order.plan_statue_lost()
            resultLostView.isHidden = false
            resultView.isHidden = true
        }


        var money = 0
        var bonus = 0.00

        planDetailModel.buyList.forEach{
            money += $0.buyMoney
            bonus += $0.bonus
        }


        // 未中奖 || 未购买  隐藏购买信息

            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "您已购买 ", attributes: [:]))
            attrStr.append(NSAttributedString(string: money.moneyText(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.lost]))
            attrStr.append(NSAttributedString(string: " 元", attributes: [:]))
            if OrderWinStatusType.win == planDetailModel.winStatus{
                attrStr.append(NSAttributedString(string: ", 中奖 ", attributes: [:]))
                attrStr.append(NSAttributedString(string: bonus.moneyText(2), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.win]))
                attrStr.append(NSAttributedString(string: " 元 ", attributes: [:]))
            }
            buyDescribeLabel.attributedText = attrStr

        
    }
    
    
}
