//
//  BaseTableViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/5.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// UITableViewController基类
class BaseTableViewController: UITableViewController {
    
    /// 请求是否成功
    private var isRequestSuccess = true
    
    /// 子类调用(请求成功和失败都需要调用)
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - isRequestSuccess: 请求成功与否
    public func tableView(forEmptyDataSet isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
        tableView?.emptyDataSetDelegate = self
        tableView?.emptyDataSetSource = self
        tableView?.reloadData()
    }
    
    func getData() {
        fatalError("子类必须实现此方法")
    }
    
    @objc func refreshData() {
        fatalError("子类实现此方法，一定是需要后台返回来刷新当前界面")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: UserNotification.refreshCurrentCtrl.notification, object: nil)
    }
    
    deinit {
        log.info("deinit ---------- " + description)
        NotificationCenter.default.removeObserver(self)
        MBProgressHUD.hide(from: view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return isRequestSuccess ? EmptyRequestType.noData.image : EmptyRequestType.error.image
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return isRequestSuccess ? EmptyRequestType.noData.title : EmptyRequestType.error.title
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true // 是否可以滚动
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if !isRequestSuccess { getData() }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if !isRequestSuccess { getData() }
    }
}

