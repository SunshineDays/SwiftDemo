//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// /// 赛事分析 未来赛事 cell
class FBMatchWarFutureTableCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gapLabel: UILabel!
    
    @IBOutlet weak var scoreLabeWidthConstraint: NSLayoutConstraint!
    
    
    func configCell(match: FBMatchWarModel, teamId: Int, needBackgroundColor: Bool, matchTime: TimeInterval) {
        dateLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "yy-MM-dd", isIntelligent: false)
        leagueLabel.text = match.league.name
        leagueLabel.textColor = match.league.color
        homeLabel.text = match.home
        awayLabel.text = match.away
        
        gapLabel.text = match.asia?.result?.description ?? "-"
        gapLabel.textColor = match.asia?.result?.color ?? TSColor.gray.gamut333333
        
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
        
        scoreLabel.text = "VS"

        let gap = max(0, match.matchTime - matchTime)
        gapLabel.text = ceil(gap / (24 * 60 * 60)).decimal(0) + "天"
    }
    
}
