//
//  FBLeagueDetailMatchResultItemView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Charts

/// 联赛详情 赛果分布 item
class FBLeagueDetailMatchResultItemView: UIView {

    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var matchCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pieChartView.legend.enabled = false
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = true
        pieChartView.highlightPerTapEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawSlicesUnderHoleEnabled = false
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.holeRadiusPercent = 0.85
    
    }
}
