//
//  FBMatchOddsBetfairLineChartView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Charts

private class VolumeValueFormatter: NSObject, IAxisValueFormatter {
    override init() {
        super.init()
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return (value / 1000).decimal(0) + "K"
    }
}

private class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MM/dd\nHH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Foundation.Date(timeIntervalSince1970: value))
    }
}

/// 赛事分析 必发成交量 折线图
class FBMatchOddsBetfairLineChartView: UIView {

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    
    private var timeTabs: [TimeType] = [.hour3, .hour12, .hour24, .all]
    private var betfair: FBMatchOddsBetfairDataModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        do {
            segmentedControl.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: TSColor.gray.gamut333333,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            segmentedControl.selectedTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: TSColor.logo,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            
            segmentedControl.isUserDraggable = false
            segmentedControl.selectionIndicatorColor = TSColor.logo
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.selectionStyle = .textWidthStripe
            segmentedControl.segmentWidthStyle = .dynamic
            segmentedControl.selectionIndicatorColor = TSColor.logo
            segmentedControl.selectionIndicatorHeight = 2
            segmentedControl.sectionTitles = timeTabs.map { $0.title }
            segmentedControl.indexChangeBlock = {
                [unowned self] index in
                let timeType = self.timeTabs[index]
                self.configView(timeType: timeType)
            }
        }
        
        do {
            chartView.chartDescription?.enabled = false
            chartView.leftAxis.enabled = true
            chartView.rightAxis.enabled = false
            chartView.noDataText = "暂无交易量"
            chartView.dragEnabled = false
            chartView.scaleXEnabled = false
            chartView.scaleYEnabled = false
            chartView.highlightPerTapEnabled = false
            
            let legend = chartView.legend
            legend.verticalAlignment = .top
            legend.drawInside = false
            
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.labelFont = UIFont.systemFont(ofSize: 10)
            xAxis.labelTextColor = TSColor.gray.gamut999999
            xAxis.valueFormatter = DateValueFormatter()
            xAxis.drawGridLinesEnabled = false
            xAxis.drawAxisLineEnabled = false
            xAxis.centerAxisLabelsEnabled = true
            
            let leftAxis = chartView.leftAxis
            leftAxis.labelPosition = .insideChart
            leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
            leftAxis.granularityEnabled = true
            leftAxis.labelTextColor = TSColor.gray.gamut999999
            leftAxis.axisMinimum = 0
            leftAxis.valueFormatter = VolumeValueFormatter()
        }
    }

    func configView(betfair: FBMatchOddsBetfairDataModel) {
        self.betfair = betfair
        configView(timeType: .hour3)
    }
    
    private func configView(timeType: TimeType) {
        guard let betfair = betfair, betfair.winVolumes.count > 0 else {
            return
        }
        let data = LineChartData(dataSets: [
            createDataSet(title: "主胜", color: TSColor.matchResult.win, volumes: betfair.winVolumes, timeType: timeType),
            createDataSet(title: "平局", color: TSColor.matchResult.draw, volumes: betfair.drawVolumes, timeType: timeType),
            createDataSet(title: "客胜", color: TSColor.matchResult.lost, volumes: betfair.lostVolumes, timeType: timeType),
            ])
        chartView.data = data
    }
    
    
    private func createDataSet(title: String, color: UIColor, volumes: [FBMatchOddsBetfairDataModel.Betfair], timeType: TimeType) -> LineChartDataSet {
        // 取出最大的时间
        let volumes = volumes.sorted(by: { $0.time > $1.time })
        var lastTime = volumes.first?.time ?? Foundation.Date().timeIntervalSince1970
        
        switch timeType {
        case .hour3:
            lastTime -= 3 * 60 * 60
        case .hour12:
            lastTime -= 12 * 60 * 60
        case .hour24:
            lastTime -= 24 * 60 * 60
        case .all:
            lastTime = 0
        }
        
        let entrys = volumes
            .filter({ $0.time > lastTime})
            .sorted(by: { $0.time < $1.time })
            .map { ChartDataEntry(x: $0.time, y: $0.volume) }
        let set = LineChartDataSet(values: entrys, label: title)
        set.axisDependency = .left
        set.setColor(color)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.drawCircleHoleEnabled = false
        set.mode = .cubicBezier
        return set
    }
    
    enum TimeType {
        case hour3, hour12, hour24, all
        
        var title: String {
            switch self {
            case .hour3: return "3小时"
            case .hour12: return "12小时"
            case .hour24: return "24小时"
            default: return "全部"
            }
        }
    }
}
