//
//  FBLeagueDetailViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 联赛详情
class FBLeagueDetailViewController: TSEmptyViewController, FBLeagueViewControllerProtocol {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var leagueDetailInfoView: FBLeagueDetailInfoView!
    @IBOutlet weak var leagueDetailRoundView: FBLeagueDetailRoundView!
    @IBOutlet weak var leagueDetailMatchView: FBLeagueDetailMatchView!
    @IBOutlet weak var leagueDetailGoalSpreadView: FBLeagueDetailGoalSpreadView!
    @IBOutlet weak var leagueDetailMatchResultView: FBLeagueDetailMatchResultView!
    @IBOutlet weak var leagueDetailGoalAverageView: FBLeagueDetailGoalAverageView!
    
    @IBOutlet weak var roundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchViewTopConstraint: NSLayoutConstraint!

    /// 联赛id
    var leagueId: Int!

    /// 赛季id
    var seasonId: Int? {
        didSet {
            if contentView != nil && seasonId != nil && seasonId != oldValue {
                getData()
            }
        }
    }
    
    let leagueDetailHandler = FBLeagueDetailHandler()
    /// 请求是否失败
    override var isRequestFailed: Bool {
        didSet {
            contentView.isHidden = isRequestFailed
            scrollView.reloadEmptyDataSet()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNetwork()
    }
    
    override func getData() {
        hud.show(animated: true)
        leagueDetailHandler.getDetail(
            leagueId: leagueId,
            seasonId: seasonId,
            success: {
                detail in
                self.setupDetailData(detail: detail)
                self.isRequestFailed = false
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.hud.hide(animated: true)
        }
        )
    }
    
}

extension FBLeagueDetailViewController {

    private func initView() {
        // 目前没有推荐的赛事 先隐藏
        leagueDetailMatchView.isHidden = true
        matchViewHeightConstraint.constant = 0
        matchViewTopConstraint.constant = 0

        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
    }

    private func initNetwork() {
        getData()
    }

    private func setupDetailData(detail: FBLeagueDetailModel) {
        leagueDetailInfoView.configView(leagueDetail: detail)
        if let allRound = detail.seasonInfo.allRound, allRound > 0 {
            leagueDetailRoundView.isHidden = false
            roundViewHeightConstraint.constant = 30
            leagueDetailRoundView.configView(season: detail.seasonInfo)
        } else {
            leagueDetailRoundView.isHidden = true
            roundViewHeightConstraint.constant = 0
        }
        leagueDetailGoalSpreadView.configView(goalSpreads: detail.goalSpreads)
        leagueDetailMatchResultView.configView(statistics: detail.matchStatistics)
        leagueDetailGoalAverageView.configView(statistics: detail.matchStatistics)
    }
}

extension FBLeagueDetailViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -32
    }
}
