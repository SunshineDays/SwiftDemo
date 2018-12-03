//
//  UserPlanOrderMainController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 我的计划单
class UserPlanOrderMainController: TSEmptyViewController {
    
    @IBOutlet weak var buyMoneyLabel: UILabel!
    
    @IBOutlet weak var bonusLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let planOrderListHandler = UserPlanOrderListHandler()
    
    private var pageInfoModel: PageInfoModel!
    
    private var dataSource = [UserPlanOrderBigPlanListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        navigationItem.title = "我的计划单"
        initView()
        initNetwork()
    }
    
}

extension UserPlanOrderMainController {
    private func initView() {
        
        tableView.register(R.nib.planOrderMainCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
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
        getUserOrderListData()
    }
    
    
    @objc func headerRefresh() {
        getUserOrderListData()
    }
    
    @objc func footerRefresh() {
        if !dataSource.isEmpty {
            getUserOrderListData(page: pageInfoModel.page + 1)
        }
        else {
            tableView.mj_footer.endRefreshing()
        }
    }
}

extension UserPlanOrderMainController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderMainCell, for: indexPath)!
        cell.configCell(withUserPlanOrder: dataSource[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178 - 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 24 : 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ctrl = R.storyboard.userPlanOrderList.userPlanOrderListController()!
        let model = dataSource[indexPath.section]
        ctrl.planId = model.planModel.planID
        ctrl.navigationItem.title = model.planModel.title
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
}

extension UserPlanOrderMainController {
    private func getUserOrderListData(page: Int = 1) {
        planOrderListHandler.userPlanOrderBigPlanList(page: page, pageSize: 20, success: { [weak self] (totalModel, list, pageInfoModel) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            self?.buyMoneyLabel.text = totalModel.totalBuyMoney.moneyText()
            self?.bonusLabel.text = totalModel.totalBonus.moneyText(2)
            self?.pageInfoModel = pageInfoModel
            if page == 1 {
                self?.dataSource.removeAll()
            }
            self?.dataSource = (self?.dataSource ?? []) + list
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()
            if self?.dataSource.count == 0 || pageInfoModel.dataCount == self?.dataSource.count {
                self?.tableView.mj_footer.isHidden = true
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.mj_footer.isHidden = false
                self?.tableView.mj_footer.endRefreshing()
            }
        }) { [weak self] (error) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}
