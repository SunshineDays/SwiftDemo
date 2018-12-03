//
//  FBLeagueRankScoreViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

/// 联赛 排行榜 积分榜
class FBLeagueRankScoreViewController: BaseViewController, FBLeagueViewControllerProtocol {
    
    /// 联赛id
    var leagueId: Int!
    
    /// 赛季id
    var seasonId: Int? {
        didSet {
            if leagueId != nil && leagueId != nil && seasonId != nil && seasonId != oldValue  {
                getData()
            }
        }
    }

    private var viewControllersCaches = [FBLeagueRankScoreDataModel.RankScoreType: UIViewController]()
    private let rankHandler = FBLeagueRankHandler()
    private var rankScoreData = FBLeagueRankScoreDataModel(json: JSON.null) {
        didSet {
            let type = rankScoreData.type
            var ctrl = viewControllersCaches[type]
            if ctrl == nil {
                switch type {
                case .normal:
                    ctrl = R.storyboard.fbLeagueRank.fbLeagueRankScoreNormalViewController()!
                case .group:
                    ctrl = R.storyboard.fbLeagueRank.fbLeagueRankScoreGroupViewController()!
                }
                addChildViewController(ctrl!)
                view.addSubview(ctrl!.view)

                ctrl!.view.snp.makeConstraints {
                    make in
                    make.edges.equalToSuperview()
                }
                viewControllersCaches[type] = ctrl!
            }
            if let ctrl = ctrl as? FBLeagueRankScoreNormalViewController {
                ctrl.rankScoreData = rankScoreData
            } else if let ctrl = ctrl as? FBLeagueRankScoreGroupViewController {
                ctrl.groups = rankScoreData.groups
            }
            ctrl!.view.isHidden = false
            view.bringSubview(toFront: ctrl!.view)
            view.bringSubview(toFront: hud)
        }
    }
    
    private lazy var retryBtn = TSEmptyDataViewHelper.createRetryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }

}

extension FBLeagueRankScoreViewController {
    
    private func initView() {
        view.addSubview(retryBtn)
        retryBtn.snp.makeConstraints {
            make in
            make.centerX.edges.equalToSuperview()
            make.centerY.edges.equalToSuperview()
            make.width.edges.equalToSuperview()
        }
        retryBtn.addTarget(self, action: #selector(retryData), for: .touchUpInside)
    }
    
    @objc private func retryData() {
        getData()
    }
    
    private func initNetwork() {
        getData()
    }
    
    private func getData() {
        retryBtn.isHidden = true
        hud.show(animated: true)
        rankHandler.getRankScore(
            leagueId: leagueId,
            seasonId: seasonId,
            success: {
                rankScoreData in
                self.rankScoreData = rankScoreData
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.hud.hide(animated: true)
                self.retryBtn.isHidden = false
                self.view.bringSubview(toFront: self.retryBtn)
                self.viewControllersCaches.values.forEach { $0.view.isHidden = true }
        })
    }
    
}
