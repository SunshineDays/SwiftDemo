//
// Created by levine on 2018/5/8.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import MJRefresh

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
