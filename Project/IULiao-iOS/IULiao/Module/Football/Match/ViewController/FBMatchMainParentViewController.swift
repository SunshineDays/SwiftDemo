//
//  FBMatchMainParentViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 公用父类
class FBMatchMainParentViewController: BaseViewController, FBMatchViewControllerProtocol {
    
    /// 头部高度
    private let headerViewHeight: CGFloat = FBMatchMainHeaderViewController.maxHeight - FBMatchMainHeaderViewController.minHeight
    /// 导航高度
    private let segmentedControlHeight: CGFloat = 36
    
    /// 头部
    private var headerView: UIView!
    /// 固定视图
    private var fixedView: UIView!
    /// 导航
    private var segmentedControl: HMSegmentedControl!
    
    /// 主tableView
    private var tableView: TSNestOuterTableView!
    /// 左右滚动
    private var scrollView: BaseScrollView!
    
    private var outerCanScroll = false
    private var innerCanScroll = false
    private var isCanMoveTableView = false
    private var isCanMoveTableViewPre = false
    
    private var viewControllersCaches = [Int: UIViewController & TSNestInnerScrollViewProtocol]()
    private var headerCtrl = FBMatchMainHeaderViewController()

    /// 初始选中
    var selectedPage = 0
    var matchId: Int! = 1072677
    var lottery: Lottery?
    var tabTitles = [String]() {
        didSet {
            segmentedControl.sectionTitles = tabTitles
            scrollView.contentSize = CGSize(width: CGFloat(tabTitles.count) * view.width, height: scrollView.height)
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        viewControllersCaches.filter({ $0.key != selectedPage }).forEach {
            body in
            viewControllersCaches[body.key]?.removeFromParentViewController()
            viewControllersCaches.removeValue(forKey: body.key)
        }
    }
    
    func viewController(at page: Int) -> (UIViewController & TSNestInnerScrollViewProtocol)? {
        fatalError("子类必须实现此方法")
    }
}

// MARK:- method
extension FBMatchMainParentViewController {
    
    private func initView() {
        do {
            headerCtrl.matchId = matchId
            headerCtrl.lottery = lottery
            addChildViewController(headerCtrl)
            view.addSubview(headerCtrl.view)
        }
        
        do {
            headerView = UIView()
            headerView.isUserInteractionEnabled = true
            headerView.frame = CGRect(x: 0, y: -headerViewHeight, width: TSScreen.currentWidth, height: headerViewHeight)
            
            let boxView = UIView()
            boxView.addSubview(headerCtrl.maximizeView)
            headerView.addSubview(boxView)
            
            headerCtrl.maximizeView.snp.makeConstraints {
                make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(FBMatchMainHeaderViewController.maxHeight)
            }
            boxView.snp.makeConstraints {
                make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(300)
            }
        }
        
        do {
            segmentedControl = HMSegmentedControl()
            segmentedControl.borderType = HMSegmentedControlBorderType.top
            segmentedControl.layer.borderWidth = 1 / UIScreen.main.scale
            segmentedControl.layer.borderColor = UIColor(hex: 0x666666).cgColor
            segmentedControl.backgroundColor = UIColor(hex: 0x191710)
            segmentedControl.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor(hex: 0xcccccc),
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
            ]
            segmentedControl.selectedTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
            ]
            
            segmentedControl.selectionIndicatorColor = TSColor.logo
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.selectionStyle = .fullWidthStripe
            segmentedControl.segmentWidthStyle = .fixed
            segmentedControl.selectionIndicatorColor = TSColor.logo
            segmentedControl.selectionIndicatorHeight = 3
            segmentedControl.indexChangeBlock = {
                [unowned self] index in
                self.scrollTo(page: Int(index), animated: true)
            }
        }
        
