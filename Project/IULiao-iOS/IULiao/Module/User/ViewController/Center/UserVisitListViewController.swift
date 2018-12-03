//
//  UserVisitListViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftyJSON
import CRToast


/// 足迹列表
class UserVisitListViewController: TSListViewController {
    
    /// 列表请求
    var userVisitHandler = UserVisitHandler()
    var modlue = UserVisitType.news
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        firstRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension UserVisitListViewController {
    func initView() {
        tableView.register(UINib(nibName: NewsListCellType.ordinary.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewsListCellType.ordinary.cellIdentifier)
        tableView.mj_header?.lastUpdatedTimeKey = "UserVisitListViewControllerLastUpdatedTimeKey"
        userVisitHandler.delegate = self
        tableView.snp.updateConstraints{ (make) in
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)

        }
    }
    
    /// 载入数据
    override func loadData(_ page: Int) {
        userVisitHandler.visit(module: modlue, page: page, pageSize: pageInfo.pageSize)
    }
    
}

// MARK:- tableview
extension UserVisitListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        // 列表
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCellType.ordinary.cellIdentifier, for: indexPath) as! NewsOrdinaryCell
        let news = dataSource[row]
        if news is NewsModel {
            cell.configCell(news: news as! NewsModel)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let id = tableView.cellForRow(at: indexPath)?.tag {
            if modlue == .news {
                let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
                navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
}

/// MARK:- NewsListHandlerDelegate
extension UserVisitListViewController: UserVisitHandlerDelegate {
    
    func userVisitHandler(_ handler: UserVisitHandler, module: UserVisitType, didFetchedList list: [BaseModelProtocol], pageInfo: TSPageInfoModel) {
        if self.pageInfo.isFirstPage() {
            // 第一页直接赋值
            self.pageInfo.pageCount = pageInfo.pageCount
            self.pageInfo.dataCount = pageInfo.dataCount
            dataSource = list
        } else {
            dataSource += list
        }
        
        tableView.reloadData()
        endRefreshing(isSuccess: true)
    }
    
    func userVisitHandler(_ handler: UserVisitHandler, didError error: NSError) {
        TSToast.showNotificationWithMessage(error.localizedDescription)
        endRefreshing(isSuccess: false)
    }
}

