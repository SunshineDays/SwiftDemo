//
// Created by levine on 2018/5/8.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import MJRefresh

/// 同一设置加载更多布局文字
class BaseRefreshAutoFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        setTitle("上拉可以加载更多", for: MJRefreshState.idle)
        setTitle("松开立即加载", for: MJRefreshState.pulling)
        setTitle("正在加载...", for: MJRefreshState.refreshing)
        setTitle("", for: MJRefreshState.noMoreData)
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.textColor = UIColor.grayGamut.gamut999999
    }
}

//class BaseRefreshNoMoreFooter: MJRefreshAutoNormalFooter {
//    override func prepare() {
//        super.prepare()
//        setTitle("上拉可以加载更多", for: MJRefreshState.idle)
//        setTitle("松开立即加载", for: MJRefreshState.pulling)
//        setTitle("正在加载...", for: MJRefreshState.refreshing)
//        setTitle("", for: MJRefreshState.noMoreData)
//        stateLabel.font = UIFont.systemFont(ofSize: 12)
//        stateLabel.textColor = UIColor.grayGamut.gamut999999
//
//    }
//}
