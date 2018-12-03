//
//  FBTeamDetailHistoryMatchItemView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队 近期走势(历史交锋) item
class FBTeamDetailHistoryMatchItemView: UIView {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultHieghtConstraint: NSLayoutConstraint!
    
    func configView(teamId: Int, match: FBLiveMatchModel) {
        let logo = teamId == match.homeTid ? match.awayLogo : match.homeLogo
        if let url = TSImageURLHelper(string: logo).size(w: 60, h: 60).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image40x40(), completed: nil)
        }
        
        if let r  = result(teamId: teamId, homeTeamId: match.homeTid, awayTeamId: match.awayTid, homeScore: match.homeScore, awayScore: match.awayScore) {
            switch r {
            case .win:
                resultHieghtConstraint.constant = 60
            case .draw:
                resultHieghtConstraint.constant = 40
            case .lost:
                resultHieghtConstraint.constant = 20
            }
            resultView.backgroundColor = r.color
        }
        
    }
    
    
    private func result(teamId: Int?, homeTeamId: Int?, awayTeamId: Int?, homeScore: Int?, awayScore: Int?) -> FBMatchResultEuropeType? {
        guard let teamId = teamId,
            let homeTeamId = homeTeamId,
            let awayTeamId = awayTeamId,
            let homeScore = homeScore,
            let awayScore = awayScore else {
            return nil
        }
        return FBMatchResultEuropeType(teamId: teamId, homeTeamId: homeTeamId, awayTeamId: awayTeamId, homeScore: homeScore, awayScore: awayScore)
    }
 
}
