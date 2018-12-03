//
//  FBTeamMainViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/31.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队view controller 需要实现的协议
protocol FBTeamViewControllerProtocol {
    
    /// 球队id
    var teamId: Int! { get set }
}

/// 球队的主页
class FBTeamMainViewController: BaseViewController {
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var scrollView: BaseScrollView!
    
    /// 球队id
    var teamId: Int! = 444

    private let teamTabs: [TeamType] = [.detail, .schedule, .lineup, .news]
    private var viewControllersCaches = [TeamType: UIViewController & FBTeamViewControllerProtocol]()
    
    private let teamHandler = FBTeamHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: CGFloat(teamTabs.count) * scrollView.width, height: scrollView.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 预先加载两页
        loadViewController(teamType: .detail)
        loadViewController(teamType: .schedule)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    enum TeamType {
        case detail, schedule, lineup, news
        
        var title: String {
            switch self {
            case .detail: return "球队详情"
            case .schedule: return "赛程"
            case .lineup: return "阵容"
            case .news: return "新闻"
            }
        }
    }
}

// MARK:- method
extension FBTeamMainViewController {
    
    private func initView() {
        
        scrollView.delaysContentTouches = false
        scrollView.delegate = self
        scrollView.bounces = false
        
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)
        ]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: baseNavigationBarTintColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.backgroundColor = UIColor(hex: 0xE6E6E6)
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorHeight = 1
        segmentedControl.selectionStyle = .fullWidthStripe
        
        segmentedControl.sectionTitles = teamTabs.map { $0.title }
        segmentedControl.indexChangeBlock = {
            [unowned self] index in
            let x = self.scrollView.width * CGFloat(index)
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
    }

    /// 设置ctrl
    private func loadViewController(teamType: TeamType) {
        guard let index = teamTabs.index(of: teamType) else {
            return
        }
        loadViewController(index: index)
    }

    /// 设置ctrl
    private func loadViewController(index: Int) {
        guard let teamType = teamTabs[safe: index] else {
            return
        }
        var ctrl = viewControllersCaches[teamType]
        if ctrl != nil {
            return
        }

        switch teamType {
        case .detail:
            ctrl = R.storyboard.fbTeamDetail.fbTeamDetailViewController()!
        case .lineup:
            ctrl = R.storyboard.fbTeamLineup.fbTeamLinupViewController()!
        case .news:
            ctrl = FBTeamNewsViewController()
        case .schedule:
            ctrl = R.storyboard.fbTeamSchedule.fbTeamScheduleViewController()!
        }
        ctrl!.teamId = teamId

        let x = CGFloat(index) * scrollView.width
        ctrl!.view.frame = CGRect(x: x, y: 0, width: scrollView.width, height: scrollView.height)
        addChildViewController(ctrl!)
        scrollView.addSubview(ctrl!.view)
        viewControllersCaches[teamType] = ctrl!
    }
}

// MARK:- UICollectionViewDelegate
extension FBTeamMainViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 这里加载当前与下一个
        loadViewController(index: index)
        loadViewController(index: index + 1)
        segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        loadViewController(index: index)
        loadViewController(index: index + 1)
    }
}


