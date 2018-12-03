//
//  CopyOrderViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/18.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import MJRefresh
import DZNEmptyDataSet

/// 复制跟单
class CopyOrderViewController: TSEmptyViewController {

    private var tableView = UITableView()
    
    private let handler = CopyOrderHandler()
    private var pageInfo = TSPageInfoModel(page: 1, pageSize: 20)
    private var tableViewDataSource = [CopyOrderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.groupTableViewBackground
        extendedLayoutIncludesOpaqueBars = true
        initView()
        pageInfo.resetPage()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter:UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }

    @objc private func refreshData() {
        tableView.mj_header.beginRefreshing()
    }
    
    override func getData() {
        
        handler.getCopyOrderList(
            page: pageInfo.page,
            pageSize: pageInfo.pageSize,
            success: { copyOrderList, pageInfo in
                
                if pageInfo.isFirstPage() {
                    self.tableViewDataSource.removeAll()
                    if pageInfo.hasMorePage() {
                        self.tableView.mj_footer.isHidden = false
                    }
                }
                if pageInfo.hasMorePage() {
                    self.tableView.mj_footer.endRefreshing()
                    self.tableView.mj_footer.isHidden = false

                } else {
                    self.tableView.mj_footer.isHidden = true
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.isLoadData = true
                self.isRequestFailed = false
                self.tableView.mj_header.endRefreshing()
                
                if pageInfo.isFirstPage() {
                    self.tableViewDataSource += copyOrderList
                } else { //不是第一页，过滤掉重复的数组
                    if self.pageInfo.page == pageInfo.page {
                        for _ in (pageInfo.page - 1) * pageInfo.pageSize ..< self.tableViewDataSource.count {
                            self.tableViewDataSource.removeLast()
                        }
                    }
                    
                    self.tableViewDataSource += copyOrderList
                    
                    let lists: NSMutableArray = NSMutableArray(array: self.tableViewDataSource)
                    
                    for (index1, model1) in lists.enumerated() {
                        for (index2, model2) in lists.enumerated() {
                            if index1 != index2 {
                                if (model1 as! CopyOrderModel).id == (model2 as! CopyOrderModel).id {
                                    if (model1 as! CopyOrderModel).followMoney <= (model2 as! CopyOrderModel).followMoney {
                                        lists.remove(model1)
                                    } else {
                                        lists.remove(model2)
                                    }
                                }
                            }
                        }
                    }
                    for model in lists {
                        if (model as! CopyOrderModel).endTime < Date().timeIntervalSince1970 {
                            lists.remove(model)
                        }
                    }
                    self.tableViewDataSource = lists as! [CopyOrderModel]
                }

                self.tableView.reloadData()
                self.pageInfo = pageInfo
            },
            failed: {
                error in
                self.isLoadData = false
                self.isRequestFailed = true
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                self.tableView.reloadData()
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
    }
}

/// MARK: - Method
extension CopyOrderViewController {
    private func initView() {

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(ctrl: self) - TSScreen.statusBarHeight - TSScreen.tabBarHeight(ctrl: self)), style: .plain)
        
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshListener))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreListener))
        footer.isHidden = true
        tableView.mj_footer = footer
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.homeTableViewThreeCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0

        if #available(iOS 11.0, *) {
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(tableView)
    }
    
    
    @objc func refreshListener() {
        pageInfo.resetPage()
        getData()

    }

    @objc func loadMoreListener() {
        pageInfo.nextPage()
        getData()
    }
}

// MARK: - UITableView
extension CopyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UITableViewCell.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeTableViewThreeCell, for: indexPath)! as HomeTableViewThreeCell
        cell.configCell(copyOrderModel: tableViewDataSource[indexPath.row])
        cell.followOrderBlock = { btn in
            let ctrl = CopyOrderDetailViewController()
            ctrl.hidesBottomBarWhenPushed = true
            ctrl.orderId = self.tableViewDataSource[indexPath.row].orderId
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.avatarBlock = { sender in
            let vc = R.storyboard.copyOrder.userCopyOrderDetailController()!
            vc.initWith(userId: self.tableViewDataSource[indexPath.row].userId)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctrl = CopyOrderDetailViewController()
        ctrl.hidesBottomBarWhenPushed = true
        ctrl.orderId = tableViewDataSource[indexPath.row].orderId
        navigationController?.pushViewController(ctrl, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

