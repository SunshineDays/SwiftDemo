//
//  PlanOrderMainCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/11.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 计划跟单
class PlanOrderMainCell: UITableViewCell {

    @IBOutlet weak var planContentView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var planNameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var canBetImageView: UIImageView!
    
    @IBOutlet weak var totalBounusLabel: UILabel!
    
    @IBOutlet weak var totalPeopleNumberLabel: UILabel!
    
    @IBOutlet weak var betFollowView: UIView!
    
    @IBOutlet weak var betNumberLabel: UILabel!
    
    @IBOutlet weak var betBounusLabel: UILabel!
    
    @IBOutlet weak var totalPeopleTitleLabel: UILabel!
    
    @IBOutlet weak var bonusTitleLabel: UILabel!
    
    @IBOutlet weak var numberTitleLabel: UILabel!
    
    @IBOutlet weak var shaowLeftImageView: UIImageView!
    
    @IBOutlet weak var shaowRightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        clipsToBounds = true
        planContentView.clipsToBounds = false
        planContentView.layer.shadowColor = UIColor(hex: 0x000000).cgColor
        planContentView.layer.shadowOpacity = 0.15
        planContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        planContentView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 计划跟单
    public func configCell(withPlanOrder model: PlanOrderBigPlanModel) {
        if let url = URL(string: model.avatar) {
            avatarImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image60x60())
        }
        planNameLabel.text = model.title
        
        typeLabel.text = model.genreName
        
        canBetImageView.isHidden = !model.canBet
        
        shaowLeftImageView.isHidden = true
        shaowRightImageView.isHidden = true
        
        totalBounusLabel.text = model.totalBonus.moneyText(2)
        totalPeopleNumberLabel.text = model.followUser.string()
        if model.buyModel.buyCount > 0 {
            betNumberLabel.text = model.buyModel.buyCount.string()
            betBounusLabel.text = model.buyModel.bonus.moneyText(2)
            shaowLeftImageView.isHidden = false
            shaowRightImageView.isHidden = false
        }
        
        betFollowView.isHidden = model.buyModel.buyCount == 0
    }
    
    /// 我的计划单
    public func configCell(withUserPlanOrder model: UserPlanOrderBigPlanListModel) {
        if let url = URL(string: model.planModel.avatar) {
            avatarImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image60x60())
        }
        planNameLabel.text = model.planModel.title

        typeLabel.text = model.planModel.genreName

        canBetImageView.isHidden = true
        
        shaowLeftImageView.isHidden = true
        shaowRightImageView.isHidden = true

        totalBounusLabel.text = model.statisticModel.bonus.moneyText(2)
        totalPeopleNumberLabel.text = model.statisticModel.buyCount.string()
        betFollowView.isHidden = true
        
        totalPeopleTitleLabel.text = "单"
        bonusTitleLabel.text = "我的中奖金额"
        numberTitleLabel.text = "我的跟单数量"

    }
    
}
