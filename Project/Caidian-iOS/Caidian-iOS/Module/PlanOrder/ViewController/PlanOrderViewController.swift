//
//  PlanOrderViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/29.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

// 计划跟单 作者发布内容
class PlanOrderViewController: TSEmptyViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var planDetailModelList  =  [PlanOrderDetailModel]()
    private var pageInfo = TSPageInfoModel(page: 1, pageSize: 20)
    
    /// 计划单 id
    var planId = 1
    
    var  planOrderHandler: PlanOrderHandler = PlanOrderHandler()
    
    var planModel :PlanModel?
    
    var tableHeaderView = R.nib.planOrderHeaderView.firstView(owner: nil)!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        pageInfo.page = 1
//        getData()
        tableView.mj_header.beginRefreshing()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.buySuccess.notification, object: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if  !planDetailModelList.isEmpty {
//            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
//        }
//
//    }

    @objc private func refreshData() {
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.buySuccess.notification, object: nil)
    }

    override func getData() {
        planOrderHandler.planOrderHomeList(
            planId: self.planId,
            page: pageInfo.page,
            pageSize : pageInfo.pageSize,
            success: {
                (planOrderHomeModel) in
                self.tableView.tableHeaderView?.isHidden = false
                self.planModel = planOrderHomeModel.plan
                self.pageInfo = planOrderHomeModel.pageModel
                if planOrderHomeModel.pageModel.isFirstPage(){
                    self.planDetailModelList.removeAll()
                    if self.pageInfo.hasMorePage(){
                        self.tableView.mj_footer.isHidden = false
                    }
                }
                
                self.planDetailModelList += planOrderHomeModel.list
          
                
                if self.pageInfo.hasMorePage() {
                    self.tableView.mj_footer.endRefreshing()
                    self.tableView.mj_footer.isHidden = false
                } else {
                    self.tableView.mj_footer.isHidden = true
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                
                TSToast.hideHud(for: self.view)

                self.isLoadData = true
                self.tableView.mj_header.endRefreshing()
                self.isRequestFailed = false
                self.tableView.reloadData()
           
                self.tableHeaderView.configView(uiViewController: self,planModel: planOrderHomeModel.plan)
                self.tableHeaderView.authorBlock = {
                    let ctrl = R.storyboard.planOrder.planOrderAuthorOrderController()!
                    ctrl.planId = self.planId
                    UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(ctrl)
                    UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(ctrl.view)
                }
            },
            failed:{
                error in
                self.isLoadData = false
                self.isRequestFailed = true
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                TSToast.hideHud(for: self.view)
                self.tableView.reloadData()
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
           }
        )
    }

}

// MARK: - method
extension PlanOrderViewController {
    private func initView() {
        
        let  headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: tableHeaderView.defaultHeight)
        headerView.addSubview(tableHeaderView)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.isHidden = true
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self

        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
       

        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshListener))
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreListener))
        footer.isHidden = true
        tableView.mj_header = header
        tableView.mj_footer = footer
    }

    @objc func refreshListener() {
        pageInfo.resetPage()
        getData()
    }
    
    @objc func loadMoreListener() {
        pageInfo.nextPage()
        getData()
    }
    
    /// 页面跳转
    func startController(index:Int)  {
        let ctrl = TSEntryViewControllerHelper.planOrderDetailViewController(planDetailId: self.planDetailModelList[index].id)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

// MARK: - UITableView
extension PlanOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return planDetailModelList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if planDetailModelList.isEmpty {
            return UITableViewCell()
        }
        
        let planDetailModel = planDetailModelList[indexPath.section]
         // 计划单未截止
        if planDetailModel.saleEndTime  >= NSDate().timeIntervalSince1970 || planDetailModel.winStatus == OrderWinStatusType.notOpen{
            tableView.register(R.nib.planOrderCopyTableCell)
            let cell =  tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderCopyTableCell, for: indexPath)! as PlanOrderCopyTableCell
            cell.configView(planDetailModel : planDetailModel, planModel :planModel)

            cell.followBtnActionBlock = {
                btn in
                self.startController(index: indexPath.section)
            }
            return cell
        } else{
            // 计划单截止
            tableView.register(R.nib.planOrderOpenPrizeCell)
            let cell =  tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderOpenPrizeCell, for: indexPath)! as PlanOrderOpenPrizeCell
            cell.configView(planDetailModel : planDetailModel, planModel : planModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height : CGFloat = 191
        let planDetailModel = planDetailModelList[indexPath.section]
    
        var money = 0
        planDetailModel.buyList.forEach{
            money += $0.buyMoney
        }

        // 计划单未截止
        if planDetailModel.saleEndTime  >= NSDate().timeIntervalSince1970 || planDetailModel.winStatus == OrderWinStatusType.notOpen{
      
            if money == 0 {
                height = 190 - 41
            }else{
                height = 190
            }
        } else{
            // 计划单截止
            if money == 0 {
                height = 191 - 41
            }else{
                height = 191
            }
        }
        return height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.startController(index: indexPath.section)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}

//extension PlanOrderViewController {
//    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return isRequestFailed
//    }
//    
//    override func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
////        super.emptyDataSet(scrollView, didTap: didTap)
//        if isRequestFailed {
//              getData()
//              TSToast.showLoading(view: self.view)
//        }
//      
//    }
//
//}
