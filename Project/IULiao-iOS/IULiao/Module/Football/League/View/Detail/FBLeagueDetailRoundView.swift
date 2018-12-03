//
//  FBLeagueDetailRoundView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/19.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛详情 轮次
class FBLeagueDetailRoundView: UIView {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startRoundLabel: UILabel!
    @IBOutlet weak var endRoundLabel: UILabel!
    
    func configView(season: FBLeagueSeasonModel) {
        
        guard let allRound = season.allRound, allRound > 0 else {
            return
        }
        let currentRound = min(season.currentRound ?? 1, allRound)
        endRoundLabel.text = "\(allRound)"
        progressView.progress = Float(currentRound) / Float(allRound)
        
    }
}

