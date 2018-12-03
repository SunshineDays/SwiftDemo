//
//  FBMatchWarViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事分析 指数
class FBMatchOddsViewController: UIViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    /// 在没有UIScrollView时用来实现TSNestInnerScrollViewProtocol的
    private lazy var scrollView = UIScrollView()
    private var segmentView: FBMatchSubSegmentView!
    var matchId: Int!
    var lottery: Lottery?
    var scroller: UIScrollView {
        return viewControllersCaches[selectedTab]?.scroller ?? scrollView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private var viewControllersCaches = [OddsType: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol]()
    private var oddsTabs: [OddsType] = [.europe, .asia, .bigSmall, .betfair, .score]
    var selectedTab = OddsType.europe
    
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
    
    enum OddsType {
        case europe, asia, bigSmall, betfair, score
        
        var title: String {
            switch self {
            case .europe:
                return "欧赔"
            case .asia:
                return "亚盘"
            case .bigSmall:
                return "大小"
            case .betfair:
                return "必发"
            case .score:
                return "波胆"
            }
        }
    }
}

extension FBMatchOddsViewController {
    private func initView() {
        view.clipsToBounds = true
        
        segmentView = FBMatchSubSegmentView()
        segmentView.sectionTitles = oddsTabs.map { $0.title  }
        segmentView.selectedIndex = oddsTabs.index(of: selectedTab) ?? 0
        segmentView.indexChangeBlock = {
            [weak self] btn, index in
            if let oddsType = self?.oddsTabs[safe: index] {
                self?.loadViewController(oddsType: oddsType)
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
        
        loadViewController(oddsType: selectedTab)
    }
    
    private func loadViewController(oddsType: OddsType) {
        selectedTab = oddsType
        
        // 加载当前视图
        let ctrl = getViewController(by: oddsType)
        view.bringSubview(toFront: ctrl.view)
        // segmentView的阴影在最上层
        view.bringSubview(toFront: segmentView)
        
        // 预加载下一个视图
        if let index = oddsTabs.index(of: oddsType), let nextType = oddsTabs[safe: index + 1] {
            getViewController(by: nextType)
        }
    }
    
    @discardableResult
    private func getViewController(by oddsType: OddsType) -> UIViewController {
        var ctrl = viewControllersCaches[oddsType]
        if ctrl != nil {
            return ctrl!
        }
        
        switch oddsType {
        case .europe:
            ctrl = R.storyboard.fbMatchOddsEurope.fbMatchOddsEuropeListViewController()!
        case .asia:
            ctrl = FBMatchOddsAsiaListViewController()
        case .bigSmall:
            ctrl = FBMatchOddsBigSmallListViewController()
        case .score:
            ctrl = FBMatchOddsScoreListViewController()
        case .betfair:
            ctrl = R.storyboard.fbMatchOddsBetfair.fbMatchOddsBetfairViewController()!
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
        viewControllersCaches[oddsType] = ctrl!
        return ctrl!
    }
}

