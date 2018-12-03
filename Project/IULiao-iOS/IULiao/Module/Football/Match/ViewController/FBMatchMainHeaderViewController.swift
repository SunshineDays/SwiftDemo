//
//  FBMatchHeaderViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 足球赛事详情头部
class FBMatchMainHeaderViewController: UIViewController, FBMatchViewControllerProtocol {
    
    static let maxHeight: CGFloat = 150
    static let minHeight: CGFloat = 44
    
    var matchId: Int!
    var lottery: Lottery?

    var maximizeView = R.nib.fbMatchHeaderMaximizeView.firstView(owner: nil)!
    var minimizeView = R.nib.fbMatchHeaderMinimizeView.firstView(owner: nil)!

    private var matchInfoHandler = FBMatchInfoHandler()
    private var matchInfo = FBMatchModel(json: JSON.null) {
        didSet {
            configView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }
}


// MARK:- method
extension FBMatchMainHeaderViewController {

    private func initView() {
        if let lottery = lottery {
            maximizeView.liveAnimationBtn.isHidden = !(lottery == .jingcai || lottery == .sfc)
        } else {
            maximizeView.liveAnimationBtn.isHidden = true
        }
        /// 导航页隐藏返回按钮
        minimizeView.backBtn.isHidden = self.navigationController?.viewControllers.count ?? 0 < 1
        minimizeView.backBtnClickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        minimizeView.homeTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: self.matchInfo.homeTid)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        minimizeView.awayTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: self.matchInfo.awayTid)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
        maximizeView.homeTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: self.matchInfo.homeTid)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        maximizeView.awayTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: self.matchInfo.awayTid)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        maximizeView.liveAnimationBtnClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbLiveAnimationViewController(matchId: self.matchId)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }

    private func initNetwork() {
        matchInfoHandler.getMatchInfo(
                matchId: matchId,
                lottery: lottery,
                success: {
                    [weak self] matchInfo in
                    self?.matchInfo = matchInfo
                },
                failed: {
                    error in
                })
    }

    private func configView() {
        minimizeView.configView(matchInfo: matchInfo)
        maximizeView.configView(matchInfo: matchInfo)
    }

}

