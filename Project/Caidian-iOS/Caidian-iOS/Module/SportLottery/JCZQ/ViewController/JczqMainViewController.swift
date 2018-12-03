//
//  JczqMainViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 竞彩足球
class JczqMainViewController: SLChooseViewController {

    typealias MatchModel = JczqMatchModel
    typealias BetType = JczqBetKeyType

    private var tableView = UITableView()
    private var chooseTipBottomView = SLChooseTipBottomView()

    /// 显示对阵信息的IndexPath
    private var showIndexPath: IndexPath?

    /// 两队历史战绩
    private var historyModel: JczqMatchTeamHistoryModel!

    private var historyModels = [JczqMatchTeamHistoryModel]()

    private var jczqData = SLDataModel<MatchModel>()
    private var matchGroupList = [SLDataModel<MatchModel>.MatchGroup]()
    private var jczqHandler = JczqHandler()
    private var buyModel: SLBuyModel<MatchModel, BetType>! {
        didSet {
            tableView.reloadData()
            chooseTipBottomView.configView(matchCount: buyModel.matchList.count)
        }
    }

    /// 是否包含购物车里的内容
    private var isRecommendSelected = false

    /// 玩法
    override var playType: PlayType {
        didSet {
            if buyModel != nil && buyModel.play != playType {
                matchGroupList = filterMatchGroupList(matchGroupList: jczqData.matchGroupList)
                buyModel.play = playType
                buyModel.clearMatchList()
                tableView.setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(buySuccess), name: TSNotification.buySuccess.notification, object: nil)
        
        isRecommendSelected = (recommendModels?.count ?? 0) > 0 ? true : false
        initParams()
        initView()
        getData()
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if tableView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override func getData() {

        TSToast.showLoading(view: view)

        jczqHandler.getMatchList(success: { (data) in
            self.jczqData = data
            self.isLoadData = true
            self.isRequestFailed = false
            self.chooseTipBottomView.isHidden = false

            self.matchGroupList = self.filterMatchGroupList(matchGroupList: data.matchGroupList)

            self.tableView.reloadData()
            TSToast.hideHud(for: self.view)
            if self.matchGroupList.count > 0 {
                if self.isRecommendSelected {
                    let cell: JczqTableCellProtocol = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! JczqTableCellProtocol
                    self.getTeamHistoryInfoData(sender: cell.showButton, indexPath: IndexPath(row: 0, section: 0), willOpen: false, isFirst: false)
                } else {
                    let cell: JczqTableCellProtocol = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! JczqTableCellProtocol
                    self.getTeamHistoryInfoData(sender: cell.showButton, indexPath: IndexPath(row: 0, section: 0), willOpen: true, isFirst: true)
                }
            }
        }) { (error) in
            self.isRequestFailed = true
            self.tableView.reloadData()
            TSToast.hideHud(for: self.view)
            TSToast.showText(view: self.view, text: error.localizedDescription)
        }
    }
    
    /// 购买成功
    @objc  func buySuccess(){
        var buySuccessIDs = [Int]()
        buyModel.matchList.forEach{
            it in
            if it.match.recommendId != 0 {
                buySuccessIDs.append(it.match.recommendId)
            }
        }
        UserToken.shared.addToCartSuccess(recommendIDs: buySuccessIDs)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

// MARK:- method
extension JczqMainViewController {

    private func initParams() {
        title = "竞彩足球"
        lottery = .jczq
        if playType == .none {
            playType = .hh
        }

        var buy = SLBuyModel<MatchModel, BetType>()
        buy.lottery = lottery
        buy.play = playType
        playTypeList = [.hh, .fb_spf, .fb_rqspf, .fb_jqs, .fb_bf, .fb_bqc]

        buyModel = buy
    }

    private func initView() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }

        let bottomViewHeight: CGFloat = SLChooseTipBottomView.defaultHeight
        view.addSubview(tableView)
        view.addSubview(chooseTipBottomView)

        do {
            tableView.register(R.nib.jczqHhTableCell)
            tableView.register(R.nib.jczqJqsTableCell)
            tableView.register(R.nib.jczqBqcTableCell)
            tableView.register(R.nib.jczqSpfTableCell)
            tableView.register(R.nib.jczqRqspfTableCell)
            tableView.register(R.nib.jczqBfTableCell)
            tableView.register(SLChooseTableHeaderView.self, forHeaderFooterViewReuseIdentifier: R.nib.slChooseTableHeaderView.name)
            tableView.allowsSelection = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.tableFooterView = UIView()

            tableView.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview()
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-bottomViewHeight)
                } else {
                    make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-bottomViewHeight)
                }
            }
        }

        do {
            chooseTipBottomView.delegate = self
            chooseTipBottomView.isHidden = true
            chooseTipBottomView.configView(matchCount: buyModel.matchList.count)

            chooseTipBottomView.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(bottomViewHeight)
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
                }
            }
        }
    }

    // 根据玩法过滤一下符合条件的对阵
    private func filterMatchGroupList(matchGroupList: [SLDataModel<MatchModel>.MatchGroup]) -> [SLDataModel<MatchModel>.MatchGroup] {
        if let model = historyModels.first {
            showIndexPath = IndexPath(row: 0, section: 0)
            historyModel = model
        }

        // 对源数据也进行购物车分类
        jczqData.matchGroupList = filterMatchGroupListFromShopping(groupList:  jczqData.matchGroupList)

        if playType == .hh {
            return filterMatchGroupListFromShopping(groupList: matchGroupList)
        }
        let groupList = matchGroupList.map {
            group -> SLDataModel<MatchModel>.MatchGroup in
            var group = group
            group.matchList = group.matchList.filter {
                match -> Bool in
                switch playType {
                case .fb_jqs: return match.jqsFixed
                case .fb_bqc: return match.bqcFixed
                case .fb_spf: return match.spfFixed
                case .fb_rqspf: return match.rqspfFixed
                case .fb_bf: return match.bfFixed
                default: return true
                }
            }
            return group
        }

        //  通过购物车数据修改本条数据
        return filterMatchGroupListFromShopping(groupList: groupList)
    }


    /**
     * 如果购物车数据 将数据按购物车分类  直接购买的数据 不分类
     */
    func filterMatchGroupListFromShopping(groupList: [SLDataModel<MatchModel>.MatchGroup]) -> [SLDataModel<MatchModel>.MatchGroup] {
        var matchGroupList = groupList
        // 新分组的数据
        var shoppingMatchGroup = [JczqMatchModel]()
        recommendModels?.forEach { recommendModel in

            for (index, group) in matchGroupList.enumerated() {
                var newGroup = group
                // 需要从旧分组中删除的数据索引
                var needDeleteIndex: Int? = nil
                var newMatch: JczqMatchModel? = nil

                for (matchIndex, it) in group.matchList.enumerated() {
                    if it.id == recommendModel.matchInfo.id {
                        newMatch = it
                        needDeleteIndex = matchIndex
                    }
                }

                /// 查找到本条数据
                if newMatch != nil {
                    var newBetBeanList = [JczqBetKeyType]()
                    recommendModel.recommend.code.forEach {
                        recommendBet in
                        newBetBeanList.append(newMatch!.getBetKeyTypeFromBetKey(beteKey: recommendBet.key))
                    }
                    /// 去修改buyModel的数据
                    newMatch?.recommendId = recommendModel.recommend.id
                    buyModel.changeBetKeyList(match: newMatch!, betKeyList: newBetBeanList)

                    /// 修改分组的数据
                    shoppingMatchGroup.append(newMatch!)
                    newGroup.matchList.remove(at: needDeleteIndex!)

                    matchGroupList[index].matchList.remove(at: needDeleteIndex!)
                }
            }
        }

        // 插入新的分组数据
        if shoppingMatchGroup.count > 0 {
            let newGroup = SLDataModel<MatchModel>.MatchGroup.init(day: "购物车", weekday: "购物车", isExpand: true, matchList: shoppingMatchGroup)
            matchGroupList.insert(newGroup, at: 0)
        }
        // 查找空groupIndex
        var needGroupIndex = [Int]()
        for (index, group) in matchGroupList.enumerated() {
            if group.matchList.count == 0 {
                needGroupIndex.append(index)
            }
        }
        //删除空group
        needGroupIndex.forEach{
            matchGroupList.remove(at: $0)
        }
        return matchGroupList
    }

    private func showAllBet(match: MatchModel, betKeyList: [JczqMainViewController.BetType], playType: PlayType = .hh) {
        let ctrl = R.storyboard.jczqAllBetDialog.jczqAllBetDialogViewController()!
        ctrl.playType = playType
        ctrl.match = match
        ctrl.betKeyList = betKeyList
        ctrl.delegate = self

        UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(ctrl)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(ctrl.view)
        ctrl.view.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }

    override func filterMatchBtnAction() {
        let ctrl = R.storyboard.slLeagueFilter.slLeagueFilterViewController()!
        ctrl.delegate = self
        ctrl.allLeagueList = jczqData.originalLeagueList
        ctrl.selectedLeagueList = jczqData.selectedLeagueList
        ctrl.customLeagueList = [
            SportLotteryLeagueModel(name: "英超", color: UIColor.black),
            SportLotteryLeagueModel(name: "西甲", color: UIColor.black),
            SportLotteryLeagueModel(name: "德甲", color: UIColor.black),
            SportLotteryLeagueModel(name: "意甲", color: UIColor.black),
            SportLotteryLeagueModel(name: "法甲", color: UIColor.black),
        ]

        UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(ctrl)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(ctrl.view)
        ctrl.view.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
        ctrl.customBtn.setTitle("五大联赛", for: .normal)
    }
}

