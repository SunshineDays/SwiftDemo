//
// Created by tianshui on 2018/5/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 竞彩篮球
class JclqMainViewController: SLChooseViewController {

    typealias MatchModel = JclqMatchModel
    typealias BetType = JclqBetKeyType

    private var tableView = UITableView()
    private var chooseTipBottomView = SLChooseTipBottomView()

    private var jclqData = SLDataModel<MatchModel>()
    private var matchGroupList = [SLDataModel<MatchModel>.MatchGroup]()
    private var jclqHandler = JclqHandler()
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
                matchGroupList = filterMatchGroupList(matchGroupList: jclqData.matchGroupList)
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
        jclqHandler.getMatchList(
                success: {
                    data in
                    self.jclqData = data
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
extension JclqMainViewController {

    private func initParams() {
        title = "竞彩篮球"
        lottery = .jclq
        if playType == .none {
            playType = .hh
        }
        var buy = SLBuyModel<MatchModel, BetType>()
        buy.lottery = lottery
        buy.play = playType
        playTypeList = [.hh, .bb_sf, .bb_rfsf, .bb_dxf, .bb_sfc]

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
            tableView.register(R.nib.jclqHhTableCell)
            tableView.register(R.nib.jclqSfTableCell)
            tableView.register(R.nib.jclqRfsfTableCell)
            tableView.register(R.nib.jclqDxfTableCell)
            tableView.register(R.nib.jclqSfcTableCell)
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
                case .bb_dxf: return match.dxfFixed
                case .bb_sf: return match.sfFixed
                case .bb_rfsf: return match.rfsfFixed
                case .bb_sfc: return match.sfcFixed
                default: return true
                }
            }
            return group
        }
    }

    private func showAllBet(match: MatchModel, betKeyList: [JclqMainViewController.BetType], playType: PlayType = .hh) {
        let ctrl = R.storyboard.jclqAllBetDialog.jclqAllBetDialogViewController()!
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
        ctrl.allLeagueList = jclqData.originalLeagueList
        ctrl.selectedLeagueList = jclqData.selectedLeagueList
        ctrl.customLeagueList = [
            SportLotteryLeagueModel(name: "NBA", color: UIColor.black),
        ]

        UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(ctrl)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(ctrl.view)
        ctrl.view.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
        ctrl.customBtn.setTitle("NBA", for: .normal)
    }
}

// MARK:- UITableViewDelegate
extension JclqMainViewController: UITableViewDelegate, UITableViewDataSource {

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
        case .bb_sf: return JclqSfTableCell.defaultHeight
        case .bb_rfsf: return JclqRfsfTableCell.defaultHeight
        case .bb_dxf: return JclqDxfTableCell.defaultHeight
        case .bb_sfc: return JclqSfcTableCell.defaultHeight
        default: return JclqHhTableCell.defaultHeight
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = matchGroupList[indexPath.section].matchList[indexPath.row]
        let betKeyList = buyModel.matchList.filter({ $0.match.id == match.id }).first?.betKeyList ?? []
    
        var cell: JclqTableCellProtocol!
        switch playType {
        case .bb_sf:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jclqSfTableCell, for: indexPath)!
        case .bb_rfsf:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jclqRfsfTableCell, for: indexPath)!
        case .bb_dxf:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jclqDxfTableCell, for: indexPath)!
        case .bb_sfc:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jclqSfcTableCell, for: indexPath)!
            (cell as! JclqSfcTableCell).moreBtnActionBlock = {
                [weak self] _ in
                self?.showAllBet(match: match, betKeyList: betKeyList, playType: .bb_sfc)
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jclqHhTableCell, for: indexPath)!
            (cell as! JclqHhTableCell).moreBtnActionBlock = {
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
            me.jclqData.matchGroupList[section].isExpand = !group.isExpand
            me.matchGroupList = me.filterMatchGroupList(matchGroupList: me.jclqData.matchGroupList)
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

// MARK:- JclqAllBetDialogViewControllerDelegate
extension JclqMainViewController: JclqAllBetDialogViewControllerDelegate {
    func jclqAllBetDialogViewControllerConfirmButtonClick(_ ctrl: JclqAllBetDialogViewController, match: JclqMatchModel, betKeyList: [JclqBetKeyType]) {
        if !buyModel.matchList.contains(where: { $0.match.id == match.id }) && buyModel.matchList.count >= 15 {
            TSToast.showText(view: ctrl.view, text: "最多选择15场比赛")
            return
        }
        buyModel.changeBetKeyList(match: match, betKeyList: betKeyList)
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }
    func jclqAllBetDialogViewControllerCancelButtonClick(_ ctrl: JclqAllBetDialogViewController) {
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
    }
}

// MARK:- SLLeagueFilterViewControllerDelegate
extension JclqMainViewController: SLLeagueFilterViewControllerDelegate {

    func leagueFilterViewControllerConfirmButtonClick(_ ctrl: SLLeagueFilterViewController, selectedLeagueList: [SportLotteryLeagueModel]) {
        
        jclqData.selectedLeagueList = selectedLeagueList
        matchGroupList = filterMatchGroupList(matchGroupList: jclqData.matchGroupList)
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
extension JclqMainViewController: SLChooseTipBottomViewDelegate {

    func chooseTipBottomViewNextButtonClick(_ bottomView: SLChooseTipBottomView) {
        if buyModel.allAllowSerialList.isEmpty {
            TSToast.showText(view: view, text: "请选择至少2场赛事或者1场单关")
            return
        }

        let ctrl = JclqConfirmViewController()
        ctrl.buyModel = buyModel
        ctrl.delegate = self
        navigationController?.pushViewController(ctrl, animated: true)
    }

    func chooseTipBottomViewClearButtonClick(_ bottomView: SLChooseTipBottomView) {
        buyModel.clearMatchList()
    }
}

// MARK:- SLConfirmViewControllerDelegate
extension JclqMainViewController: SLConfirmViewControllerDelegate {

    func confirmViewControllerDidChangeBuyModel<MatchModel, BetType>(_ ctrl: SLConfirmViewController<MatchModel, BetType>, buyModel: SLBuyModel<MatchModel, BetType>) where MatchModel : SLMatchModelProtocol, BetType : SLBetKeyProtocol {
        self.buyModel = buyModel as! SLBuyModel<JclqMainViewController.MatchModel, JclqMainViewController.BetType> //as! SLBuyModel<MatchModel, BetType>
    }
}

extension JclqMainViewController {
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
}
