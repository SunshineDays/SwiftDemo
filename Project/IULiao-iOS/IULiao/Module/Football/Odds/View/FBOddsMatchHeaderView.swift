//
//  FBOddsMatchHeaderView.swift
//  IULiao
//
//  Created by tianshui on 16/8/16.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class FBOddsMatchHeaderView: UITableViewHeaderFooterView {
 
    static let reuseIdentifier = "FBOddsMatchHeaderView"
    
    var match: FBOddsMatchModel?
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var oddsTypeLabel: UILabel!
    
    func configCell(match: FBOddsMatchModel, oddsType: OddsType = .europe) {
        matchView.backgroundColor = match.league.color
        serialLabel.text = match.serial
        leagueLabel.text = match.league.name
        
        homeLabel.text = match.home
        awayLabel.text = match.away
        if let homeScore = match.homeScore, let awayScore = match.awayScore , match.stateType == .over {
            timeLabel.text = "\(homeScore):\(awayScore)"
        } else {
            timeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
        }
        
        oddsTypeLabel.text = oddsType.name
        
        self.match = match
    }
}

