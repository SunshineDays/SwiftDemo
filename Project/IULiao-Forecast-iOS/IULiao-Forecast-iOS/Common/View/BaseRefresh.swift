//
//  BaseRefresh.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/17.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 同一设置下来刷新文字
class BaseRefreshHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        setTitle("下拉可以刷新", for: MJRefreshState.idle)
        setTitle("松开立即刷新", for: MJRefreshState.pulling)
        setTitle("正在刷新...", for: MJRefreshState.refreshing)
        lastUpdatedTimeLabel.isHidden = true
    }
}

/// 同一设置加载更多布局文字
class BaseRefreshAutoFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        setTitle("上拉可以加载更多", for: MJRefreshState.idle)
        setTitle("松开立即加载", for: MJRefreshState.pulling)
        setTitle("正在加载...", for: MJRefreshState.refreshing)
        setTitle("", for: MJRefreshState.noMoreData)
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.textColor = UIColor(hex: 0x999999)
        isHidden = true
    }
}
