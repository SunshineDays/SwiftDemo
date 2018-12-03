//
//  FBTeamScheduleTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/9.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队 赛程cell
class FBTeamScheduleTableCell: UITableViewCell {
    
    typealias ButtonClickBlock = ((UIButton) -> Void)
    var matchAnalyseClickBlock: ButtonClickBlock?
    var matchAnimationClickBlock: ButtonClickBlock?
    var homeTeamClickBlock: (() -> Void)?
    var awayTeamClickBlock: (() -> Void)?

    @IBOutlet weak var homeLogoImageView: UIImageView!
    @IBOutlet weak var awayLogoImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var matchAnalyseBtn: UIButton!
    @IBOutlet weak var matchAnimationBtn: UIButton!
    
    override func awakeFromNib() {
        
        homeLogoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeTeamClick(_:))))
        homeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeTeamClick(_:))))
        
        awayLogoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(awayTeamClick(_:))))
        awayLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(awayTeamClick(_:))))
    }
    
    func configCell(teamId: Int, match: FBLiveMatchModel) {
        
        if let url = TSImageURLHelper(string: match.homeLogo).size(w: 80, h: 80).chop(mode: .fillCrop).url {
            homeLogoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        if let url = TSImageURLHelper(string: match.awayLogo).size(w: 80, h: 80).chop(mode: .fillCrop).url {
            awayLogoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        leagueNameLabel.text = match.league.name + " " + (match.roundId > 0 ? "第\(match.roundId)轮" : "")
        timeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "yyyy-MM-dd HH:mm", isIntelligent: false)
        homeLabel.text = match.home
        awayLabel.text = match.away
        if teamId == match.homeTid {
            homeLabel.textColor = TSColor.homeTeam
            awayLabel.textColor = TSColor.gray.gamut333333
        } else {
            homeLabel.textColor = TSColor.gray.gamut333333
            awayLabel.textColor = TSColor.homeTeam
        }
        guard let homeScore = match.homeScore,
            let awayScore = match.awayScore
        else {
            scoreLabel.textColor = TSColor.gray.gamut333333
            scoreLabel.text = "vs"
            matchAnimationBtn.isHidden = true
            return
        }
        
        let result = FBMatchResultEuropeType(teamId: teamId, homeTeamId: match.homeTid, awayTeamId: match.awayTid, homeScore: homeScore, awayScore: awayScore)
        matchAnimationBtn.isHidden = false
        scoreLabel.textColor = result.color
        scoreLabel.text = "\(homeScore)-\(awayScore)"
    }
    
    @IBAction private func matchAnalyseClick(_ sender: UIButton) {
        matchAnalyseClickBlock?(sender)
    }
    
    @IBAction private func matchAnimationClick(_ sender: UIButton) {
        matchAnimationClickBlock?(sender)
    }
    
    @objc private func homeTeamClick(_ sender: UITapGestureRecognizer) {
        homeTeamClickBlock?()
    }
    
    @objc private func awayTeamClick(_ sender: UITapGestureRecognizer) {
        awayTeamClickBlock?()
    }
}
