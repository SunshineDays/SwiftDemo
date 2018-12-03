//
//  FBMatchWarScoreDistributeViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/14.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON
import Charts

/// 赛事分析页 进失球
class FBMatchWarScoreDistributeViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var homeIndicateView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var awayIndicateView: UIView!
    @IBOutlet weak var awayButton: UIButton!
    @IBOutlet weak var sameHomeAwayButton: UIButton!
    @IBOutlet weak var chartView: ScatterChartView!
    @IBOutlet weak var chartViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chartViewBottomConstraint: NSLayoutConstraint!
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return scrollView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let warHandler = FBMatchWarHandler()
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var scoreDistribute = FBMatchWarScoreDistributeModel(json: JSON.null)
    private var eventTabs: [EventType] = [.goal, .fumble]
    private var selectedEventType = EventType.goal {
        didSet {
            configView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }
    
    private enum EventType {
        case goal, fumble
        
        var title: String {
            switch self {
            case .goal: return "进球时间分布"
            case .fumble: return "失球时间分布"
            }
        }
    }
    
    
    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        warHandler.getScoreDistribute(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, scoreDistribute in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.scoreDistribute = scoreDistribute
                self.configView()
                self.scrollView.reloadEmptyDataSet()
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.scrollView.reloadEmptyDataSet()
                self.hud.hide(animated: true)
        })
    }
    
    @IBAction func sameHomeAwayClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        configView()
    }
    
    @IBAction func homeButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        homeIndicateView.backgroundColor = sender.isSelected ? TSColor.matchResult.win : TSColor.matchResult.win.withAlphaComponent(0.3)
        configView()
    }
    @IBAction func awayButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        awayIndicateView.backgroundColor = sender.isSelected ? TSColor.matchResult.lost : TSColor.matchResult.lost.withAlphaComponent(0.3)
        configView()
    }
}

extension FBMatchWarScoreDistributeViewController {
    
    private func initView() {
        scrollView.delegate = self
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
        
        do {
            let height = TSScreen.currentHeight - 240
            if height > 400 {
                chartViewHeightConstraint.constant = height
                chartViewBottomConstraint.constant = 60
            } else {
                chartViewHeightConstraint.constant = 400
                chartViewBottomConstraint.constant = 20
            }
            
        }
        
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
            segmentedControl.segmentWidthStyle = .fixed
            segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            segmentedControl.selectionIndicatorColor = TSColor.logo
            segmentedControl.selectionIndicatorHeight = 2
            segmentedControl.sectionTitles = eventTabs.map { $0.title }
            segmentedControl.indexChangeBlock = {
                [unowned self] index in
                self.selectedEventType = self.eventTabs[index]
            }
        }
        
        do {
            chartView.chartDescription?.enabled = false
            chartView.leftAxis.enabled = true
            chartView.rightAxis.enabled = false
            chartView.noDataText = "暂无进失球数据"
            chartView.dragEnabled = false
            chartView.scaleXEnabled = false
            chartView.scaleYEnabled = false
            chartView.highlightPerTapEnabled = false
            chartView.legend.enabled = false
            
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.labelFont = UIFont.systemFont(ofSize: 10)
            xAxis.labelTextColor = TSColor.gray.gamut999999
            xAxis.drawGridLinesEnabled = true
            xAxis.drawAxisLineEnabled = false
            xAxis.centerAxisLabelsEnabled = false
            xAxis.axisMinimum = 0
            xAxis.axisMaximum = 95
            xAxis.gridLineDashPhase = 2
            xAxis.gridLineDashLengths = [5]
            xAxis.gridColor = TSColor.matchResult.draw
            xAxis.granularityEnabled = true
            xAxis.granularity = 15
            xAxis.labelCount = 10
            
            [0, 45, 90].forEach {
                minute in
                let line = ChartLimitLine(limit: Double(minute))
                line.lineWidth = 1
                xAxis.addLimitLine(line)
            }
            
            let leftAxis = chartView.leftAxis
            leftAxis.labelPosition = .outsideChart
            leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
            leftAxis.granularityEnabled = true
            leftAxis.granularity = 1
            leftAxis.drawGridLinesEnabled = false
            leftAxis.labelTextColor = TSColor.gray.gamut999999
            leftAxis.axisMinimum = 0
            leftAxis.axisMaximum = 11
            leftAxis.drawZeroLineEnabled = true
            leftAxis.labelCount = 10
        }
    }
    
    private func configView() {
        contentView.isHidden = scoreDistribute.home.isEmpty && scoreDistribute.away.isEmpty
        var homeEntrys = [ChartDataEntry]()
        var awayEntrys = [ChartDataEntry]()
        let isSameHomeAway = sameHomeAwayButton.isSelected
        homeButton.setTitle("\(matchInfo.home)", for: .normal)
        awayButton.setTitle("\(matchInfo.away)", for: .normal)
        
        if homeButton.isSelected {
            homeEntrys = getChartDataEntrys(scores: scoreDistribute.home, eventType: selectedEventType, isSameHomeAway: isSameHomeAway, teamId: matchInfo.homeTid, isHomeTeam: true)
        }
        if awayButton.isSelected {
            awayEntrys = getChartDataEntrys(scores: scoreDistribute.away, eventType: selectedEventType, isSameHomeAway: isSameHomeAway, teamId: matchInfo.awayTid, isHomeTeam: false)
        }
        
        let dataSets = [
            createDataSet(shape: .circle, color: TSColor.matchResult.win, entrys: homeEntrys),
            createDataSet(shape: .square, color: TSColor.matchResult.lost, entrys: awayEntrys),
        ]
        let data = ScatterChartData(dataSets: dataSets)
        chartView.data = data
    }
    
    private func getChartDataEntrys(scores: [FBMatchWarScoreDistributeModel.ScoreDistribute], eventType: EventType, isSameHomeAway: Bool, teamId: Int, isHomeTeam: Bool) -> [ChartDataEntry] {
        var entrys = [ChartDataEntry]()
        
        var index = 1
        for score in scores {
            if index >= 11 {
                break
            }
            /// 主客相同
            if isSameHomeAway {
                if isHomeTeam {
                    if score.match.homeTid != teamId {
                        continue
                    }
                } else {
                    if score.match.awayTid != teamId {
                        continue
                    }
                }
            }
            let events = eventType == .goal ? score.goalEventList : score.fumbleEventList
            entrys += events.filter({ Double($0.time) < chartView.xAxis.axisMaximum }).map {
                ChartDataEntry(x: Double($0.time), y: Double(index))
            }
            index += 1
        }
        return entrys
    }
    
    private func createDataSet(shape: ScatterChartDataSet.Shape, color: UIColor, entrys: [ChartDataEntry]) -> ScatterChartDataSet {
        let set = ScatterChartDataSet(values: entrys)
        set.setScatterShape(shape)
        set.setColor(color)
        set.scatterShapeSize = 8
        set.drawValuesEnabled = false
        return set
    }
    
    private func initNetwork() {
        getData()
    }
 
}

extension FBMatchWarScoreDistributeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
}

extension FBMatchWarScoreDistributeViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && scoreDistribute.home.isEmpty && scoreDistribute.away.isEmpty
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}

