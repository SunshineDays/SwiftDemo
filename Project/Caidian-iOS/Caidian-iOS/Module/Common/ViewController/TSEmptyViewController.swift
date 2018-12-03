//
//  TSEmptyViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 包含空数据
class TSEmptyViewController: BaseViewController {
    
    /// 请求是否失败
    var isRequestFailed = false
    /// 是否已经载入数据
    var isLoadData = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 从网络获取数据
    func getData() {
        fatalError("子类必须实现此方法")
    }
}

extension TSEmptyViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        
        if isRequestFailed {
            return TSEmptyDataViewHelper.dzn_retryButtonAttributedString(for: state)
        }
        return TSEmptyDataViewHelper.dzn_emptyDataAttributedString()
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if isRequestFailed {
            getData()
        }
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
