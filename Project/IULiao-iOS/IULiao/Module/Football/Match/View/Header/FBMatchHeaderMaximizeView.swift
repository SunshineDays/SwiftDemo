//
//  FBMatchHeaderMaximizeView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

/// 赛事分析 头部视图 最大化
class FBMatchHeaderMaximizeView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var liveAnimationBtn: UIButton!
    
    var homeTeamClickBlock: (() -> Void)?
    var awayTeamClickBlock: (() -> Void)?
    var liveAnimationBtnClickBlock: (() -> Void)?
    
    func configView(matchInfo: FBMatchModel) {
        homeLabel.text = matchInfo.home
        awayLabel.text = matchInfo.away
        
        let time = TSUtils.timestampToString(matchInfo.matchTime, withFormat: "yyyy-MM-dd HH:mm", isIntelligent: false)
        leagueLabel.text = "\(matchInfo.league.name) \(time)"
        
        if let homeScore = matchInfo.homeScore {
            scoreLabel.text = "\(homeScore) : \(matchInfo.awayScore ?? 0)"
        }
        
        if let homeLogo = matchInfo.homeLogo {
            if let url = TSImageURLHelper(string: homeLogo).size(w: 120, h: 120).chop(mode: .fillCrop).url {
                homeImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image150x150())
            }
        }
        
        if let awayLogo = matchInfo.awayLogo {
            if let url = TSImageURLHelper(string: awayLogo).size(w: 120, h: 120).chop(mode: .fillCrop).url {
                awayImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image150x150())
            }
        }
        
        homeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeTeamClick)))
        homeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeTeamClick)))
        
        awayImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(awayTeamClick)))
        awayLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(awayTeamClick)))
    }
    
    @objc private func homeTeamClick() {
        homeTeamClickBlock?()
    }
    
    @objc private func awayTeamClick() {
        awayTeamClickBlock?()
    }
    
    @IBAction func liveAnimationBtnClick(_ sender: UIButton) {
        liveAnimationBtnClickBlock?()
    }
}
