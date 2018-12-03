//
//  FBLiveMatchShowNotificationCell.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLiveMatchShowNotificationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var awayNameLabel: UILabel!
    
    @IBOutlet weak var homeLogoImageView: UIImageView!
    @IBOutlet weak var awayLogoImageView: UIImageView!
    
    
    public func configCell(match: FBLiveMatchModel2) {
        homeNameLabel.text = match.home
        awayNameLabel.text = match.away
        homeScoreLabel.text = "\(match.homeScore ?? 0)"
        awayScoreLabel.text = "\(match.awayScore ?? 0)"
        
        /// 球队进球方 球队名与比分标记红色
        if match.lastHomeScore != nil && match.lastHomeScore != match.homeScore {
            homeNameLabel.textColor = FBColorType.red.color
            homeScoreLabel.textColor = FBColorType.red.color
            homeLogoImageView.isHidden = false
        } else {
            homeNameLabel.textColor = UIColor.black
            homeScoreLabel.textColor = UIColor.black
            homeLogoImageView.isHidden = true
        }
        
        if match.lastAwayScore != nil && match.lastAwayScore != match.awayScore {
            awayNameLabel.textColor = FBColorType.red.color
            awayScoreLabel.textColor = FBColorType.red.color
            awayLogoImageView.isHidden = false
        } else {
            awayNameLabel.textColor = UIColor.black
            awayScoreLabel.textColor = UIColor.black
            awayLogoImageView.isHidden = true
        }
    }
    
}
