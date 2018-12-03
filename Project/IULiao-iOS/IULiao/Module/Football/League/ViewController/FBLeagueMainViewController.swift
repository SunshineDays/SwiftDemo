//
//  FBLeagueMainViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/31.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SnapKit

/// 联赛view controller 需要实现的协议
protocol FBLeagueViewControllerProtocol {
    
    /// 联赛id
    var leagueId: Int! { get set }
    
    /// 赛季id
    var seasonId: Int? { get set }
}

/// 联赛的主页(单个联赛)
class FBLeagueMainViewController: BaseViewController {
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var scrollView: BaseScrollView!
    
    /// 赛季选择按钮
    private let seasonChooseBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        btn.setTitle("赛季", for: .normal)
        btn.setTitleColor(UIColor(hex: 0xffffff, alpha: 0.3), for: .highlighted)
        btn.setImage(R.image.fbLeague.seasonArrowDown(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.contentHorizontalAlignment = .right
        btn.layoutImageViewPosition(.right, withOffset: 6)
        return btn
    }()
    
    /// 联赛id
    var leagueId: Int! = 92
    
    /// 赛季id
    var seasonId: Int? {
        didSet {
            guard let seasonId = seasonId,
                let seasonList = seasonList,
                let season = seasonList.filter({ $0.id == seasonId }).first
                else {
                    return
            }
            
            seasonChooseBtn.setTitle(season.shortName, for: .normal)
            seasonChooseBtn.layoutImageViewPosition(.right, withOffset: 6)
            seasonChooseBtn.isHidden = false
            
            viewControllersCaches.forEach {
                (arg) in
                var (_, ctrl) = arg
                ctrl.seasonId = self.seasonId
            }
        }
    }
    private var seasonList: [FBLeagueSeasonModel]?
    /// 赛季选择的id
    private var actionSheetSelectedSeasonId: Int?
    
    private let sectionTitles         = LeagueType.tabs.map { $0.title }
    private var viewControllersCaches = [LeagueType: UIViewController & FBLeagueViewControllerProtocol]()
    
    private let leagueDetailHandler = FBLeagueDetailHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: CGFloat(LeagueType.tabs.count) * scrollView.width, height: scrollView.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    enum LeagueType {
        case detail, schedule, rankScore, rankAsia, rankBigSmall
        
        var title: String {
            switch self {
            case .detail: return "联赛详情"
            case .schedule: return "赛程"
            case .rankScore: return "积分榜"
            case .rankAsia: return "亚盘榜"
            case .rankBigSmall: return "大小球"
            }
        }
        
        static let tabs: [LeagueType] = [.detail, .schedule, .rankScore, .rankAsia, .rankBigSmall]
    }
}

// MARK:- method
extension FBLeagueMainViewController {
    
    @objc private func seasonChooseBtnClick() {
        // 不要把actionSheetPicker当做成员变量 会内存泄露
        let actionSheetPicker = ActionSheetCustomPicker(title: "选择赛季", delegate: self, showCancelButton: true, origin: view)
        actionSheetPicker?.toolbarButtonsColor = baseNavigationBarTintColor
        actionSheetPicker?.show()
    }
    
    private func initView() {
        
        scrollView.delaysContentTouches = false
        scrollView.delegate = self
        scrollView.bounces = false
        
        seasonChooseBtn.addTarget(self, action: #selector(seasonChooseBtnClick), for: .touchUpInside)
        let item = UIBarButtonItem(customView: seasonChooseBtn)
        navigationItem.setRightBarButton(item, animated: false)
        
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
        
        segmentedControl.sectionTitles = sectionTitles
        segmentedControl.indexChangeBlock = {
            [unowned self] index in
            let x = self.scrollView.width * CGFloat(index)
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
    }
    
    private func initNetwork() {
        hud.offset.y = 48
        hud.show(animated: true)
        leagueDetailHandler.getSeasonList(
            leagueId: leagueId,
            success: {
                league, seasons in
                self.navigationItem.title = league.fullName ?? league.name
                if let seasonId = self.seasonId ?? seasons.first?.id {
                    self.seasonList = seasons
                    self.seasonId = seasonId
                }
                self.hud.hide(animated: true)
                // 预先加载两页
                self.loadViewController(leagueType: .detail)
                self.loadViewController(leagueType: .schedule)
            },
            failed: {
                error in
            })
    }

    /// 设置ctrl
    private func loadViewController(leagueType: LeagueType) {
        guard let index = LeagueType.tabs.index(of: leagueType) else {
            return
        }
        loadViewController(index: index)
    }

    /// 设置ctrl
    private func loadViewController(index: Int) {
        guard let leagueType = LeagueType.tabs[safe: index] else {
            return
        }
        var ctrl = viewControllersCaches[leagueType]
        if ctrl != nil {
            return
        }

        switch leagueType {
        case .schedule:
            ctrl = R.storyboard.fbLeagueSchedule.fbLeagueScheduleViewController()!
        case .detail:
            ctrl = R.storyboard.fbLeagueDetail.fbLeagueDetailViewController()!
        case .rankAsia:
            ctrl = R.storyboard.fbLeagueRank.fbLeagueRankAsiaViewController()!
        case .rankBigSmall:
            ctrl = R.storyboard.fbLeagueRank.fbLeagueRankBigSmallViewController()!
        case .rankScore:
            ctrl = FBLeagueRankScoreViewController()
        }
        if let seasonId = seasonId {
            ctrl!.seasonId = seasonId
        }
        ctrl!.leagueId = leagueId

        let x = CGFloat(index) * scrollView.width
        ctrl!.view.frame = CGRect(x: x, y: 0, width: scrollView.width, height: scrollView.height)
        addChildViewController(ctrl!)
        scrollView.addSubview(ctrl!.view)
        viewControllersCaches[leagueType] = ctrl!
    }
}

// MARK:- UICollectionViewDelegate
extension FBLeagueMainViewController: UIScrollViewDelegate {
    
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


// MARK:- ActionSheetCustomPickerDelegate
extension FBLeagueMainViewController: ActionSheetCustomPickerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seasonList?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let seasonList = seasonList else {
            return nil
        }
        return seasonList[safe: row]?.shortName
    }
    
    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        guard let seasonList = seasonList, let seasonId = seasonId else {
            return
        }
        if let row = seasonList.map({ $0.id}).index(of: seasonId) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        if let actionSheetSelectedSeasonId = actionSheetSelectedSeasonId {
            seasonId = actionSheetSelectedSeasonId
        }
        actionSheetSelectedSeasonId = nil
    }
    
    func actionSheetPickerDidCancel(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        actionSheetSelectedSeasonId = nil
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        actionSheetSelectedSeasonId = seasonList?[safe: row]?.id
    }
}
