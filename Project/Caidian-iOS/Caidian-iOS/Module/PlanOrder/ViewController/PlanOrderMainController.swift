//
//  PlanOrderMainController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/11.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 计划跟单 首页
class PlanOrderMainController: BaseTableViewController {

    private let planOrderHandler = PlanOrderHandler()
    
    private var pageInfoModel: PageInfoModel!

    private var dataSource = [PlanOrderBigPlanModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "计划跟单"
        view.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(R.nib.planOrderMainCell)
        tableView.tableFooterView = UIView()
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0

        extendedLayoutIncludesOpaqueBars = true
        
        initView()
//        initNetwork()
//        tableView.mj_header.beginRefreshing()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getPlanOrderListData(page: pageInfoModel != nil ? pageInfoModel.page : 1)
    }

    @objc private func refreshData() {
        tableView.mj_header.beginRefreshing()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderMainCell, for: indexPath)!
        cell.configCell(withPlanOrder: dataSource[indexPath.section])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.section]
        return model.buyModel.buyCount > 0 ? 178 : 178 - 48
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 24 : 12
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = R.storyboard.planOrder.planOrderViewController()!
        let model = dataSource[indexPath.section]
        vc.navigationItem.title = model.title
        vc.planId = model.planID
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension PlanOrderMainController {
    private func initView() {
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isHidden = true
        tableView.mj_footer = footer
    }
    
    private func initNetwork() {
        MBProgressHUD.showAdded(to: view, animated: true)
        getPlanOrderListData()
    }
    
    
    @objc func headerRefresh() {
        getPlanOrderListData()
    }
    
    @objc func footerRefresh() {
        if !dataSource.isEmpty {
            getPlanOrderListData(page: pageInfoModel.page + 1)
        }
        else {
            tableView.mj_footer.endRefreshing()
        }
    }
}

extension PlanOrderMainController {
    private func getPlanOrderListData(page: Int = 1) {
        planOrderHandler.planOrderBigPlanList(page: page, pageSize: 20, success: { [weak self] (list, pageInfoModel) in
            TSToast.hideHud(for: (self?.view)!)
            self?.pageInfoModel = pageInfoModel
            if page == 1 {
                self?.dataSource.removeAll()
            }
            self?.dataSource = (self?.dataSource ?? []) + list
            self?.tableView.mj_header.endRefreshing()
            if self?.dataSource.count == 0 || pageInfoModel.dataCount == self?.dataSource.count {
                self?.tableView.mj_footer.isHidden = true
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.mj_footer.isHidden = false
                self?.tableView.mj_footer.endRefreshing()
            }
            self?.tableView.reloadData()

        }) { [weak self] (error) in
            TSToast.hideHud(for: (self?.view)!)
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}

