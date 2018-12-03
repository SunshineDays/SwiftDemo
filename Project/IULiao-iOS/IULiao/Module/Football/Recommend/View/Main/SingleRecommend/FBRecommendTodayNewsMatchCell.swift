//
//  FBRecommendTodayNewsMatchCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/19.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 今日推荐 按比赛找 UITableViewCell
class FBRecommendTodayNewsMatchCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var awayTeamLabelConstraint: NSLayoutConstraint!
    
    public func setupConfigView(model: FBRecommendSponsorMatchModel) {
        leagueNameLabel.text = model.lName
        leagueNameLabel.textColor = UIColor(rgba: model.color)
        timeLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "MM-dd HH:mm")
        homeTeamLabel.text = model.home
        awayTeamLabel.text = model.away
        numberLabel.text = String(format: "%d", model.orderCount)
        
        var widthConstraint: CGFloat = 90

        switch TSScreen.currentWidth {
        case TSScreen.iPhone5Width:
            widthConstraint = 60
        case TSScreen.iPhoneXWidth:
            widthConstraint = 90
        case TSScreen.iPhone6PlusWidth:
            widthConstraint = 110
        default:
            break
        }
        homeTeamLabelConstraint.constant = widthConstraint
        awayTeamLabelConstraint.constant = widthConstraint + 30
    }
}
