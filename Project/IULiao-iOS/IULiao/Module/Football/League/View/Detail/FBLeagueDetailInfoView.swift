//
//  FBLeagueDetailInfoView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/19.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛详情头部
class FBLeagueDetailInfoView: UIView {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var teamCountLabel: UILabel!
    @IBOutlet weak var winPercentLabel: UILabel!
    @IBOutlet weak var drawPercentLabel: UILabel!
    @IBOutlet weak var lostPercentLabel: UILabel!
    @IBOutlet weak var avgScoreLabel: UILabel!
    
    func configView(leagueDetail: FBLeagueDetailModel) {

        if let logo = TSImageURLHelper(string: leagueDetail.leagueInfo.logo).size(w: 240, h: 240).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        fullNameLabel.text = leagueDetail.leagueInfo.fullName ?? leagueDetail.leagueInfo.name
        
        winPercentLabel.text = (leagueDetail.matchStatistics.winPercent * 100).decimal(1) + "%"
        drawPercentLabel.text = (leagueDetail.matchStatistics.drawPercent * 100).decimal(1) + "%"
        lostPercentLabel.text = (leagueDetail.matchStatistics.lostPercent * 100).decimal(1) + "%"
        
        avgScoreLabel.text = leagueDetail.matchStatistics.avgScore.decimal(2)
        
        if let teamCount = leagueDetail.seasonInfo.teamCount {
            teamCountLabel.text = "\(teamCount)"
        } else {
            teamCountLabel.text = "-"
        }
    }


}
