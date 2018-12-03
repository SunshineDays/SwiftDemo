//  Created by tianshui on 2017/12/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Charts

/// 赛事分析 必发成交量 饼形图
class FBMatchOddsBetfairPieChartView: UIView {
    
    @IBOutlet weak var totalVolumeLabel: UILabel!
    @IBOutlet weak var chartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chartView.noDataText = "暂无交易量"
        chartView.legend.enabled = false
        chartView.chartDescription?.enabled = false
        chartView.drawHoleEnabled = false
        chartView.highlightPerTapEnabled = false
        chartView.rotationEnabled = false
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        
    }

    func configView(betfair: FBMatchOddsBetfairDataModel) {
        guard betfair.totalVolume > 0 else {
            totalVolumeLabel.text = "暂无交易量"
            return
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        totalVolumeLabel.text = formatter.string(for: Int(betfair.totalVolume))
     
        let entries = [
            PieChartDataEntry(value: betfair.winStatistics.deal.volume, label: "主胜"),
            PieChartDataEntry(value: betfair.drawStatistics.deal.volume, label: "平局"),
            PieChartDataEntry(value: betfair.lostStatistics.deal.volume, label: "客胜")
        ]
        
        let set = PieChartDataSet(values: entries, label: nil)
        set.colors = [TSColor.matchResult.win, TSColor.matchResult.draw, TSColor.matchResult.lost]
        set.selectionShift = 0
        
        let data = PieChartData(dataSet: set)
        
        let pieFormatter = NumberFormatter()
        pieFormatter.numberStyle = .percent
        pieFormatter.maximumFractionDigits = 0
        pieFormatter.multiplier = 1
        
        data.setValueFormatter(DefaultValueFormatter(formatter: pieFormatter))
        data.setValueFont(UIFont.systemFont(ofSize: 10, weight: .light))
        data.setValueTextColor(UIColor.white)
        
        chartView.data = data
    }
}
