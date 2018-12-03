//
//  FBMatchAnalyzeViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事分析 赛况
class FBMatchAnalyzeViewController: UIViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    /// 在没有UIScrollView时用来实现TSNestInnerScrollViewProtocol的
    private lazy var scrollView = UIScrollView()
    private var segmentView: FBMatchSubSegmentView!
    var matchId: Int!
    var lottery: Lottery?
    var scroller: UIScrollView {
        return viewControllersCaches[selectedTab]?.scroller ?? scrollView
    }
    var didScroll: ((UIScrollView) -> Void)?

    private var viewControllersCaches = [AnalyzeType: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol]()
    private var analyzeTabs: [AnalyzeType] = [.lineup, .event, .statistics]
    var selectedTab = AnalyzeType.lineup

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

    enum AnalyzeType {
        case event, statistics, lineup
        
        var title: String {
            switch self {
            case .event:
                return "进球事件"
            case .statistics:
                return "比赛数据"
            case .lineup:
                return "首发阵容"
            }
        }
    }
}

extension FBMatchAnalyzeViewController {
    private func initView() {
        view.clipsToBounds = true
        
        segmentView = FBMatchSubSegmentView()
        segmentView.sectionTitles = analyzeTabs.map { $0.title  }
        segmentView.selectedIndex = analyzeTabs.index(of: selectedTab) ?? 0
        segmentView.indexChangeBlock = {
            [weak self] btn, index in
            if let analyzeType = self?.analyzeTabs[safe: index] {
                self?.loadViewController(analyzeType: analyzeType)
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

        loadViewController(analyzeType: selectedTab)
    }

    private func loadViewController(analyzeType: AnalyzeType) {
        selectedTab = analyzeType
        
        // 加载当前视图
        let ctrl = getViewController(by: analyzeType)
        view.bringSubview(toFront: ctrl.view)
        // segmentView的阴影在最上层
        view.bringSubview(toFront: segmentView)
        
        // 预加载下一个视图
        if let index = analyzeTabs.index(of: analyzeType), let nextType = analyzeTabs[safe: index + 1] {
            getViewController(by: nextType)
        }
    }
    
    @discardableResult
    private func getViewController(by analyzeType: AnalyzeType) -> UIViewController {
        var ctrl = viewControllersCaches[analyzeType]
        if ctrl != nil {
            return ctrl!
        }
        
        switch analyzeType {
        case .statistics:
            ctrl = R.storyboard.fbMatchAnalyzeStatistics.fbMatchAnalyzeStatisticsViewController()!
        case .event:
            ctrl = R.storyboard.fbMatchAnalyzeEvent.fbMatchAnalyzeEventViewController()!
        case .lineup:
            ctrl = R.storyboard.fbMatchAnalyzeLineup.fbMatchAnalyzeLineupViewController()!
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
        viewControllersCaches[analyzeType] = ctrl!
        return ctrl!
    }
}
