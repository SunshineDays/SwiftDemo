//
//  BaseCollectionView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/26.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// base
class BaseCollectionView: UICollectionView {

}

extension BaseCollectionView: UIGestureRecognizerDelegate {
    
    /// 配合BaseNavigationController侧滑返回
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cls = NSClassFromString("UILayoutContainerView"), let v = otherGestureRecognizer.view, v.isKind(of: cls) {
            if otherGestureRecognizer.state == UIGestureRecognizerState.began && contentOffset.x == 0 {
                return true
            }
        }
        return false
    }
}