        do {
            tableView = TSNestOuterTableView()
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            tableView.scrollsToTop = false
            tableView.clipsToBounds = false
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
            tableView.showsVerticalScrollIndicator = false
            tableView.allowsSelection = false
            
            tableView.addSubview(headerView)
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                make in
                make.top.equalToSuperview().offset(TSScreen.statusBarHeight + FBMatchMainHeaderViewController.minHeight)
                make.left.equalToSuperview()
                make.width.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        do {
            scrollView = BaseScrollView()
            scrollView.scrollsToTop = false
            scrollView.delaysContentTouches = false
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.isDirectionalLockEnabled = true
            scrollView.bounces = false
        }
        
        do {
            fixedView = UIView()
            fixedView.addSubview(headerCtrl.minimizeView)
            headerCtrl.minimizeView.contentView.layer.opacity = 0
            view.addSubview(fixedView)
            
            headerCtrl.minimizeView.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
            }
            fixedView.snp.makeConstraints {
                make in
                make.top.equalToSuperview().offset(TSScreen.statusBarHeight)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(FBMatchMainHeaderViewController.minHeight)
            }
        }
        
    }
    
    /// 设置ctrl
    private func loadViewController(at page: Int) {
        
        var vc = viewControllersCaches[page]
        if vc != nil {
            return
        }
        vc = viewController(at: page)
        guard let ctrl = vc else {
            return
        }

        let x = CGFloat(page) * tableView.width
        ctrl.view.frame = CGRect(x: x, y: 0, width: tableView.width, height: scrollView.height)
        addChildViewController(ctrl)
        scrollView.addSubview(ctrl.view)
        
        ctrl.didScroll = {
            [weak self] scroller in
            guard let me = self else {
                return
            }
            if !me.innerCanScroll {
                scroller.contentOffset = CGPoint.zero
            }
            if scroller.contentOffset.y < 0 {
                me.outerCanScroll = true
                me.innerCanScroll = false
                scroller.contentOffset = CGPoint.zero
            }
        }
        viewControllersCaches[page] = ctrl
    }

    /// 滚动到指定页
    private func scrollTo(page: Int, animated: Bool) {
        if page >= 0 && page < tabTitles.count {
            selectedPage = page
            let x = scrollView.width * CGFloat(page)
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: animated)
            segmentedControl.setSelectedSegmentIndex(UInt(page), animated: animated)
        }
    }
}

// MARK:- UITableViewDelegate
extension FBMatchMainParentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != self.scrollView {
            return
        }
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        for i in 0...index + 1 {
            loadViewController(at: i)
        }
        scrollTo(page: index, animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView != self.scrollView {
            return
        }
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        for i in 0...index + 1 {
            loadViewController(at: i)
        }
        scrollTo(page: index, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView != tableView {
            return
        }
        // 获取滚动视图y值的偏移量
        let offsetY = scrollView.contentOffset.y
        let tableViewOffsetY = tableView.rect(forSection: 0).origin.y
        
        isCanMoveTableViewPre = isCanMoveTableView
        
        if offsetY >= tableViewOffsetY {
            scrollView.contentOffset = CGPoint(x: 0, y: tableViewOffsetY)
            isCanMoveTableView = true
        } else {
            isCanMoveTableView = false
        }
        
        if isCanMoveTableView != isCanMoveTableViewPre {
            if !isCanMoveTableViewPre && isCanMoveTableView {
                innerCanScroll = true
                outerCanScroll = false
            }
            if isCanMoveTableViewPre && !isCanMoveTableView {
                if !outerCanScroll {
                    scrollView.contentOffset = CGPoint(x: 0, y: tableViewOffsetY)
                }
            }
        }
        
        // 处理头部视图
        if offsetY < -headerViewHeight {
            // 改变头部视图frame
            headerView.frame.origin.y = offsetY
            headerView.frame.size.height = -offsetY
            // 处理头部其他组件即可
            headerCtrl.maximizeView.contentView.layer.opacity = 1
            headerCtrl.minimizeView.contentView.layer.opacity = 0
        } else if offsetY < 0 {
            /*
            if !isCanMoveTableView {
                headerCtrl.maximizeView.contentView.layer.opacity = Float(offsetY / -headerViewHeight)
                headerCtrl.minimizeView.contentView.layer.opacity = Float(1 - offsetY / -headerViewHeight)
            }
            */
            if !isCanMoveTableView {
                headerCtrl.maximizeView.contentView.layer.opacity = 1
                headerCtrl.minimizeView.contentView.layer.opacity = 0
            }
        } else {
            headerCtrl.maximizeView.contentView.layer.opacity = 0
            headerCtrl.minimizeView.contentView.layer.opacity = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.addSubview(segmentedControl)
        cell.addSubview(scrollView)
        
        // 这里使用snp会导致子view宽度变为设置的2倍
        // 只有一个标签则不显示
        let height = tabTitles.count > 1 ? segmentedControlHeight : 0
        segmentedControl.frame = CGRect(x: 0, y: 0, width: tableView.width, height: height)
        scrollView.frame = CGRect(x: 0, y: height, width: tableView.width, height: tableView.height - height)
        segmentedControl.isHidden = tabTitles.count <= 1
        
        // 加载index之前所有和之后的一个
        for i in 0...selectedPage + 1 {
            loadViewController(at: i)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        scrollTo(page: selectedPage, animated: false)
    }
}
