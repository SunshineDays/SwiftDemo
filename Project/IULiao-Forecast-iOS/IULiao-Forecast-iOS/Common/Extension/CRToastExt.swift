//
//  CRToastExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/21.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 顶部提示弹窗
extension CRToast {
    
    class func showNotification(with options: [AnyHashable: Any], completionBlock completion: (() -> Void)? = nil) {
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, completionBlock: completion)
    }
    
    class func showNotification(with options: [AnyHashable: Any], apperanceBlock appearance: (() -> Void)? = nil, completionBlock completion: (() -> Void)? = nil) {
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, apperanceBlock: appearance, completionBlock: completion)
    }

    /// 显示文字通知(用我吧^_^)
    ///
    /// - Parameters:
    ///   - message: 消息内容
    ///   - colorStyle: 颜色样式
    ///   - duration: 持续时间
    ///   - completion: 关闭时回调
    class func showNotification(with message: String, colorStyle: ToastColorStyle = .error, duration: TimeInterval = 2.1, completionBlock completion: (() -> Void)? = nil) {
        let options: [AnyHashable: Any] = [
            kCRToastTextKey            : message,
            kCRToastTimeIntervalKey    : NSNumber(value: duration),
            kCRToastBackgroundColorKey : colorStyle.backgroundColor,
            kCRToastTextColorKey       : colorStyle.textColor,
            ]
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, completionBlock: completion)
    }
    
    ///  显示文字通知
    ///
    /// - Parameters:
    ///   - title: 消息内容
    ///   - message: 消息内容
    ///   - colorStyle: 颜色样式
    ///   - duration: 持续时间 nil值不会自动消失
    ///   - completion: 消失回调
    ///   - tap: 点击回调
    class func showNotification(with title: String, message: String? = nil, colorStyle:  ToastColorStyle = .warning, duration: TimeInterval? = 2.0, completionBlock completion: (() -> Void)? = nil, tapBlock tap:((CRToastInteractionType) -> Void)? = nil) {
        var options: [AnyHashable: Any] = [
            kCRToastTextKey            : title,
            kCRToastBackgroundColorKey : colorStyle.backgroundColor,
            kCRToastTextColorKey       : colorStyle.textColor,
            ]
        if let duration = duration {
            options[kCRToastTimeIntervalKey] = NSNumber(value: duration)
        } else {
            options[kCRToastTimeIntervalKey] = NSNumber(value: Double.infinity)
        }
        if let message = message {
            options[kCRToastSubtitleTextKey] = message
        }
        if let tap = tap {
            options[kCRToastInteractionRespondersKey] = [CRToastInteractionResponder(interactionType: .tapOnce, automaticallyDismiss: true, block: tap)]
        }
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, completionBlock: completion)
    }
    
}

/// 文字颜色 和 背景颜色
enum ToastColorStyle {
    case `default`
    case success
    case error
    case warning
    case primary
    case info
    case custom(textColor: UIColor, backgroundColor: UIColor)
    
    /// 背景颜色
    var backgroundColor: UIColor {
        let alpha: CGFloat = 1.0
        var color = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: alpha)
        switch self {
        case .default:
            color = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: alpha)
        case .success:
            color = UIColor(red: 94 / 255, green: 185 / 255, blue: 94 / 255, alpha: alpha)
        case .primary:
            color = UIColor(red: 14 / 255, green: 144 / 255, blue: 210 / 255, alpha: alpha)
        case .error:
            color = UIColor(red: 221 / 255, green: 81 / 255, blue: 76 / 255, alpha: alpha)
        case .warning:
            color = UIColor(red: 243 / 255, green: 123 / 255, blue: 29 / 255, alpha: alpha)
        case .info:
            color = UIColor(red: 59 / 255, green: 180 / 255, blue: 242 / 255, alpha: alpha)
        case .custom(_, let backgroundColor):
            color = backgroundColor
        }
        return color
    }
    
    /// 文字颜色
    var textColor: UIColor {
        switch self {
        case .default:
            return UIColor.gray
        case .custom(let textColor, _):
            return textColor
        default:
            return UIColor.white
        }
    }
}