// MARK:- UITableViewDelegate
extension JczqMainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return matchGroupList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = matchGroupList[section]
        if group.isExpand {
            return group.matchList.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch playType {
        case .fb_spf: return JczqSpfTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        case .fb_rqspf: return JczqRqspfTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        case .fb_jqs: return JczqJqsTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        case .fb_bqc: return JczqBqcTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        case .fb_bf: return JczqBfTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        default: return JczqHhTableCell.defaultHeight + (indexPath == showIndexPath ? JczpHistoryInfoView.defaultHeight : 0)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var match = matchGroupList[0].matchList.first
        match = matchGroupList[indexPath.section].matchList[indexPath.row]
        if let match = match {
            let betKeyList = buyModel.matchList.filter({ $0.match.id == match.id }).first?.betKeyList ?? []
            var cell: JczqTableCellProtocol!
            switch playType {
            case .fb_spf:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqSpfTableCell, for: indexPath)!
            case .fb_rqspf:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqRqspfTableCell, for: indexPath)!
            case .fb_jqs:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqJqsTableCell, for: indexPath)!
            case .fb_bqc:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqBqcTableCell, for: indexPath)!
            case .fb_bf:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqBfTableCell, for: indexPath)!
                (cell as! JczqBfTableCell).moreBtnActionBlock = {
                    [weak self] _ in
                    self?.showAllBet(match: match, betKeyList: betKeyList, playType: .fb_bf)
                }
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jczqHhTableCell, for: indexPath)!
                (cell as! JczqHhTableCell).moreBtnActionBlock = {
                    [weak self] _ in
                    self?.showAllBet(match: match, betKeyList: betKeyList, playType: .hh)
                }
            }
            cell.statisticsView.isHidden = indexPath != showIndexPath
            cell.showButton.isSelected = indexPath == showIndexPath
            cell.configCell(match: match, betKeyList: betKeyList)
            cell.betBtnActionBlock = { [weak self] btn, key in
                guard let me = self else {
                    return
                }
                if btn.isSelected && me.buyModel.matchList.count >= 15 {
                    TSToast.showText(view: me.view, text: "最多选择15场比赛")
                    btn.isSelected = false
                    return
                }
                me.buyModel.changeBetKey(match: match, key: key)
            }
            cell.showBlock = { [weak self] sender in
                self?.getTeamHistoryInfoData(sender: sender, indexPath: indexPath, willOpen: !sender.isSelected, isFirst: false)
            }
            if let model = historyModel {
                cell.statisticsView.configView(model: model, delegate: self, indexPath: indexPath)
            }
            return cell as! UITableViewCell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.slChooseTableHeaderView.name) as? SLChooseTableHeaderView

        let group = matchGroupList[section]
        header?.configView(group: group)
        header?.contentViewClickBlock = {
            [weak self] in
            guard let me = self else {
                return
            }
            
            me.jczqData.matchGroupList[section].isExpand = !group.isExpand
            me.matchGroupList[section].isExpand = !group.isExpand
            UIView.performWithoutAnimation {
                me.tableView.reloadSections(IndexSet(integer: section), with: .none)
            }
        }
        return header
    }

    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}

