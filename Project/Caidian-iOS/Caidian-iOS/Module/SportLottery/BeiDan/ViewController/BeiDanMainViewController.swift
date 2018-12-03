//
//  JczqMainViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 北京单场
class BeiDanMainViewController: SLChooseViewController {

    typealias MatchModel = JczqMatchModel
    typealias BetType = JczqBetKeyType

    private var tableView = UITableView()
    private var chooseTipBottomView = SLChooseTipBottomView()

    private var beiDanData = SLDataModel<MatchModel>()
    private var matchGroupList = [SLDataModel<MatchModel>.MatchGroup]()
    private var beiDanHandler = BeiDanHandler()
    private var buyModel: SLBuyModel<MatchModel, BetType>! {
        didSet {
            tableView.reloadData()
            chooseTipBottomView.configView(matchCount: buyModel.matchList.count)
        }
    }

    /// 玩法
    override var playType: PlayType {
        didSet {
            if buyModel != nil && buyModel.play != playType {
                matchGroupList = filterMatchGroupList(matchGroupList: beiDanData.matchGroupList)
                buyModel.play = playType
                buyModel.clearMatchList()
                tableView.setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initParams()
        initView()
        getData()
    }

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
        beiDanHandler.requestBeiDanMatchList(
                success: {
                    data in
                    self.beiDanData = data
                    self.isLoadData = true
                    self.isRequestFailed = false
                    self.chooseTipBottomView.isHidden = false
                    self.matchGroupList = self.filterMatchGroupList(matchGroupList: data.matchGroupList)
                    self.tableView.reloadData()
                    TSToast.hideHud(for: self.view)
                },
                failed: {
                    error in
                    self.isRequestFailed = true
                    self.tableView.reloadData()
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription)
                })
    }
}

// MARK:- method
extension BeiDanMainViewController {

    private func initParams() {
        title = "北京单场"
        lottery = .bd
        if playType == .none {
            playType = .fb_spf
        }
        var buy = SLBuyModel<MatchModel, BetType>()
        buy.lottery = lottery
        buy.play = playType
        playTypeList = [.fb_spf, .fb_bqc, .fb_bf, .fb_jqs, .fb_sxds]

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

            tableView.snp.makeConstraints {
                make in
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

            chooseTipBottomView.snp.makeConstraints {
                make in
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
        if playType == .hh {
            return matchGroupList
        }
        return matchGroupList.map {
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
        ctrl.allLeagueList = beiDanData.originalLeagueList
        ctrl.selectedLeagueList = beiDanData.selectedLeagueList
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
extension BeiDanMainViewController: UITableViewDelegate, UITableViewDataSource {

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
        case .fb_spf: return JczqSpfTableCell.defaultHeight
        case .fb_rqspf: return JczqRqspfTableCell.defaultHeight
        case .fb_jqs: return JczqJqsTableCell.defaultHeight
        case .fb_bqc: return JczqBqcTableCell.defaultHeight
        case .fb_bf: return JczqBfTableCell.defaultHeight
        default: return JczqHhTableCell.defaultHeight
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = matchGroupList[indexPath.section].matchList[indexPath.row]
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

        cell.configCell(match: match, betKeyList: betKeyList)
        cell.betBtnActionBlock = {
            [weak self] btn, key in
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

        return cell as! UITableViewCell
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
            me.beiDanData.matchGroupList[section].isExpand = !group.isExpand
            me.matchGroupList = me.filterMatchGroupList(matchGroupList: me.beiDanData.matchGroupList)
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

// MARK:- JczqAllBetDialogViewControllerDelegate
extension BeiDanMainViewController: JczqAllBetDialogViewControllerDelegate {
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
}

// MARK:- SLLeagueFilterViewControllerDelegate
extension BeiDanMainViewController: SLLeagueFilterViewControllerDelegate {

    func leagueFilterViewControllerConfirmButtonClick(_ ctrl: SLLeagueFilterViewController, selectedLeagueList: [SportLotteryLeagueModel]) {

        beiDanData.selectedLeagueList = selectedLeagueList
        matchGroupList = filterMatchGroupList(matchGroupList: beiDanData.matchGroupList)
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
extension BeiDanMainViewController: SLChooseTipBottomViewDelegate {

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
extension BeiDanMainViewController: SLConfirmViewControllerDelegate {

    func confirmViewControllerDidChangeBuyModel<MatchModel, BetType>(_ ctrl: SLConfirmViewController<MatchModel, BetType>, buyModel: SLBuyModel<MatchModel, BetType>) where MatchModel : SLMatchModelProtocol, BetType : SLBetKeyProtocol {
        self.buyModel = buyModel as! SLBuyModel<JczqMainViewController.MatchModel, JczqMainViewController.BetType> //as! SLBuyModel<MatchModel, BetType>
    }
}

extension BeiDanMainViewController {
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
}
