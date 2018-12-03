//
//  FBTeamDetailGoalSpreadView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队进失球
class FBTeamDetailGoalSpreadView: UIView {

    @IBOutlet weak var goalTotalLabel: UILabel!
    @IBOutlet weak var fumbleTotalLabel: UILabel!

    @IBOutlet var goalLabels: [UILabel]!
    @IBOutlet var fumbleLabels: [UILabel]!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    func configView(detail: FBTeamDetailModel) {
        
        goalTotalLabel.text = "\(detail.goalTotal)"
        fumbleTotalLabel.text = "\(detail.fumbleTotal)"
        
        for (index, spread) in detail.goalSpreads.enumerated() {
            goalLabels[safe: index]?.text = "\(spread.goal)"
            fumbleLabels[safe: index]?.text = "\(spread.fumble)"
        }
        
        tipLabel.text = "*以上数据为该球队近\(detail.matchCount)场比赛进失球"
    }
}
