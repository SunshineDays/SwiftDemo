//
//  FBMatchWarRecentTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// /// 赛事分析 战绩 cell
class FBMatchWarRecentTableCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    // 近期赛事中为半场比分 相同盘口中为比分
    @IBOutlet weak var halfScoreLabel: UILabel!
    // 近期赛事中为全比分 相同盘口中为盘口
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var asiaResultLabel: UILabel!
    
    @IBOutlet weak var scoreLabeWidthConstraint: NSLayoutConstraint!
    
    /// 近期赛事 历史交锋
    func configCell(recentMatch match: FBMatchWarModel, teamId: Int, needBackgroundColor: Bool) {
        configCommon(match: match, teamId: teamId, needBackgroundColor: needBackgroundColor)
        halfScoreLabel.text = "\(match.homeHalfScore ?? 0)-\(match.awayHalfScore ?? 0)"
        
        let homeScore = match.homeScore ?? 0
        let awayScore = match.awayScore ?? 0
        scoreLabel.text = "\(homeScore)-\(awayScore)"
        
        let europeResult = FBMatchResultEuropeType(teamId: teamId, homeTeamId: match.homeTid, awayTeamId: match.awayTid, homeScore: homeScore, awayScore: awayScore)
        scoreLabel.textColor = europeResult.color
    }
    
    /// 相同盘口
    func configCell(sameHandicapMatch match: FBMatchWarModel, teamId: Int, needBackgroundColor: Bool) {
        scoreLabeWidthConstraint.constant = 50
        configCommon(match: match, teamId: teamId, needBackgroundColor: needBackgroundColor)
        let homeScore = match.homeScore ?? 0
        let awayScore = match.awayScore ?? 0
        halfScoreLabel.text = "\(homeScore)-\(awayScore)"
        scoreLabel.text = match.asia?.handicap
        
        let europeResult = FBMatchResultEuropeType(teamId: teamId, homeTeamId: match.homeTid, awayTeamId: match.awayTid, homeScore: homeScore, awayScore: awayScore)
        halfScoreLabel.textColor = europeResult.color
    }
    
    private func configCommon(match: FBMatchWarModel, teamId: Int, needBackgroundColor: Bool) {
        dateLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "yy-MM-dd", isIntelligent: false)
        leagueLabel.text = match.league.name
        leagueLabel.textColor = match.league.color
        homeLabel.text = match.home
        awayLabel.text = match.away
        
        asiaResultLabel.text = match.asia?.result?.description ?? "-"
        asiaResultLabel.textColor = match.asia?.result?.color ?? TSColor.gray.gamut333333
        
        homeLabel.textColor = TSColor.gray.gamut333333
        awayLabel.textColor = TSColor.gray.gamut333333
        
        if match.homeTid == teamId {
            homeLabel.textColor = TSColor.homeTeam
        } else if match.awayTid == teamId {
            awayLabel.textColor = TSColor.homeTeam
        }
        
        if needBackgroundColor {
            backgroundColor = TSColor.cellEachBackgroud
        } else {
            backgroundColor = UIColor.white
        }
    }
    
}
