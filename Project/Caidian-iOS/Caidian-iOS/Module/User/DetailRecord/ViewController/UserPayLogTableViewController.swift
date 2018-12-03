//
//  UserPayLogTableViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import MJRefresh
import ActionSheetPicker_3_0
import DZNEmptyDataSet


/// 账户明细
class UserPayLogTableViewController: TSEmptyTableViewController {

    private let handler = UserAccountHandler()
    private var page = 1
    private var sinceTime: TimeInterval? = Date().timeIntervalSince1970 - 7 * 24 * 60 * 60
    private let pickerData = ["近一周", "近一个月", "近三个月"]
    private var initPosition = 0
    private var inOutType = InOutType.none {
        didSet {
            page = 1
        }
    }
    private var moneyType = MoneyType.none {
        didSet {
            page = 1
        }
    }

    var payLogList: [UserPayLogCellModel] = [UserPayLogCellModel]()

    override func getData() {
        initData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        tableView.mj_header.beginRefreshing()
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payLogList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userOrderPayLogTableViewCell, for: indexPath)!

        cell.configCell(payLogCellModel: payLogList[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tradeIdArr: [TradeIdType] = [.puTongGouMaiCaipiao, .zhuiHaoGouMaiCaiPiao, .yongHuTiKuanZhiChu, .tikuanFailureMoney]
        if tradeIdArr.contains(payLogList[indexPath.row].tradeId) {
            switch payLogList[indexPath.row].tradeId {
            case TradeIdType.tikuanFailureMoney,
                 TradeIdType.yongHuTiKuanZhiChu:
                let ctrl = R.storyboard.user.userWithdrawListViewController()!
                self.navigationController?.pushViewController(ctrl, animated: true)

           default:
                let ctrl = TSEntryViewControllerHelper.orderDetailViewController(buyId: self.payLogList[indexPath.row].resourceId)
                self.navigationController?.pushViewController(ctrl, animated: true)




            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        let tradeIdArr: [TradeIdType] = [.puTongGouMaiCaipiao, .zhuiHaoGouMaiCaiPiao, .yongHuTiKuanZhiChu, .tikuanFailureMoney]
        return tradeIdArr.contains(payLogList[indexPath.row].tradeId)
    }
}

extension UserPayLogTableViewController {
    func initView() {
        viewDidLayoutSubviews()
        tableView.tableFooterView = UIView()
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshListener))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadListener))
        tableView.mj_footer = footer
        footer.isHidden = true
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self

    }

    func initActionSheetPicker() {
        let actionSheetPicker = ActionSheetCustomPicker(title: "请选择查询方式", delegate: self, showCancelButton: true, origin: view)!
        actionSheetPicker.toolbarButtonsColor = UIColor.logo
        actionSheetPicker.setDoneButton(UIBarButtonItem(title: "确定", style: .done, target: self, action: nil))
        actionSheetPicker.setCancelButton(UIBarButtonItem(title: "取消", style: .plain, target: self, action: nil))
        actionSheetPicker.show()
    }

    func initData() {
        handler.getAccountPayLog(
                inOut: inOutType,
                moneyType: moneyType,
                page: page,
                pageSize: 20,
                sinceTime: sinceTime,
                success: {
                    payLogList, pageInfo in
                    self.isLoadData = true
                    self.isRequestFailed = false
                    self.payLogList = payLogList
                    self.tableView.mj_header.endRefreshing()
                    if pageInfo.pageCount > 1 {
                        self.tableView.mj_footer.isHidden = false
                    }
                    if self.page >= pageInfo.pageCount {
                        self.tableView.mj_footer.isHidden = true
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    } else {
                        self.tableView.mj_footer.isHidden = false
                        self.tableView.mj_footer.endRefreshing()
                    }
                    self.tableView.reloadData()
                },
                failed: {
                    error in
                    self.isLoadData = false
                    self.isRequestFailed = true
                    self.tableView.mj_footer.endRefreshing()

                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })
    }

    @objc func refreshListener() {
        page = 1
        initData()
    }

    @objc func loadListener() {
        page += 1
        initData()
    }

    @IBAction func chooseBarButton(_ sender: UIBarButtonItem) {
        initActionSheetPicker()
    }


}

extension UserPayLogTableViewController: ActionSheetCustomPickerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        pickerView.selectRow(initPosition, inComponent: 0, animated: false)
    }

    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
//        if sinceTime == nil {
//            sinceTime = Date().timeIntervalSince1970 - 7 * 24 * 60 * 60
//        }
        tableView.mj_header?.beginRefreshing()
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initPosition = row
        switch row {
        case 0:
            sinceTime = Date().timeIntervalSince1970 - 7 * 24 * 60 * 60
        case 1:
            sinceTime = Date().timeIntervalSince1970 - 30 * 24 * 60 * 60
        default: sinceTime = nil

        }
    }


}



