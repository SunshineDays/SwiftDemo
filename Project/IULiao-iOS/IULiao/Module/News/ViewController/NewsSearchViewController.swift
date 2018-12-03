//
//  NewsSearchViewController.swift
//  IULiao
//
//  Created by tianshui on 16/7/6.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

enum NewsSearchType: String {
    /// 标签
    case tag      = "tag"
    
    /// 分类
    case category = "categorys"
    
    /// 搜索
    case none     = ""
}

class NewsSearchViewController: TSSearchViewController {
    
    private let newsOrdinaryCellIdentifier = "NewsOrdinaryCell"
    
    var newsListHandler = NewsListHandler()
    var newsSearchType: NewsSearchType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsListHandler.delegate = self
        
        self.tableView.register(UINib(nibName: newsOrdinaryCellIdentifier, bundle: nil), forCellReuseIdentifier: newsOrdinaryCellIdentifier)
        
        if newsSearchType != NewsSearchType.none {
            self.loadData(1)
        } else {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK:- method
extension NewsSearchViewController {
    
    override func loadData(_ page: Int) {
        if keyword != nil && keyword != "" {
            newsListHandler.searchNewsListWithKeyword(keyword!, type: newsSearchType, page: page, pageSize: pageInfo.pageSize)
        }
    }
    
}

// MARK:- tableview
extension NewsSearchViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsOrdinaryCellIdentifier, for: indexPath) as! NewsOrdinaryCell
        let news = dataSource[(indexPath as NSIndexPath).row]
        cell.configCell(news: news as! NewsModel)
        return cell
    }
    
    // tableview点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.resignFirstResponder()
        if let id = tableView.cellForRow(at: indexPath)?.tag {
            let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK:- NewsListHandlerDelegate
extension NewsSearchViewController: NewsListHandlerDelegate {
    
    func newsListHandler(_ handler: NewsListHandler, didFetchedList list: [NewsModel], andPageInfo pageInfo: TSPageInfoModel) {
        // 新开个线程
        let queue = DispatchQueue.global()
        queue.async {
            if self.pageInfo.isFirstPage() {
                // 第一页直接赋值
                self.pageInfo.pageCount = pageInfo.pageCount
                self.pageInfo.dataCount = pageInfo.dataCount
                self.dataSource = list
            } else {
                // 其他页要判断是否有重复
                var lists = list as [NewsModel]
                let min = max(self.dataSource.count - pageInfo.pageSize, 0)
                for i in min..<self.dataSource.count {
                    let news = self.dataSource[i] as! NewsModel
                    if lists.contains(where: {$0.id == news.id}) {
                        if let index = lists.index(where: {$0.id == news.id}) {
                            lists.remove(at: index)
                        }
                    }
                }
                self.dataSource += lists as [BaseModelProtocol]
            }
            
            // 返回主线程
            DispatchQueue.main.async {
                // 互斥锁 原子操作 确保 该代码 有序进行
                objc_sync_enter(self)
                if self.pageInfo.isFirstPage(){
                    self.tableViewScrollToTop(false)
                }
                self.tableView.reloadData()
                self.endRefreshing(isSuccess: true)
                objc_sync_exit(self)
            }
        }
    }
    
    func newsListHandler(_ handler: NewsListHandler, didError error: NSError) {
        if error.code > 0 {
            TSToast.showNotificationWithMessage(error.localizedDescription)
        }
    }
    
}
