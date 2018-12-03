//
//  UITextFieldExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UITextField {
    /// 占位符（先要设定placeholder）
    ///
    /// - Parameters:
    ///   - placeholder: 占位字符串
    ///   - color: 字体颜色
    ///   - font: 字体大小
    public func placeholder(color: UIColor? = nil, font: CGFloat? = nil) {
        let placeholder = self.placeholder ?? ""
        let placeholderString = NSMutableAttributedString(string: placeholder)
        if let font = font {
            placeholderString.addAttribute(.font, value: UIFont.systemFont(ofSize: font), range: NSRange(location: 0, length: placeholder.count))
        }
        if let color = color {
            placeholderString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: placeholder.count))
        }
        attributedPlaceholder = placeholderString
    }
        
}
