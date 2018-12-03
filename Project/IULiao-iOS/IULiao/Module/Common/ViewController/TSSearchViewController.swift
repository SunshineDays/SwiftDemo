//
//  TSSearchViewController.swift
//  HuaXia
//
//  Created by tianshui on 16/2/26.
// 
//

import Foundation
import UIKit

class TSSearchViewController: TSListViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    /// 关键字
    var keyword: String? {
        get {
            return self.searchController.searchBar.text
        }
        set {
            self.searchController.searchBar.text = newValue
        }
    }
    
    private var lastKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_after_time(0) { () -> Void in
            if self.keyword == "" {
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}


// MARK:- method
extension TSSearchViewController {
    
    func initView() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = baseNavigationBarTintColor
        
        tableView.mj_header = nil
        
        emptyLable.text = "无搜索结果"
        
        navigationItem.titleView = searchController.searchBar
    }
    
    /// tableview滚动到最顶部
    func tableViewScrollToTop(_ animated: Bool) {
        self.tableView.setContentOffset(CGPoint(x: 0, y: -self.topLayoutGuide.length), animated: animated)
    }
}

// MARK:- UISearchResultsUpdating
extension TSSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if lastKeyword != keyword {
            loadData(1)
        }
        lastKeyword = keyword
    }
}

// MARK:- UISearchBarDelegate
extension TSSearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pageInfo.page = 1
    }
}
