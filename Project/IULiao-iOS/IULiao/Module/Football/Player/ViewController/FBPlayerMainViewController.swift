//
//  FBPlayerMainViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员view controller 需要实现的协议
protocol FBPlayerViewControllerProtocol {

    /// 球员id
    var playerId: Int! { get set }
    
    var contentScrollView: UIScrollView { get }
}

/// 球员
class FBPlayerMainViewController: UIViewController {

    var playerId: Int! = 68275

    private var segmentedControl = HMSegmentedControl()
    private var scrollView = BaseScrollView()
    private var headerCtrl = R.storyboard.fbPlayerHeader.fbPlayerHeaderViewController()!

    private var isAnimating = false
    private var lastEndOffsetY: CGFloat = 0
    private var lastScrollingOffsetY: CGFloat = 0

    private let playerTabs: [PlayerType] = [.detail, .statistic, .matchList]
    private var viewControllersCaches = [PlayerType: UIViewController & FBPlayerViewControllerProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: CGFloat(playerTabs.count) * scrollView.width, height: scrollView.height)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 预先加载两页
        loadViewController(playerType: .detail)
        loadViewController(playerType: .statistic)
    }


    enum PlayerType {
        case detail, statistic, matchList

        var title: String {
            switch self {
            case .detail: return "球员详情"
            case .statistic: return "技术统计"
            case .matchList: return "比赛表现"
            }
        }
    }

    deinit {
        clearCache()
    }
}

extension FBPlayerMainViewController {

    private func initView() {

        view.backgroundColor = UIColor.white
        scrollView.delaysContentTouches = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.bounces = false
//        scrollView.isMultipleTouchEnabled = true
//        scrollView.isExclusiveTouch = true
//        scrollView.canCancelContentTouches = true
//        scrollView.isUserInteractionEnabled = false

        segmentedControl.borderType = HMSegmentedControlBorderType.top
        segmentedControl.layer.borderWidth = 1 / UIScreen.main.scale
//        segmentedControl.borderWidth = 1 / UIScreen.main.scale
        segmentedControl.layer.borderColor = UIColor(hex: 0x666666).cgColor
        segmentedControl.backgroundColor = UIColor(hex: 0x191710)
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0xcccccc),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
        ]
        segmentedControl.segmentWidthStyle = .fixed
        segmentedControl.selectionIndicatorColor = TSColor.logo
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorColor = TSColor.logo
        segmentedControl.selectionIndicatorHeight = 3

        segmentedControl.sectionTitles = playerTabs.map {
            $0.title
        }
        segmentedControl.indexChangeBlock = {
            [unowned self] index in
            let x = self.scrollView.width * CGFloat(index)
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }

        addChildViewController(headerCtrl)
        view.addSubview(headerCtrl.view)
        view.addSubview(segmentedControl)
        view.addSubview(scrollView)
        
        headerCtrl.view.snp.makeConstraints {
            make in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(154)
        }
        segmentedControl.snp.makeConstraints {
            make in
            make.top.equalTo(headerCtrl.view.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(36)
        }
        scrollView.snp.makeConstraints {
            make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }


    /// 设置ctrl
    private func loadViewController(playerType: PlayerType) {
        guard let index = playerTabs.index(of: playerType) else {
            return
        }
        loadViewController(index: index)
    }

    /// 设置ctrl
    private func loadViewController(index: Int) {
        guard let playerType = playerTabs[safe: index] else {
            return
        }
        var ctrl = viewControllersCaches[playerType]
        if ctrl != nil {
            return
        }

        switch playerType {
        case .detail:
            ctrl = R.storyboard.fbPlayerDetail.fbPlayerDetailViewController()!
            (ctrl as! FBPlayerDetailViewController).delegate = self
        case .matchList:
            ctrl = FBPlayerMatchListViewController()
        case .statistic:
            ctrl = R.storyboard.fbPlayerStatistic.fbPlayerStatisticViewController()!
        }
        ctrl!.playerId = playerId
        
        let x = CGFloat(index) * scrollView.width
        ctrl!.view.frame = CGRect(x: x, y: 0, width: scrollView.width, height: scrollView.height)
        addChildViewController(ctrl!)
        scrollView.addSubview(ctrl!.view)
        
        viewControllersCaches[playerType] = ctrl!
    }

    /// 头部滚动到边界
    private func headerViewAnimatedToBoundary( direction: UISwipeGestureRecognizerDirection) {

        var height: CGFloat = 0
        if direction == .down {
            height = headerCtrl.maxHeight
        } else {
            height = headerCtrl.minHeight
        }

        isAnimating = true
        headerCtrl.view.snp.updateConstraints {
            (make) in
            make.height.equalTo(height)
        }
        UIView.animate(withDuration: 0.3,
                       animations: {
                           self.headerCtrl.viewHeightChangeTo(height: height)
                           self.headerCtrl.view.layoutIfNeeded()
                           self.view.layoutIfNeeded()
                       },
                       completion: {
                           isSuccess in
                           self.isAnimating = false
                       })
        
        let tab = playerTabs[segmentedControl.selectedSegmentIndex]
        lastEndOffsetY = viewControllersCaches[tab]?.contentScrollView.contentOffset.y ?? lastEndOffsetY
        lastScrollingOffsetY = lastEndOffsetY
    }

    /// 滚动偏移的y值
    private func headerView(offsetY: CGFloat) {
        let newHeight = headerCtrl.view.height + offsetY

        guard newHeight <= headerCtrl.maxHeight && newHeight >= headerCtrl.minHeight else {
            return
        }

        headerCtrl.viewHeightChangeTo(height: newHeight)
        headerCtrl.view.snp.updateConstraints {
            (make) in
            make.height.equalTo(newHeight)
        }
    }

    private func clearCache() {
        viewControllersCaches.removeAll()
    }
}

extension FBPlayerMainViewController: FBPlayerDetailViewControllerDelegate {
    
    func playerDetailViewController(_ ctrl: FBPlayerDetailViewController, didFetchPlayerDetail detail: FBPlayerDetailModel) {
        headerCtrl.configView(player: detail.playerInfo)
    }
    
}

extension FBPlayerMainViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            return
        }
        guard !isAnimating else {
            return
        }
        guard headerCtrl.view.height > headerCtrl.minHeight else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        guard offsetY >= 0 else {
            return
        }
 
        headerView(offsetY: lastScrollingOffsetY - offsetY)
        lastScrollingOffsetY = offsetY
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == self.scrollView {
            return
        }
        guard !isAnimating else {
            return
        }
        guard headerCtrl.view.height > headerCtrl.minHeight else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        guard offsetY >= 0 else {
            return
        }
        
        let direction = offsetY >= lastEndOffsetY ? UISwipeGestureRecognizerDirection.up : .down
        headerViewAnimatedToBoundary(direction: direction)
        lastEndOffsetY = offsetY
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let index = Int(scrollView.contentOffset.x / scrollView.width)
            // 这里加载当前与下一个
            loadViewController(index: index)
            loadViewController(index: index + 1)
            segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let index = Int(scrollView.contentOffset.x / scrollView.width)
            loadViewController(index: index)
            loadViewController(index: index + 1)
        }
    }
}
