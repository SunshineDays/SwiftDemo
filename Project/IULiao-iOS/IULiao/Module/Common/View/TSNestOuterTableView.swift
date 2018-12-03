//
// Created by tianshui on 2017/11/30.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

/// 多个tableView嵌套 外层tableView
class TSNestOuterTableView: UITableView, UIGestureRecognizerDelegate {

    /// 忽略手势
    var ignoreGestureRecognizers = [UIGestureRecognizer]()

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if ignoreGestureRecognizers.contains(otherGestureRecognizer) {
            return false
        }
        return true
    }
}

/// 多个tableView嵌套 内层tableView需要实现协议
protocol TSNestInnerScrollViewProtocol: class {

    var scroller: UIScrollView { get }

    var didScroll: ((_ scroller: UIScrollView) -> Void)? { get set }

}
