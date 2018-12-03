//
//  FBRecommendSponsorMatchBetEuropeCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 足球推荐 发布
class FBRecommendSponsorMatchBetEuropeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var letNumberButton: UIButton!
    
    @IBOutlet weak var winButton: UIButton!
    
    @IBOutlet weak var drawButton: UIButton!
    
    @IBOutlet weak var lostButton: UIButton!
    
    
    public func setupConfigTitleView(titles: [String]) {
        letNumberButton.setTitle(titles[0], for: .normal)
        winButton.setTitle(titles[1], for: .normal)
        drawButton.setTitle(titles[2], for: .normal)
        lostButton.setTitle(titles[3], for: .normal)
        
        winButton.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        drawButton.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        lostButton.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        
        winButton.backgroundColor = UIColor.clear
        drawButton.backgroundColor = UIColor.clear
        lostButton.backgroundColor = UIColor.clear
    }
    
    public func setupConfigView(model: FBRecommendSponsorMatchBetEuropeModel) {
        letNumberButton.setTitle(model.letBall > 0 ? String(format: "+%d", model.letBall) : String(format: "%d", model.letBall), for: .normal)
        letNumberButton.setTitleColor(model.letBall > 0 ? UIColor(hex: 0xFF3333) : (model.letBall == 0 ? UIColor(hex: 0x333333) : UIColor(hex: 0x009933)), for: .normal)
        winButton.setTitle(String(format: "%.2f", model.win), for: .normal)
        drawButton.setTitle(String(format: "%.2f", model.draw), for: .normal)
        lostButton.setTitle(String(format: "%.2f", model.lost), for: .normal)
    }
    
    public func setupFlag(flags: [Bool]) {

        winButton.setTitleColor(flags[0] ? UIColor.white : UIColor(hex: 0x666666), for: .normal)
        drawButton.setTitleColor(flags[1] ? UIColor.white : UIColor(hex: 0x666666), for: .normal)
        lostButton.setTitleColor(flags[2] ? UIColor.white : UIColor(hex: 0x666666), for: .normal)

        winButton.backgroundColor = flags[0] ? UIColor(hex: 0xFC9A39) : UIColor(hex: 0xF2F2F2)
        drawButton.backgroundColor = flags[1] ? UIColor(hex: 0xFC9A39) : UIColor(hex: 0xF2F2F2)
        lostButton.backgroundColor = flags[2] ? UIColor(hex: 0xFC9A39) : UIColor(hex: 0xF2F2F2)
    }
    
}
