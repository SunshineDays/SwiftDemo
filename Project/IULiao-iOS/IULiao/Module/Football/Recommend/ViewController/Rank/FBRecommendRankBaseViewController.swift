//
//  FBRecommendRankBaseViewController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/28.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

enum RankTitleType: String {
    case football = "单场推荐"
    case jingcai = "竞彩推荐"
}

/// 推荐 排行榜父控制器
class FBRecommendRankBaseViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.titleView = segmentedControl
        
        // 单场推荐
        let recommendVC = R.storyboard.fbRecommendRank.fbRecommendRankController()!
        recommendVC.initWith(oddsType: .football, regionType: .day7, rankType: footballRankType!)
        self.addChildViewController(recommendVC)
        scrollView.addSubview(recommendVC.view)
        
        // 竞彩推荐
        let jingcaiVC = R.storyboard.fbRecommendRank.fbRecommendRankController()!
        jingcaiVC.initWith(oddsType: .serial, regionType: .day7, rankType: jingcaiRankType!)
        self.addChildViewController(jingcaiVC)
        jingcaiVC.view.x = TSScreen.currentWidth
        scrollView.addSubview(jingcaiVC.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 排行榜
    ///
    /// - Parameters:
    ///   - title: 显示类型（竞彩或足球）
    ///   - footballRankType: 足球选中类型
    ///   - jingcaiRankType: 竞彩选中类型
    public func initWith(title: RankTitleType = .football, footballRankType: RecommendRankType = .payoff, jingcaiRankType: RecommendRankType = .hitPercent) {
        selectedTitle = title
        self.footballRankType = footballRankType
        self.jingcaiRankType = jingcaiRankType
    }
    
    private var selectedTitle: RankTitleType?
    /// 榜单类型
    private var footballRankType: RecommendRankType?
    /// 榜单类型
    private var jingcaiRankType: RecommendRankType?
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["单场推荐", "竞彩推荐"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = selectedTitle == .football ? 0 : 1
        scrollView.setContentOffset(CGPoint.init(x: TSScreen.currentWidth * CGFloat(segmentedControl.selectedSegmentIndex), y: 0), animated: true)
        segmentedControl.addTarget(self, action: #selector(segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight))
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        // 在UIScrollView上响应右滑返回事件
        scrollView.panGestureRecognizer.require(toFail: (navigationController?.interactivePopGestureRecognizer)!)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: TSScreen.currentWidth * 2, height: TSScreen.currentHeight - TSScreen.tabBarHeight(self) - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight)
        self.view.addSubview(scrollView)
        return scrollView
    }()
}

// MARK: - UIScrollViewDelegate
extension FBRecommendRankBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= TSScreen.currentWidth / 2 ? 1 : 0
    }
    
}

// MARK: - Action
extension FBRecommendRankBaseViewController {
    @objc private func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: TSScreen.currentWidth * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
}
