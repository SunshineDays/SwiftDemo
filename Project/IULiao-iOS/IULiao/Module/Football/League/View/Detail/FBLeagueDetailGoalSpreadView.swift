//
//  FBLeagueDetailGoalSpreadView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/19.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 进球分布
class FBLeagueDetailGoalSpreadView: UIView {

    private var stackView: UIStackView = {
        let v = UIStackView()
        v.alignment = .bottom
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()
    private var goalSpreadItemViews = [FBLeagueDetailGoalSpreadItemView]()

    override func awakeFromNib() {
        super.awakeFromNib()

        for time in ["15", "30", "45", "60", "75", "90"] {
            let v = R.nib.fbLeagueDetailGoalSpreadItemView.firstView(owner: nil)!
            
            v.timeLabel.text = time
            v.percentLabel.text = "0%"
            v.heightConstraint.constant = 1
            stackView.addArrangedSubview(v)
            goalSpreadItemViews.append(v)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            make in
            make.edges.equalTo(self)
        }
    }
    
    func configView(goalSpreads: [FBLeagueDetailModel.GoalSpread]) {
        let maxPercent = goalSpreads.map({ $0.percent }).max() ?? 0
        guard maxPercent > 0 else {
            return
        }
        for (index, item) in goalSpreads.enumerated() {
            if index >= goalSpreadItemViews.count {
                break
            }
            let v = goalSpreadItemViews[index]
            v.timeLabel.text = item.time
            v.percentLabel.text = (item.percent * 100).decimal(0) + "%"
            v.heightConstraint.constant = CGFloat(30 * item.percent / maxPercent)
        }
    }
}
