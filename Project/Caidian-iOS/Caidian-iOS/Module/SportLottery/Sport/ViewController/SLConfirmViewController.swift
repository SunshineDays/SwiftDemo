//
//  SLBetConfirmViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/23.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

protocol SLConfirmViewControllerDelegate: class {

    /// 对阵改变
    func confirmViewControllerDidChangeBuyModel<MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol>(_ ctrl: SLConfirmViewController<MatchModel, BetType>, buyModel: SLBuyModel<MatchModel, BetType>)
}

/// 竞技彩 确认投注
class SLConfirmViewController<MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol>: BaseViewController, UITableViewDelegate, UITableViewDataSource  {

    var topView = SLConfirmTopView()
    var bottomView = SLConfirmBottomView()
    var tableView = UITableView()
    var maskView = UIView()
    private let topViewHeight: CGFloat = SLConfirmTopView.defaultHeight
    private var tableBoxView = UIView()
    // 44 + 36 + 40
    var bottomViewHeight: CGFloat = 120
    var buyModel = SLBuyModel<MatchModel, BetType>() {
        didSet {
            bottomView.multiple = buyModel.multiple
            bottomView.minBonus = buyModel.bonus.minBonus
            bottomView.maxBonus = buyModel.bonus.maxBonus
            bottomView.betCount = buyModel.betCount
            bottomView.totalMoney = Int(buyModel.totalMoney)
        }
    }
    weak var delegate: SLConfirmViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }


    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.confirmViewControllerDidChangeBuyModel(self, buyModel: buyModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func viewTap() {
        view.endEditing(true)
        view.becomeFirstResponder()
    }

    @objc private func maskViewTap() {
        view.becomeFirstResponder()
        bottomView.isExpandCollectionView = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyModel.matchList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let combination = buyModel.matchList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.slConfirmTableCell, for: indexPath)!
        cell.delegate = self
        cell.configCell(combination: combination, canSetMustBet: buyModel.mustBetCount<buyModel.allowMustBetCount)
        return cell
    }

    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }


}

// MARK:- method
extension SLConfirmViewController {

    private func initView() {

        do {
            automaticallyAdjustsScrollViewInsets = false
            view.backgroundColor = UIColor.white
            edgesForExtendedLayout = []
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
        }

        do {
            view.addSubview(topView)
            view.addSubview(tableBoxView)
            tableBoxView.addSubview(tableView)
            view.addSubview(maskView)
            view.addSubview(bottomView)
        }

        do {
            topView.delegate = self
            topView.snp.makeConstraints {
                make in
                if #available(iOS 11.0, *) {
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalTo(view.layoutMarginsGuide.snp.top)
                }
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(topViewHeight)
            }
        }
        
        do {
            tableBoxView.backgroundColor = UIColor(hex: 0xf2f2f2)
            tableBoxView.snp.makeConstraints {
                make in
                make.top.equalTo(topView.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-bottomViewHeight)
                } else {
                    make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-bottomViewHeight)
                }
            }
        }

        do {
            tableView.backgroundColor = UIColor.white
            tableView.cornerRadius = 10
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedRowHeight = 90
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = false
            tableView.register(R.nib.slConfirmTableCell)
            tableView.delegate = self
            tableView.dataSource = self

            tableView.snp.makeConstraints {
                make in
                let offset: CGFloat = 10
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset))
            }
        }

        do {
            bottomView.delegate = self
            bottomView.allSerialList = buyModel.allAllowSerialList
            bottomView.selectedSerialList = buyModel.selectedSerialList
            bottomView.snp.makeConstraints {
                make in
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
                }
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(bottomViewHeight)
            }
        }

        do {
            maskView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.3)
            maskView.isHidden = true
            maskView.snp.makeConstraints {
                make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-bottomViewHeight)
            }
            maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(maskViewTap)))
        }
    }

}

// MARK: SLConfirmTableCellDelegate
extension SLConfirmViewController: SLConfirmTableCellDelegate {

