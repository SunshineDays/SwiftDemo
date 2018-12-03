//
//  FBMatchWarViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事分析 战绩
class FBMatchWarViewController: UIViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    /// 在没有UIScrollView时用来实现TSNestInnerScrollViewProtocol的
    private lazy var scrollView = UIScrollView()
    private var segmentView: FBMatchSubSegmentView!
    var matchId: Int!
    var lottery: Lottery?
    var scroller: UIScrollView {
        return viewControllersCaches[selectedTab]?.scroller ?? scrollView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private var viewControllersCaches = [WarType: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol]()
    private var warTabs: [WarType] = [.recent, .versus, .future, .rankScore, .sameHandicap, .scoreDistribute]
    var selectedTab = WarType.recent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        viewControllersCaches.filter({ $0.key != selectedTab }).forEach {
            body in
            viewControllersCaches[body.key]?.removeFromParentViewController()
            viewControllersCaches.removeValue(forKey: body.key)
        }
    }
    
    enum WarType {
        case recent, versus, future, sameHandicap, rankScore, scoreDistribute
        
        var title: String {
            switch self {
            case .recent:
                return "状态"
            case .versus:
                return "交锋"
            case .future:
                return "未来"
            case .sameHandicap:
                return "同盘"
            case .rankScore:
                return "积分"
            case .scoreDistribute:
                return "得失"
            }
        }
    }
}

extension FBMatchWarViewController {
    private func initView() {
        view.clipsToBounds = true
        segmentView = FBMatchSubSegmentView()
        segmentView.sectionTitles = warTabs.map { $0.title  }
        segmentView.selectedIndex = warTabs.index(of: selectedTab) ?? 0
        segmentView.indexChangeBlock = {
            [weak self] btn, index in
            if let warType = self?.warTabs[safe: index] {
                self?.loadViewController(warType: warType)
            }
        }
        
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints {
            make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        loadViewController(warType: selectedTab)
    }
    
    private func loadViewController(warType: WarType) {
        selectedTab = warType

        // 加载当前视图
        let ctrl = getViewController(by: warType)
        view.bringSubview(toFront: ctrl.view)
        // segmentView的阴影在最上层
        view.bringSubview(toFront: segmentView)
        
        // 预加载下一个视图
        if let index = warTabs.index(of: warType), let nextType = warTabs[safe: index + 1] {
            getViewController(by: nextType)
        }
    }
    
    @discardableResult
    private func getViewController(by warType: WarType) -> UIViewController {
        var ctrl = viewControllersCaches[warType]
        if ctrl != nil {
            return ctrl!
        }
        
        switch warType {
        case .recent:
            ctrl = FBMatchWarRecentViewController()
        case .versus:
            ctrl = FBMatchWarVersusViewController()
        case .future:
            ctrl = FBMatchWarFutureViewController()
        case .rankScore:
            ctrl = FBMatchWarRankScoreViewController()
        case .sameHandicap:
            ctrl = FBMatchWarSameHandicapViewController()
        case .scoreDistribute:
            ctrl = R.storyboard.fbMatchWarScoreDistribute.fbMatchWarScoreDistributeViewController()!
        }
        
        ctrl!.matchId = matchId
        ctrl!.lottery = lottery
        
        addChildViewController(ctrl!)
        view.insertSubview(ctrl!.view, at: 0)
        ctrl!.view.snp.makeConstraints {
            make in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        ctrl!.didScroll = {
            [weak self] scrollView in
            self?.didScroll?(scrollView)
        }
        viewControllersCaches[warType] = ctrl!
        return ctrl!
    }
}

