//
//  UITableViewExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/19.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 结束刷新（数据请求成功）
    ///
    /// - Parameters:
    ///   - dataSource: tableView数据源
    ///   - pageInfo: PageInfoModel
    func endRefreshing(dataSource: [Any]?, pageInfo: PageInfoModel) {
        mj_header.endRefreshing()
        if dataSource?.isEmpty ?? true || dataSource?.count == pageInfo.dataCount {
            mj_footer.isHidden = true
            mj_footer.endRefreshingWithNoMoreData()
        } else {
            mj_footer.isHidden = false
            mj_footer.endRefreshing()
        }
    }
    
    /// 结束刷新（数据请求失败）
    func endRefreshing() {
        mj_header.endRefreshing()
        mj_footer.endRefreshing()
    }
}
