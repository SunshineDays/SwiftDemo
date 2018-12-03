//
//  FBTeamDetailMatchView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队 即将进行的比赛
class FBTeamDetailMatchView: UIView {
    
    @IBOutlet weak var homeLogoImageView: UIImageView!
    @IBOutlet weak var awayLogoImageView: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configView(match: FBLiveMatchModel) {
        
        if let homeLogo = TSImageURLHelper(string: match.homeLogo).size(w: 120, h: 120).chop(mode: .fillCrop).url {
            homeLogoImageView.sd_setImage(with: homeLogo, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        if let awayLogo = TSImageURLHelper(string: match.awayLogo).size(w: 120, h: 120).chop(mode: .fillCrop).url {
            awayLogoImageView.sd_setImage(with: awayLogo, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        homeLabel.text = match.home
        awayLabel.text = match.away
        leagueLabel.text = "\(match.league.name)" + (match.roundId > 0 ? "第\(match.roundId)轮" : "")
        
        let now = Date().timeInterval
        let diff = match.matchTime - now
        var time = "0 分钟"
        if diff < 60 * 60 {
            let s = String(format: "%2d", Int(diff / 60))
            time = "\(s) 分钟"
        } else if diff < 60 * 60 * 24 {
            let s = String(format: "%2d", Int(diff / 60 / 60))
            time = "\(s) 小时"
        } else {
            let s = String(format: "%2d", Int(diff / 60 / 60 / 24))
            time = "\(s) 天"
        }
        timeLabel.text = "距开赛 \(time)"
    }

}

