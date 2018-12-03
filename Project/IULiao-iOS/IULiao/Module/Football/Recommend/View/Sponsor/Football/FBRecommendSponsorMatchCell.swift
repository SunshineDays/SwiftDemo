//
//  FBRecommendSponsorMatchCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 足球 赛事选择 UITableViewCell
class FBRecommendSponsorMatchCell: UITableViewCell {

    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusImageView: UIImageView!
    
    @IBOutlet weak var homeTeamLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var awayTeamLabelConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupConfigView(model: FBRecommendSponsorMatchModel) {
        leagueNameLabel.text = model.lName
        leagueNameLabel.textColor = UIColor(rgba: model.color)
        timeLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "HH:mm")
        homeTeamLabel.text = model.home
        awayTeamLabel.text = model.away
        statusLabel.text = model.isBetAsia || model.isBetDaXiao || model.isBetEurope ? "已推" : ""
        statusImageView.image = model.isBetAsia || model.isBetDaXiao || model.isBetEurope ? R.image.fbRecommend2.pencilNormal() : R.image.fbRecommend2.pencilSelected()
        
        var widthConstraint: CGFloat = 100
        
        switch TSScreen.currentWidth {
        case TSScreen.iPhone5Width:
            widthConstraint = 80
        case TSScreen.iPhoneXWidth:
            widthConstraint = 110
        case TSScreen.iPhone6PlusWidth:
            widthConstraint = 130
        default:
            break
        }
        homeTeamLabelConstraint.constant = widthConstraint
        awayTeamLabelConstraint.constant = widthConstraint + (statusLabel.text?.count == 0 ? 30 : 10)
    }
    
    
    
}
