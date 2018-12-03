//
//  PlanOrderDetailViewController.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 计划跟单 详情页
class PlanOrderDetailViewController: TSEmptyViewController {

    private let planOrderHandler: PlanOrderHandler = PlanOrderHandler()
    var planDetailId = 5

    @IBOutlet weak var tabViewBottomConstraint: NSLayoutConstraint!

    var pageInfo = TSPageInfoModel(page: 1, pageSize: 20)
    private var list = [PlanOrderFollowAccountModel]()

    private var tabViewData = [Int]()
    @IBOutlet weak var tabView: UITableView!

    var bottomView = R.nib.planOrderDetailBottomView.firstView(owner: nil)!
    var tableHeaderView = R.nib.planOrderDetailHeaderView.firstView(owner: nil)!
    var tableFooterView = R.nib.planOrderDetailFooterView.firstView(owner: nil)!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "方案详情"
        initView()
        requestPlanOrderDetail()
        requestPlanOrderFollowAccount()
    }
}


/// 初始化view
extension PlanOrderDetailViewController {

    func initView() {
        if #available(iOS 11.0, *) {
            tabView.contentInsetAdjustmentBehavior = .never
        }
        
        automaticallyAdjustsScrollViewInsets = false
        
        tableFooterView.moreBtn.addTarget(self, action: #selector(loadMore), for: UIControlEvents.touchUpInside)
        bottomView.planOrderBtn.addTarget(self, action: #selector(buyPlanOrder), for: UIControlEvents.touchUpInside)
        
        initTableHeaderView()
        initTabFooterView()
        
        tabView.delegate = self
        tabView.dataSource = self
        tabView.emptyDataSetDelegate = self
        tabView.emptyDataSetSource = self
        
        
    }

    /// 初始化tableHeaderView
    func initTableHeaderView() {
        let uiView = UIView()
        uiView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: tableHeaderView.getHeight())
        uiView.addSubview(tableHeaderView)
        tabView.tableHeaderView = uiView
    }

    func initTabFooterView() {
        let uiView = UIView()
        uiView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: tableFooterView.deafaultTabFooterViewHeight)
        uiView.addSubview(tableFooterView)
        tabView.tableFooterView = uiView
    }

    /// 底部是否显示
    func initBottomView() {
        
        self.view.addSubview(bottomView)
        tabViewBottomConstraint.constant = bottomView.bottomViewHeight

        bottomView.snp.makeConstraints {
            maker in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(bottomView.bottomViewHeight)

            if #available(iOS 11.0, *) {
                maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                maker.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
            }
        }
    }

    ///加载跟多
    @objc func loadMore() {
        pageInfo.nextPage()
        requestPlanOrderFollowAccount()

    }

    /// 购买计划单
    @objc func buyPlanOrder() {

        requestAccountDetail()
    }

}

extension PlanOrderDetailViewController {
    
    /// 用户信息
    func requestAccountDetail()  {
        UIApplication.shared.keyWindow?.endEditing(true)
            /// 购买逻辑 先检查是否登录 -> 检查金额是否足够 (不足够 显示去充值 else 显示购买框)
        UserInfoHandler().accountDetail(
            success: {
                acountModel  in
                //  金额是否足够
                if (acountModel.balance + acountModel.reward) >= Double(self.bottomView.multiple * 2){
                    Alert().alertView(
                        controller: self,
                        message:  "确认购买 \(self.bottomView.multiple) 份,\(self.bottomView.multiple * 2) 元",
                        cancelAction:  {},
                        okAction: {
                            self.requestPlanOrderBuy()
                        }
                    )

                }else{
                    Alert().alertView(
                        controller: self,
                        message:  "去充值",
                        cancelAction: {},
                        okAction: {
                            let ctrl = R.storyboard.user.userRechargeViewController()!
                            self.navigationController?.pushViewController(ctrl, animated: true)
                      }
                    )
                    
                }
             },
            failed: {
                error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
            }
        )
    }


    /// 计划单跟单用户

    func requestPlanOrderFollowAccount() {

        TSToast.showLoading(view: self.view)
        planOrderHandler.planOrderDetailFollowAccount(
                planDetailId: planDetailId,
                page: pageInfo.page,
                pageSize: pageInfo.pageSize,
                success: {
                    modelList, pageInfoModel in
                    self.pageInfo = pageInfoModel
                    if pageInfoModel.isFirstPage() {
                        self.list.removeAll()
                    }
                    self.isLoadData = true
                    self.isRequestFailed = false
                    self.list += modelList
                    self.tabView.reloadData()

                    self.tableFooterView.configView(planOrderFollowAccountModelList: modelList, page: self.pageInfo.page, pageModel: pageInfoModel)
                     TSToast.hideHud(for:self.view)

                },
                failed: {
                    error in
                    self.isLoadData = false
                    self.isRequestFailed = true
                     TSToast.hideHud(for:self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                }
        )
    }

    // 计划单详情
    func requestPlanOrderDetail() {
        planOrderHandler.planOrderDetail(
                planDetailId: planDetailId,
                success: {

                    planModel, planOrderDetailModel, planOrderFollowAccountModelList in
                    
                    self.tableHeaderView.configView(
                        uiViewController: self,
                        planModel: planModel,
                        planDetailModel: planOrderDetailModel,
                        planOrderFollowAccountModelList: planOrderFollowAccountModelList
                    )
                    
                    self.initTableHeaderView()

                   // 未截止 还可购买
                    if planOrderDetailModel.saleEndTime >= NSDate().timeIntervalSince1970 {
                        self.initBottomView()
                    }
                    
                   
                },
                failed: {
                    error in
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                }
        )
    }

    // 计划单购买
    func requestPlanOrderBuy() {
        self.bottomView.planOrderBtn.isEnabled = false
        TSToast.showLoading(view: view)

        planOrderHandler.planOrderBuy(
                planDetailId: planDetailId,
                money: Double(bottomView.multiple) * 2.00,
                success: {
                    accountModel, planOrderFollowAccountModel in
                   
                    self.bottomView.planOrderBtn.isEnabled = true
                    
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text:"购买成功")
                                        self.requestPlanOrderDetail()
                    self.requestPlanOrderFollowAccount()
                    NotificationCenter.default.post(name: TSNotification.buySuccess.notification, object: self)
                },
                failed: {
                    error in
                    self.bottomView.planOrderBtn.isEnabled = true
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                }
        )
    }
}                    


extension PlanOrderDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(R.nib.copyOrderAccountTableViewCell)
        let cell = tabView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.copyOrderAccountTableViewCell, for: indexPath)! as CopyOrderAccountTableViewCell
        cell.configCell(planOrderFollowAccountModel: list[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
     
        if tabView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tabView.separatorInset = UIEdgeInsets.zero
        }
        if tabView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tabView.layoutMargins = UIEdgeInsets.zero
        }
    }
    



}
