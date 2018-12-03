//
//  UIImageViewExt.swift
//  IULiao
//
//  Created by tianshui on 2017/11/10.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    /// 设置图片圆角
    ///
    /// - Parameter radius: 圆角大小
    func setImageCorner(radius: CGFloat) {
        image = image?.drawRectCorner(radius: radius, size: bounds.size)
    }
}
