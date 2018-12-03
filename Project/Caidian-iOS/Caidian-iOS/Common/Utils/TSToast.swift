//
//  Toast.swift
//  HuaXia
//
//  Created by tianshui on 15/10/14.
// 
//

import Foundation
import MBProgressHUD

/// 对 CRToast进行封装
class TSToast {

    /// Toast 文字颜色 和 背景颜色
    enum ColorType {
        case `default`
        case success
        case error
        case warning
        case primary
        case info
        case custom(textColor: UIColor, backgroundColor: UIColor)

        /// 背景颜色
        var backgroundColor: UIColor {
            switch self {
            case .default: return UIColor(hex: 0x000000)
            case .success: return UIColor(hex: 0x5eff5e)
            case .primary: return UIColor(hex: 0x0e9015)
            case .error: return UIColor(hex: 0xd3514c)
            case .warning: return UIColor(hex: 0xf37b1d)
            case .info: return UIColor(hex: 0x3bb4f2)
            case .custom(_, let backgroundColor): return backgroundColor
            }
        }

        /// 文字颜色
        var textColor: UIColor {
            switch self {
            case .custom(let textColor, _): return textColor
            default: return UIColor.white
            }
        }
    }

    /// toast显示位置
    enum PositionType {
        case top
        case bottom
        case center
        case custom(offsetX: CGFloat, offsetY: CGFloat)
    }

    /// 静态方式 显示loading
    ///
    /// - Parameters:
    ///   - view:
    ///   - text: 文字
    ///   - duration: 持续时间
    /// - Returns:
    @discardableResult
    static func showLoading(view: UIView, text: String? = nil, duration: TimeInterval = 0) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.show(animated: true)
        hud.isUserInteractionEnabled = false
        hud.label.textColor = UIColor.white
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.detailsLabel.textColor = UIColor.white
        hud.contentColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 15)
        hud.bezelView.color = UIColor.black
        hud.mode = .indeterminate
        hud.margin = 20
        hud.removeFromSuperViewOnHide = true
        if duration > 0 {
            hud.hide(animated: true, afterDelay: duration)
        }
        return hud
    }
    
    /// 静态方法 显示text
    ///
    /// - Parameters:
    ///   - view:
    ///   - text: 文字
    ///   - color: 颜色样式
    ///   - position: 显示位置
    ///   - duration: 持续时间
    ///   - hiddenCompletion: 隐藏时回调
    /// - Returns:
    @discardableResult
    static func showText(view: UIView, text: String, color: ColorType = .default, position: PositionType = .bottom, duration: TimeInterval = 2, hiddenCompletion: (() -> Void)? = nil) -> MBProgressHUD {
        let hud = showLoading(view: view, text: text, duration: duration)
        hud.label.textColor = color.textColor
        hud.detailsLabel.textColor = color.textColor
        hud.contentColor = color.textColor
        hud.bezelView.color = color.backgroundColor
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.margin = 10
        hud.completionBlock = hiddenCompletion

        var offset: CGPoint!
        switch position {
        case .top: offset = CGPoint(x: 0, y: -view.height / 4)
        case .bottom: offset = CGPoint(x: 0, y: view.height / 4)
        case .center: offset = CGPoint.zero
        case let .custom(x, y): offset = CGPoint(x: x, y: y)
        }
        hud.offset = offset
        return hud
    }
    
    /// 隐藏hud
    static func hideHud(for view: UIView, animated: Bool = true) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
}

//extension MBProgressHUD {
//
//    /// 实例方式 显示loading
//    ///
//    /// - Parameters:
//    ///   - text: 文字
//    ///   - duration: 持续时间
//    /// - Returns:
//    @discardableResult
//    func showLoading(text: String? = nil, duration: TimeInterval = 0) -> MBProgressHUD {
//        show(animated: true)
//        isUserInteractionEnabled = false
//        label.textColor = UIColor.white
//        label.text = text
//        detailsLabel.textColor = UIColor.white
//        contentColor = UIColor.white
//        label.font = UIFont.systemFont(ofSize: 15)
//        detailsLabel.font = UIFont.systemFont(ofSize: 15)
//        bezelView.color = UIColor.black
//        removeFromSuperViewOnHide = false
//        mode = .indeterminate
//        margin = 20
//        if duration > 0 {
//            hide(animated: true, afterDelay: duration)
//        }
//        return self
//    }
//
//    /// 实例方法 显示text
//    ///
//    /// - Parameters:
//    ///   - text: 文字
//    ///   - duration: 持续时间
//    ///   - hiddenCompletion: 隐藏时回调
//    /// - Returns:
//    @discardableResult
//    func showText(text: String, duration: TimeInterval = 2, hiddenCompletion: MBProgressHUDCompletionBlock? = nil) -> MBProgressHUD {
//        showLoading(text: text, duration: duration)
//        mode = .text
//        margin = 10
//        completionBlock = hiddenCompletion
//        return self
//    }
//}

