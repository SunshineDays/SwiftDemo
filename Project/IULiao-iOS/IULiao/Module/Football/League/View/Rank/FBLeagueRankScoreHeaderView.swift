//
//  FBLeagueRankScoreHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 联赛 排行榜 积分
class FBLeagueRankScoreHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBOutlet weak var matchResultView: UIView!
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticsLabelWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {

        contentView = R.nib.fbLeagueRankScoreHeaderView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
        setupView()
    }
    
    private func setupView() {
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
    }
    
    func configView(groupName: String? = nil, displayMode: FBLeagueRankScoreNormalViewController.DisplayModeType = .statistics) {
        if let groupName = groupName {
            rankLabel.isHidden = false
            rankLabel.text = "\(groupName)组"
        } else {
            rankLabel.isHidden = true
        }
        
        statisticsView.isHidden = displayMode == .matchResult
        matchResultView.isHidden = displayMode == .statistics
    }
}
