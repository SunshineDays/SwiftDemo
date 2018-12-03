//
//  UserOrderBuyListViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import MJRefresh
import DZNEmptyDataSet

/// 购彩记录
class UserOrderBuyListViewController: TSEmptyViewController {

    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private let handler = UserOrderBuyHandler()
    private var orderData = [[UserSingleOrderModel]]()
    private var sectionData = [String]()
    var buyType: OrderBuyType = OrderBuyType.all {
        didSet {
            pageInfo.resetPage()
        }
    }
    private var pageInfo = TSPageInfoModel(page: 1)
    private var listData = [UserSingleOrderModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        tableView.mj_header.beginRefreshing()

    }

    /// 解决分隔线不到边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }

    override func getData() {
        handler.buyList(
                buyType: buyType,
                page: pageInfo.page,
                pageSize: pageInfo.pageSize,
                sinceTime: nil,
                success: {
                    data in
                    self.pageInfo = data.pageInfo
                    self.sectionData.removeAll()
                    self.orderData.removeAll()
                    if (self.pageInfo.isFirstPage()) {
                        self.listData.removeAll()
                        if self.pageInfo.hasMorePage() {
                            self.tableView.mj_footer.isHidden = false
                        }
                    }

                    self.listData += data.list

                    self.listData.forEach {
                        it in
                        let dateString = TSUtils.timestampToString(it.buy.buyTime, withFormat: "yyyy-MM-dd", isIntelligent: false)
                        if (self.sectionData.contains(dateString)) {
                            self.orderData[self.sectionData.index(of: dateString)!].append(it)

                        } else {
                            self.sectionData.append(dateString)
                            self.orderData.append([it])
                        }
                    }
                    self.isLoadData = true
                    self.isRequestFailed = false
                    self.tableView.reloadData()
                    self.tableView.mj_header.endRefreshing()
                    if self.pageInfo.hasMorePage() {
                        self.tableView.mj_footer.endRefreshing()
                        self.tableView.mj_footer.isHidden = false

                    } else {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        self.tableView.mj_footer.isHidden = true
                    }

                },
                failed: {
                    error in
                    self.isLoadData = false
                    self.isRequestFailed = true
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.mj_footer.endRefreshing()
                })
    }
}

extension UserOrderBuyListViewController {
    func initView() {
        func initSegmentedControl() {
            segmentedControl.backgroundColor = UIColor.white
            segmentedControl.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.grayGamut.gamut333333,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            segmentedControl.selectedTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.logo,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            segmentedControl.selectedSegmentIndex = OrderBuyType.allTabs.index(of: buyType) ?? 0
            segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            segmentedControl.selectionIndicatorColor = UIColor.logo
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.selectionIndicatorColor = UIColor.logo
            segmentedControl.selectionIndicatorHeight = 1.5
            segmentedControl.selectionStyle = .fullWidthStripe
            segmentedControl.sectionTitles = OrderBuyType.allTabs.map {
                $0.name
            }
            segmentedControl.indexChangeBlock = {
                [weak self] index in
                self?.buyType = OrderBuyType.allTabs[index]
                self?.listData.removeAll()
                self?.getData()
            }
        }

        func initTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self

            tableView.tableFooterView = UIView()
            let headerView = BaseRefreshHeader()
            headerView.setRefreshingTarget(self, refreshingAction: #selector(self.refreshListener))
            tableView.mj_header = headerView
            let footerView = BaseRefreshAutoFooter()
            footerView.isHidden = true
            footerView.setRefreshingTarget(self, refreshingAction: #selector(self.loadListener))
            tableView.mj_footer = footerView

        }

        initTableView()
        initSegmentedControl()
    }


    @objc func refreshListener() {
        pageInfo.resetPage()
        getData()

    }

    @objc func loadListener() {
        pageInfo.nextPage()
        getData()
    }
}

extension UserOrderBuyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return orderData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData[section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userBuyListTableViewCell, for: indexPath)!
        let userSingleOrderModel: UserSingleOrderModel = self.orderData[indexPath.section][indexPath.row]
        cell.configCell(userSingleOrderModel: userSingleOrderModel)
        cell.tag = userSingleOrderModel.buy.id
        return cell

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = R.nib.userBuyListSectionView.firstView(owner: self)!
        view.setDate(date: sectionData[section])
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let id = tableView.cellForRow(at: indexPath)?.tag {
            let ctrl = TSEntryViewControllerHelper.orderDetailViewController(buyId: id)
            navigationController?.pushViewController(ctrl, animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
