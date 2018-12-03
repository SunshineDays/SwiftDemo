//
//  NSLayoutConstraintExt.swift
//  IULiao
//
//  Created by tianshui on 2017/10/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    /// 精确的像素约束
    @IBInspectable var pixelConstant: Int {
        get {
            return Int(constant * UIScreen.main.scale)
        }
        set {
            constant = CGFloat(newValue) / UIScreen.main.scale
        }
    }
}
