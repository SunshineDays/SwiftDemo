//
// Created by tianshui on 2017/11/2.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


/// 空数据view helper
class TSEmptyDataViewHelper: NSObject {
    
    /// 创建重试 button
    ///
    /// - Parameter title:
    /// - Returns:
    static func createRetryButton(title: String = "加载失败,请重试") -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(hex: 0xff8b19), for: .normal)
        btn.setTitleColor(UIColor(hex: 0xff8b19, alpha: 0.3), for: .highlighted)
        btn.contentHorizontalAlignment = .center
        btn.contentVerticalAlignment = .center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }

    
    /// DZNEmptyDataSet的 重试button
    ///
    /// - Parameters:
    ///   - state:
    ///   - title:
    /// - Returns:
    static func dzn_retryButtonAttributedString(for state: UIControlState, title: String = "加载失败,请重试") -> NSAttributedString {
        var attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        if state == .normal {
            attributes[.foregroundColor] = TSColor.logo
        } else if state == .highlighted {
            attributes[.foregroundColor] = TSColor.logo.withAlphaComponent(0.3)
        }
        return NSAttributedString(string: title, attributes: attributes)
    }

    
    /// DZNEmptyDataSet的 空数据
    ///
    /// - Parameter title:
    /// - Returns:
    static func dzn_emptyDataAttributedString(title: String = "暂无数据") -> NSAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray,
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }

    override init() {
        super.init()
    }
    
}
