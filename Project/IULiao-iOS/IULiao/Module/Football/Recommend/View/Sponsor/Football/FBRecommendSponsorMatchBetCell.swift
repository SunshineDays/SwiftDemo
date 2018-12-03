//
//  FBRecommendSponsorMatchBetCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 足球推荐 发布
class FBRecommendSponsorMatchBetCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var homeTeamButton: UIButton!
    
    @IBOutlet weak var handicapButton: UIButton!
    
    @IBOutlet weak var awayTeamButton: UIButton!
    
    public func setupConfigTitleView(titles: [String]) {
        homeTeamButton.setTitle(titles[0], for: .normal)
        handicapButton.setTitle(titles[1], for: .normal)
        awayTeamButton.setTitle(titles[2], for: .normal)
    }
    
    public func setupConfigView(asiaModel: FBRecommendSponsorMatchBetAsiaModel) {
        homeTeamButton.setTitle(String(format: "%.2f", asiaModel.above), for: .normal)
        handicapButton.setTitle(asiaModel.handicap, for: .normal)
        awayTeamButton.setTitle(String(format: "%.2f", asiaModel.below), for: .normal)
        
        
    }
    
    func setupConfigView(daXiaoModel: FBRecommendSponsorMatchBetDaXiaoModel) {
        homeTeamButton.setTitle(String(format: "%.2f", daXiaoModel.big), for: .normal)
        handicapButton.setTitle(daXiaoModel.handicap, for: .normal)
        awayTeamButton.setTitle(String(format: "%.2f", daXiaoModel.small), for: .normal)
        
    }
    
    func setupFlag(flags: [Bool]) {
        
        homeTeamButton.setTitleColor(flags[0] ? UIColor.white : UIColor(hex: 0x666666), for: .normal)
        awayTeamButton.setTitleColor(flags[1] ? UIColor.white : UIColor(hex: 0x666666), for: .normal)
        
        homeTeamButton.backgroundColor = flags[0] ? UIColor(hex: 0xFC9A39) : UIColor(hex: 0xF2F2F2)
        awayTeamButton.backgroundColor = flags[1] ? UIColor(hex: 0xFC9A39) : UIColor(hex: 0xF2F2F2)
    }
    
    
}
