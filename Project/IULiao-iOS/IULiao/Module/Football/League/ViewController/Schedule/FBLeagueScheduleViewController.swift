//
//  FBLeagueScheduleViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 联赛 赛程
class FBLeagueScheduleViewController: TSEmptyViewController, FBLeagueViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var groupStackView: UIStackView!
    @IBOutlet weak var toolbarView: UIView!
    
    @IBOutlet weak var prevRoundBtn: UIButton!
    @IBOutlet weak var nextRoundBtn: UIButton!
    @IBOutlet weak var stageBtn: UIButton!
    @IBOutlet weak var allRoundBtn: UIButton!
    
    
    @IBOutlet weak var groupViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolbarViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stageBtnXConstraint: NSLayoutConstraint!
    @IBOutlet weak var allRoundBtnXConstraint: NSLayoutConstraint!
    
    /// 联赛id
    var leagueId: Int!
    
    /// 赛季id
    var seasonId: Int? {
        didSet {
            if leagueId != nil && tableView != nil && seasonId != nil && seasonId != oldValue  {
                getStageList()
            }
        }
    }
    
    /// 选择的阶段
    private var selectedStage: FBLeagueStageModel? {
        didSet {
            guard let selectedStage = selectedStage else {
                return
            }
            selectedGroup = selectedStage.groups.filter({ $0.isCurrent }).first ?? selectedStage.groups.first
        }
    }
    /// 选择的分组(圈)
    private var selectedGroup: FBLeagueStageModel.GroupModel? {
        didSet {
            setupToolbarView()
            getStageMatch(stageId: selectedStage?.id, groupId: selectedGroup?.id)
        }
    }
    
    private var dataSource: [FBMatchModel]? {
        didSet {
            tableView?.reloadData()
            if (dataSource?.count ?? 0) > 0 {
                tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private var stageList: [FBLeagueStageModel]?
    private let stageHandler = FBLeagueStageHandler()
    override var isRequestFailed: Bool {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }
    
    override func getData() {
        getStageList()
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }

    /// 上一轮
    @IBAction func prevRoundBtnClick(_ sender: UIButton) {
        
        guard let stage = selectedStage,
            let group = selectedGroup,
            let prevGroup = stage.groups.filter({ $0.id < group.id }).last
        else {
            return
        }
        selectedGroup = prevGroup
        
    }
    
    /// 下一轮
    @IBAction func nextRoundBtnClick(_ sender: UIButton) {
        guard let stage = selectedStage,
            let group = selectedGroup,
            let nextGroup = stage.groups.filter({ $0.id > group.id }).first
            else {
                return
        }
        selectedGroup = nextGroup
    }
    
    /// 阶段
    @IBAction func stageBtnClick(_ sender: UIButton) {
        let ctrl = R.storyboard.fbLeagueSchedule.fbLeagueScheduleStageViewController()!
        ctrl.delegate = self
        if let stageList = stageList {
            ctrl.stageList = stageList
            ctrl.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    /// 所有轮次
    @IBAction func allRoundBtnClick(_ sender: UIButton) {
        let ctrl = R.storyboard.fbLeagueSchedule.fbLeagueScheduleRoundViewController()!
        ctrl.delegate = self
        guard let selectStage = selectedStage, selectStage.type == .round else {
            return
        }
        let groupList = selectStage.groups
        ctrl.roundList = groupList
        ctrl.selectedRound = selectedGroup
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
        
    }
}

extension FBLeagueScheduleViewController {
    
    private func initView() {
        displayGroupView(isShow: false)
        displayToolbarView(isShow: false)
        
        stageBtn.layoutImageViewPosition(.right, withOffset: 4)
        allRoundBtn.layoutImageViewPosition(.right, withOffset: 4)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        view.bringSubview(toFront: hud)
    }
 
    private func initNetwork() {
        getStageList()
    }
    
    /// 获取阶段列表
    private func getStageList() {
        hud.show(animated: true)
        stageHandler.getStageList(
            leagueId: leagueId,
            seasonId: seasonId,
            success: {
                stageList in
                self.stageList = stageList
            
                // 获取赛事
                let stage = stageList.filter({ $0.isCurrent }).first
                self.selectedStage = stage
                self.isRequestFailed = false
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.hud.hide(animated: true)
                TSToast.showNotificationWithMessage(error.localizedDescription)
        })
    }
    
    /// 获取阶段 赛事
    private func getStageMatch(stageId: Int?, groupId: Int?) {
        hud.hide(animated: true)
        hud.show(animated: true)
        stageHandler.getStageMatch(
            leagueId: leagueId,
            seasonId: seasonId,
            stageId: stageId,
            groupId: groupId,
            success: {
                matchs in
                self.hud.hide(animated: true)
                self.isRequestFailed = false
                self.dataSource = matchs
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.hud.hide(animated: true)
                TSToast.showNotificationWithMessage(error.localizedDescription)
        })
    }
    
    /// 显示分组
    private func displayGroupView(isShow: Bool) {
        if isShow {
            groupView.isHidden = false
            groupViewHeightConstraint.constant = 30
        } else {
            groupView.isHidden = true
            groupViewHeightConstraint.constant = 0
        }
    }
    
    /// 显示底部toolbar
    private func displayToolbarView(isShow: Bool) {
        if isShow {
            toolbarView.isHidden = false
            toolbarViewHeightConstraint.constant = 52
        } else {
            toolbarView.isHidden = true
            toolbarViewHeightConstraint.constant = 0
        }
    }
    
    /// 设置toolbar
    private func setupToolbarView() {
        guard let stage = selectedStage else {
            displayGroupView(isShow: false)
            displayToolbarView(isShow: false)
            return
        }
        let groups = stage.groups
        // 从选中的group中取id 不存在则选取currentid 再不存在取第一个在不存在取0
        let group = selectedGroup ?? groups.filter({ $0.isCurrent }).first ?? groups.first
        
        // 全部显示底部按钮
        displayToolbarView(isShow: true)
        stageBtn.setTitle("\(stage.name)", for: .normal)
        
        switch stage.type {
        case .normal:
            // 普通 不显示小组 不显示上一轮 下一轮 不显示轮次 显示阶段
            displayGroupView(isShow: false)
            prevRoundBtn.isHidden = true
            nextRoundBtn.isHidden = true
            allRoundBtn.isHidden = true
            stageBtn.isHidden = false
            stageBtnXConstraint.constant = 0
        case .group:
            // 分组 显示小组 不显示上一轮下一轮 不显示轮次 显示阶段
            displayGroupView(isShow: true)
            prevRoundBtn.isHidden = true
            nextRoundBtn.isHidden = true
            allRoundBtn.isHidden = true
            stageBtn.isHidden = false
            stageBtnXConstraint.constant = 0
            
            // 添加小组的按钮
            groupStackView.arrangedSubviews.forEach {
                groupStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            for g in groups {
                let v = createGroupBtn(group: g, isSelected: g.id == (group?.id ?? 0))
                groupStackView.addArrangedSubview(v)
            }
            
        case .round:
            // 轮次 不显示小组 显示上一轮下一轮 显示轮次 (显示阶段,不显示阶段)
            displayGroupView(isShow: false)
            
            if let group = group {
                prevRoundBtn.isHidden = groups.filter({ $0.id < group.id }).count == 0
                nextRoundBtn.isHidden = groups.filter({ $0.id > group.id }).count == 0
                allRoundBtn.setTitle("第\(group.name)轮", for: .normal)
            } else {
                prevRoundBtn.isHidden = true
                nextRoundBtn.isHidden = true
            }
            
            allRoundBtn.isHidden = false
            // 阶段名为空 则不显示阶段
            if stage.name.isEmpty {
                stageBtn.isHidden = true
                allRoundBtnXConstraint.constant = 0
            } else {
                stageBtn.isHidden = false
                stageBtnXConstraint.constant = -(stageBtn.width / 2 + 5)
                allRoundBtnXConstraint.constant = (allRoundBtn.width / 2 + 5)
            }
        }
        
        stageBtn.layoutImageViewPosition(.right, withOffset: 4)
        allRoundBtn.layoutImageViewPosition(.right, withOffset: 4)
    }
    
    /// 添加一个小组按钮
    private func createGroupBtn(group: FBLeagueStageModel.GroupModel, isSelected: Bool) -> UIView {
        let btn = UIButton()
        btn.setTitle(group.name, for: .normal)
        btn.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.cornerRadius = 10
        btn.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        btn.isSelected = isSelected
        btn.extraProperty = ["group": group]
        
        btn.addTarget(self, action: #selector(groupBtnClick(sender:)), for: .touchUpInside)
        return btn
    }
    
    /// 小组点击
    @objc func groupBtnClick(sender: UIButton) {
        guard let group = sender.extraProperty?["group"] as? FBLeagueStageModel.GroupModel else {
            return
        }
        selectedGroup = group
    }

}

extension FBLeagueScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueScheduleMatchTableCell, for: indexPath)!
        if let match = dataSource?[indexPath.row] {
            cell.configCell(match: match)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let match = dataSource?[indexPath.row] {
            let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: nil)
            navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}

extension FBLeagueScheduleViewController: FBLeagueScheduleStageViewControllerDelegate {
    
    func leagueScheduleStage(_ ctrl: FBLeagueScheduleStageViewController, selectStage stage: FBLeagueStageModel) {
        selectedStage = stage
    }
}

extension FBLeagueScheduleViewController: FBLeagueScheduleRoundViewControllerDelegate {
    
    func leagueScheduleRound(_ ctrl: FBLeagueScheduleRoundViewController, selectRound round: FBLeagueStageModel.GroupModel) {
        selectedGroup = round
    }
}


extension FBLeagueScheduleViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }

    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 8
    }
}

