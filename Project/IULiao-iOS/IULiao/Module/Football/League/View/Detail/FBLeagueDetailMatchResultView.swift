//
//  FBLeagueDetailMatchResultView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import Charts

/// 联赛详情 赛果分布
class FBLeagueDetailMatchResultView: UIView {

    private var stackView: UIStackView = {
        let v = UIStackView()
        v.alignment = .top
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()
    private var winItemView: FBLeagueDetailMatchResultItemView!
    private var drawItemView: FBLeagueDetailMatchResultItemView!
    private var lostItemView: FBLeagueDetailMatchResultItemView!

    override func awakeFromNib() {
        super.awakeFromNib()

        for (index, text) in ["胜", "平", "负"].enumerated() {
            let v = R.nib.fbLeagueDetailMatchResultItemView.firstView(owner: nil)!
            v.resultTextLabel.text = text
            v.percentLabel.text = "0%"
            v.matchCountLabel.text = "0场"
            v.pieChartView.data = createPieChartData(1)
            
            stackView.addArrangedSubview(v)
            switch index {
            case 0: winItemView = v
            case 1: drawItemView = v
            case 2: lostItemView = v
            default: break
            }
        }

        addSubview(stackView)
        stackView.snp.makeConstraints {
            make in
            make.edges.equalTo(self)
        }
    }

    func configView(statistics: FBLeagueDetailModel.MatchStatistics) {
        let over = statistics.over
        guard over > 0 else {
            return
        }
        winItemView.matchCountLabel.text = "\(statistics.win)场"
        drawItemView.matchCountLabel.text = "\(statistics.draw)场"
        lostItemView.matchCountLabel.text = "\(statistics.lost)场"
        
        winItemView.percentLabel.text = (statistics.winPercent * 100).decimal(0) + "%"
        drawItemView.percentLabel.text = (statistics.drawPercent * 100).decimal(0) + "%"
        lostItemView.percentLabel.text = (statistics.lostPercent * 100).decimal(0) + "%"
        
        winItemView.pieChartView.data = createPieChartData(1 - statistics.winPercent, statistics.winPercent)
        drawItemView.pieChartView.data = createPieChartData(1 - statistics.drawPercent, statistics.drawPercent)
        lostItemView.pieChartView.data = createPieChartData(1 - statistics.lostPercent, statistics.lostPercent)
        
    }
    
    private func createPieChartData(_ values: Double...) -> PieChartData {
        let entries = values.map { PieChartDataEntry(value: $0) }
        let set = PieChartDataSet(values: entries, label: nil)
        set.colors = [TSColor.gray.gamutCCCCCC, TSColor.matchResult.win]
        set.selectionShift = 0
        set.drawValuesEnabled = false
        let data = PieChartData(dataSet: set)
        return data
    }

}