/// 展开信息
extension JczqMainViewController {

    private func getTeamHistoryInfoData(sender: UIButton, indexPath: IndexPath, willOpen: Bool, isFirst: Bool) {
        if isFirst {
            let match = matchGroupList[0].matchList[0]
            let activityIndicator = activityIndicatorView(sender: sender)
            jczqHandler.getMatchTeamHistory(matchId: match.id, success: { [weak self] (model) in
                self?.historyModel = model
                self?.historyModels.append(model)
                let i = IndexPath(row: 0, section: 0)
                self?.showIndexPath = i
                self?.tableView.reloadRows(at: [i], with: .fade)
                let cell: JczqTableCellProtocol = self?.tableView.cellForRow(at: i) as! JczqTableCellProtocol
                cell.statisticsView.configView(model: model, delegate: self, indexPath: i)
                self?.stopAnimating(activityIndicator, sender: sender)
            }) { [weak self] (error) in
                self?.stopAnimating(activityIndicator, sender: sender)
                if let view = self?.view {
                    TSToast.showText(view: view, text: error.localizedDescription)
                }
            }
        } else {
            if willOpen {
                let match =  matchGroupList[indexPath.section].matchList[indexPath.row]

                let index = historyModels.index(where: { $0.matchId == match.id })
                /// 判断是否有当前matchId的model
                if let index = index {
                    reloadTableView(indexPath: indexPath, model: historyModels[index])
                } else {
                    let activityIndicator = activityIndicatorView(sender: sender)

                    sender.isHidden = true
                    activityIndicator.startAnimating()
                    jczqHandler.getMatchTeamHistory(matchId: match.id, success: { [weak self] (model) in
                        self?.stopAnimating(activityIndicator, sender: sender)
                        self?.historyModels.append(model)
                        self?.reloadTableView(indexPath: indexPath, model: model)
                    }) { [weak self] (error) in
                        self?.stopAnimating(activityIndicator, sender: sender)
                        if let view = self?.view {
                            TSToast.showText(view: view, text: error.localizedDescription)
                        }
                    }
                }
            } else {
                showIndexPath = nil
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }

    private func reloadTableView(indexPath: IndexPath, model: JczqMatchTeamHistoryModel) {
        // 展开一个，关闭一个
        if let show = showIndexPath {
            showIndexPath = indexPath
            /// 判断当前上一个展示的cell是否存在（当section收起的时候, 为nil）
            if let _ = tableView.cellForRow(at: show) {
                tableView.reloadRows(at: [show, indexPath], with: .fade)
            } else {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        } else { // 展开一个（之前没有展开的）
            showIndexPath = indexPath
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        historyModel = model
        let cell: JczqTableCellProtocol = tableView.cellForRow(at: indexPath) as! JczqTableCellProtocol
        cell.statisticsView.configView(model: historyModel, delegate: self, indexPath: indexPath)
    }

    /// 创建 UIActivityIndicatorView
    private func activityIndicatorView(sender: UIButton) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: sender.centerX - 15, y: sender.frame.maxY - 23, width: 30, height: 30)
        sender.superview?.addSubview(activityIndicator)
        return activityIndicator
    }

    /// 移除 UIActivityIndicatorView
    private func stopAnimating(_ activityIndicator: UIActivityIndicatorView, sender: UIButton) {
        sender.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

}

// MARK: - JczpHistoryInfoViewDelegate
extension JczqMainViewController: JczpHistoryInfoViewDelegate {
    func jczpHistoryInfoView(_ view: JczpHistoryInfoView, didTapView gesture: UITapGestureRecognizer, indexPath: IndexPath) {
        let vc = LiveWebViewController()
        vc.url = historyModel.url
        vc.canGoBack = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- JczqAllBetDialogViewControllerDelegate
extension JczqMainViewController: JczqAllBetDialogViewControllerDelegate {
    func jczqAllBetDialogViewControllerConfirmButtonClick(_ ctrl: JczqAllBetDialogViewController, match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        if !buyModel.matchList.contains(where: { $0.match.id == match.id }) && buyModel.matchList.count >= 15 {
            TSToast.showText(view: ctrl.view, text: "最多选择15场比赛")
            return
        }
        buyModel.changeBetKeyList(match: match, betKeyList: betKeyList)
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }

    func jczqAllBetDialogViewControllerCancelButtonClick(_ ctrl: JczqAllBetDialogViewController) {
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }


    private func deleteRecommendList() {
        var newMatchGroupList = matchGroupList
        newMatchGroupList.removeAll()
        for matchGroup in self.matchGroupList {
            var newMatchGroup = matchGroup
            newMatchGroup.matchList.removeAll()
            for match in matchGroup.matchList {
                var isSelected = false
                for buy in self.buyModel.matchList {
                    if match.id == buy.match.id {
                        isSelected = true
                    }
                }
                if !isSelected {
                    newMatchGroup.matchList.append(match)
                }
            }
            newMatchGroupList.append(newMatchGroup)
        }
        self.matchGroupList = newMatchGroupList
    }
}

// MARK:- SLLeagueFilterViewControllerDelegate
extension JczqMainViewController: SLLeagueFilterViewControllerDelegate {
    /// 联赛筛选
    func leagueFilterViewControllerConfirmButtonClick(_ ctrl: SLLeagueFilterViewController, selectedLeagueList: [SportLotteryLeagueModel]) {
        jczqData.selectedLeagueList = selectedLeagueList
        
        matchGroupList = filterMatchGroupList(matchGroupList: jczqData.matchGroupList)
        buyModel.clearMatchList()

        if isRecommendSelected {
            showIndexPath = nil
        } else {
            showIndexPath = IndexPath(row: 0, section: 0)
            let match = matchGroupList[0].matchList[0]
            let index = historyModels.index(where: { $0.matchId == match.id })
            if let index = index {
                historyModel = historyModels[index]
            } else {
                getTeamHistoryInfoData(sender: UIButton(), indexPath: showIndexPath!, willOpen: !isRecommendSelected, isFirst: false)
            }
        }

        tableView.reloadData()

        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }

    func leagueFilterViewControllerCancelButtonClick(_ ctrl: SLLeagueFilterViewController) {
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }
}

// MARK:- SLChooseTipBottomViewDelegate
extension JczqMainViewController: SLChooseTipBottomViewDelegate {

    func chooseTipBottomViewNextButtonClick(_ bottomView: SLChooseTipBottomView) {
        if buyModel.allAllowSerialList.isEmpty {
            TSToast.showText(view: view, text: "请选择至少2场赛事或者1场单关")
            return
        }
        
        let ctrl = JczqConfirmViewController()
        ctrl.buyModel = buyModel
        ctrl.delegate = self
        navigationController?.pushViewController(ctrl, animated: true)
    }

    func chooseTipBottomViewClearButtonClick(_ bottomView: SLChooseTipBottomView) {
        buyModel.clearMatchList()
    }
}

// MARK:- SLConfirmViewControllerDelegate
extension JczqMainViewController: SLConfirmViewControllerDelegate {

    func confirmViewControllerDidChangeBuyModel<MatchModel, BetType>(_ ctrl: SLConfirmViewController<MatchModel, BetType>, buyModel: SLBuyModel<MatchModel, BetType>) where MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol {
        self.buyModel = buyModel as! SLBuyModel<JczqMainViewController.MatchModel, JczqMainViewController.BetType> //as! SLBuyModel<MatchModel, BetType>
    }
}

extension JczqMainViewController {
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
}
