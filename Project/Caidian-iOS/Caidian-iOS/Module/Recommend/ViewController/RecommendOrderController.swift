//
//  RecommendOrderController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐首页
class RecommendOrderController: TSEmptyViewController {

    private var tableView = UITableView()
    
    private var recommendHandler = RecommendHandler()
    
    private var pageInfoModel = TSPageInfoModel(page: 1, pageSize: 20)
    
    private var dataSource = [RecommendOrderListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true

        initView()
        initNetwork()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }

    @objc private func refreshData() {
        tableView.mj_header.beginRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func getData() {
        recommendHandler.recommendList(page: pageInfoModel.page, pageSize: pageInfoModel.pageSize, success: { (list, pageInfoModel) in
            MBProgressHUD.hide(for: self.view,animated : true)
            self.isLoadData = true
            self.isRequestFailed = false
            
            if pageInfoModel.isFirstPage() {
                self.dataSource.removeAll()
            }
            
            if pageInfoModel.isFirstPage() {
                self.dataSource += list
            } else { /// 刷新数据，过滤重复的数据
                if self.pageInfoModel.page == pageInfoModel.page {
                    for _ in (pageInfoModel.page - 1) * pageInfoModel.pageSize ..< self.dataSource.count {
                        self.dataSource.removeLast()
                    }
                }
                self.dataSource += list
                
                let lists: NSMutableArray = NSMutableArray(array: self.dataSource)
                
                for (index1, model1) in lists.enumerated() {
                    for (index2, model2) in lists.enumerated() {
                        if index1 != index2 {
                            if (model1 as! RecommendOrderListModel).id == (model2 as! RecommendOrderListModel).id {
                                if (model1 as! RecommendOrderListModel).hits <= (model2 as! RecommendOrderListModel).hits {
                                    lists.remove(model1)
                                } else {
                                    lists.remove(model2)
                                }
                            }
                        }
                    }
                }
                for model in lists {
                    if (model as! RecommendOrderListModel).matchInfo.saleEndTime < Date().timeIntervalSince1970 {
                        lists.remove(model)
                    }
                }
                self.dataSource = lists as! [RecommendOrderListModel]
            }
            
            self.tableView.mj_header.endRefreshing()
            if self.dataSource.count == 0 || pageInfoModel.dataCount == self.dataSource.count {
                self.tableView.mj_footer.isHidden = true
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self.tableView.mj_footer.isHidden = false
                self.tableView.mj_footer.endRefreshing()
            }

            
            self.tableView.reloadData()
            self.pageInfoModel = pageInfoModel
            
        }) { (error) in
            MBProgressHUD.hide(for: self.view,animated: true)
            self.isLoadData = self.dataSource.count > 0
            self.isRequestFailed = true
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            TSToast.showText(view: self.view, text: error.localizedDescription)
        }
    }
    
}

extension RecommendOrderController {
    
    private func initView() {
        initTableView()
        initTableViewRefresh()
    }
    
    private func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(ctrl: self) - TSScreen.statusBarHeight - TSScreen.tabBarHeight(ctrl: self)), style: .plain)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(R.nib.recommendCell)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            //            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(tableView)
    }
    
    private func initTableViewRefresh() {
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isHidden = true
        tableView.mj_footer = footer
    }
    
    private func initNetwork() {
        MBProgressHUD.showProgress(toView: view)
        getData()
    }
    
    @objc func headerRefresh() {
        pageInfoModel.resetPage()
        getData()
    }
    
    @objc func footerRefresh() {
        if !dataSource.isEmpty {
            pageInfoModel.nextPage()
            getData()
        }
        else {
            tableView.mj_footer.endRefreshing()
        }
    }
}

extension RecommendOrderController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.recommendCell, for: indexPath)!
        let model = dataSource[indexPath.section]
        cell.configCell(model: model) { (sender) in
            let vc = R.storyboard.recommend.recommendExpertController()!
            vc.professorId = model.userId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecommendCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = R.storyboard.recommend.recommendDetailController()!
        vc.recommendId = dataSource[indexPath.section].id
        navigationController?.pushViewController(vc, animated: true)
    }
}



