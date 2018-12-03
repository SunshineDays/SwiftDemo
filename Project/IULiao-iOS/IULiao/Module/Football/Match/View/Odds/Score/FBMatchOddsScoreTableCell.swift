//
//  FBMatchOddsScoreTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 波胆cell
class FBMatchOddsScoreTableCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet var homeOddsLabels: [UILabel]!
    @IBOutlet var awayOddsLabels: [UILabel]!
    @IBOutlet var drawOddsLabels: [UILabel]!
    
    func configCell(score: FBOddsScoreSetModel) {
        let lastOdds = score.lastOdds
        
        companyNameLabel.text = score.company.name
        
        let homeOdds = [lastOdds.score10, lastOdds.score20, lastOdds.score21, lastOdds.score30, lastOdds.score31, lastOdds.score32, lastOdds.score40, lastOdds.score41, lastOdds.score42, lastOdds.score43]
        let awayOdds = [lastOdds.score01, lastOdds.score02, lastOdds.score12, lastOdds.score03, lastOdds.score13, lastOdds.score23, lastOdds.score04, lastOdds.score14, lastOdds.score24, lastOdds.score34]
        let drawOdds = [lastOdds.score00, lastOdds.score11, lastOdds.score22, lastOdds.score33, lastOdds.score44]
        
        for (index, odds) in homeOdds.enumerated() {
            homeOddsLabels[safe: index]?.text = removeZero(input: odds)
        }
        
        for (index, odds) in awayOdds.enumerated() {
            awayOddsLabels[safe: index]?.text = removeZero(input: odds)
        }
        
        for (index, odds) in drawOdds.enumerated() {
            drawOddsLabels[safe: index]?.text = removeZero(input: odds)
        }
    }
    
    private func removeZero(input: Double) -> String {
        let str = input.decimal(1)
        let arr = str.split(separator: ".")
        let (integer, decimal) = (arr[0], arr[1])
        if decimal == "0" {
            return String(integer)
        }
        return str
    }
}
