//
//  FBMatchWarRankScoreHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 积分榜 头部
class FBMatchWarRankScoreHeaderView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBOutlet weak var matchResultView: UIView!
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    
    @IBOutlet weak var displayModeBtn: UIButton!
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticsLabelWidthConstraint: NSLayoutConstraint!
    
    var teamTypeClickBlock: ((_ teamType: TeamType) -> Void)?
    var displayModeClickBlock: ((_ button: UIButton, _ displayMode: FBLeagueRankScoreNormalViewController.DisplayModeType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            rankLabelLeftConstraint.constant = 4
            statisticsLabelWidthConstraint.constant = 60
        } else if TSScreen.currentWidth == TSScreen.iPhone6Width {
            rankLabelLeftConstraint.constant = 8
            statisticsLabelWidthConstraint.constant = 72
        } else if TSScreen.currentWidth == TSScreen.iPhone6PlusWidth {
            rankLabelLeftConstraint.constant = 12
            statisticsLabelWidthConstraint.constant = 84
        }
        
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
        segmentedControl.sectionTitles = ["总", "主", "客"]
        segmentedControl.indexChangeBlock = {
            [weak self] index in
            if index == 1 {
                self?.teamTypeClickBlock?(.home)
            } else if index == 2 {
                self?.teamTypeClickBlock?(.away)
            } else {
                self?.teamTypeClickBlock?(.none)
            }
            
        }
    }
    
    func configView(title: String, scoreType: FBLeagueRankScoreDataModel.RankScoreType, teamType: TeamType, displayMode: FBLeagueRankScoreNormalViewController.DisplayModeType = .statistics) {

        titleLabel.text = "\(title)积分榜"
        if scoreType == .group {
            statisticsView.isHidden = false
            matchResultView.isHidden = true
        } else {
            statisticsView.isHidden = displayMode == .matchResult
            matchResultView.isHidden = displayMode == .statistics
        }
        displayModeBtn.isSelected = displayMode == .matchResult
        
        switch teamType {
        case .home:
            segmentedControl.selectedSegmentIndex = 1
        case .away:
            segmentedControl.selectedSegmentIndex = 2
        default:
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func displayModeClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        displayModeClickBlock?(sender, sender.isSelected ? .matchResult : .statistics)
    }
    

}
