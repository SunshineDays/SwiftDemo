//
//  BaseScrollView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// base
class BaseScrollView: UIScrollView {
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delaysContentTouches = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delaysContentTouches = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delaysContentTouches = false
    }
    
}

extension BaseScrollView: UIGestureRecognizerDelegate {
    
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