    func confirmTableCellDeleteButtonClick(_ cell: SLConfirmTableCell) {
        guard let indexPath = tableView.indexPath(for: cell), let match = buyModel.matchList[safe: indexPath.row]  else {
            return
        }

        buyModel.removeMatch(match.match)
        bottomView.allSerialList = buyModel.allAllowSerialList
        buyModel.resetMustBet()
        bottomView.selectedSerialList = buyModel.selectedSerialList
        tableView.deleteRows(at: [indexPath], with: .right)

        for i in 0..<buyModel.matchList.count {
            let combination = buyModel.matchList[i]
            (tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? SLConfirmTableCell)?.configCell(isMustBet: combination.isMustBet, canSetMustBet: buyModel.mustBetCount < buyModel.allowMustBetCount)
        }

    }

    func confirmTableCellMustBetButtonClick(_ cell: SLConfirmTableCell, isSelected: Bool) {
        guard let indexPath = tableView.indexPath(for: cell), let combination = buyModel.matchList[safe: indexPath.row]  else {
            return
        }
        buyModel.setMatchMustBet(match: combination.match, isMustBet: isSelected)
        tableView.reloadData()
    }
}

// MARK:- SLConfirmBottomViewDelegate
extension SLConfirmViewController: SLConfirmBottomViewDelegate {

    func confirmBottomViewNextButtonClick(_ bottomView: SLConfirmBottomView) {
        if buyModel.selectedSerialList.isEmpty {
            TSToast.showText(view: view, text: "请选择过关方式")
            return
        }
        if buyModel.betCount <= 0 {
            TSToast.showText(view: view, text: "注数不能为0")
            return
        }

        bottomView.nextBtn.isEnabled = false
        TSToast.showLoading(view: view)
        UserAccountHandler().getAccountDetail(
            success: {
                account in
                bottomView.nextBtn.isEnabled = true
                TSToast.hideHud(for: self.view)
                let ctrl = R.storyboard.lotteryBuy.lotteryBuyViewController()!
                ctrl.buyModel = self.buyModel
                self.navigationController?.pushViewController(ctrl, animated: true)
            },
            failed: {
                error in
                bottomView.nextBtn.isEnabled = true
                TSToast.hideHud(for: self.view)
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
    }

    func confirmBottomViewMultipleDidChange(_ bottomView: SLConfirmBottomView, multiple: Int) {
        buyModel.multiple = multiple
    }


    func confirmBottomViewSelectedSerialListDidChange(_ bottomView: SLConfirmBottomView, serialList: [SLSerialType]) {
        if serialList != buyModel.selectedSerialList {
            buyModel.resetMustBet()
            buyModel.selected(serialList: serialList)
            tableView.reloadData()
        }
    }

    func confirmBottomViewCollectionExpandDidChange(_ bottomView: SLConfirmBottomView, isExpand: Bool, realHeight: CGFloat) {
        maskView.isHidden = !isExpand
        bottomView.snp.updateConstraints {
            make in
            make.height.equalTo(realHeight)
        }
    }

    func confirmBottomViewSerialButtonWillClick(_ bottomView: SLConfirmBottomView) -> Bool {
        if buyModel.allAllowSerialList.isEmpty {
            TSToast.showText(view: view, text: "请选择至少2场赛事或者1场单关")
        }
        return !buyModel.allAllowSerialList.isEmpty
    }
}

// MARK:- SLConfirmTopViewDelegate
extension SLConfirmViewController: SLConfirmTopViewDelegate {

    func confirmTopViewAddMatchButtonClick(_ confirmView: SLConfirmTopView) {
        delegate?.confirmViewControllerDidChangeBuyModel(self, buyModel: buyModel)
        navigationController?.popViewController(animated: true)
    }

    func confirmTopViewDeleteMatchListButtonClick(_ confirmView: SLConfirmTopView) {
        let alert = UIAlertController(title: "清空列表", message: "确定清空已选投注？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .destructive) {
            action in
            self.buyModel.clearMatchList()
            self.delegate?.confirmViewControllerDidChangeBuyModel(self, buyModel: self.buyModel)
            alert.dismiss(animated: false, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

