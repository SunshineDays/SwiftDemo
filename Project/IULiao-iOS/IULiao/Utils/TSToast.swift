//
//  Toast.swift
//  HuaXia
//
//  Created by tianshui on 15/10/14.
// 
//

import Foundation
import CRToast
import MBProgressHUD

/// 文字颜色 和 背景颜色
enum TSToastColorStyle {
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

/// 对 CRToast进行封装
class TSToast {
    
    class func showNotificationWithOptions(_ options: [AnyHashable: Any], completionBlock completion: (() -> Void)? = nil) {
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, completionBlock: completion)
    }
    
    class func showNotificationWithOptions(_ options: [AnyHashable: Any], apperanceBlock appearance: (() -> Void)? = nil, completionBlock completion: (() -> Void)? = nil) {
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, apperanceBlock: appearance, completionBlock: completion)
    }
    
    /**
    显示文字通知
    - parameter message:    消息内容
    - parameter colorStyle: 颜色样式
    - parameter duration:   持续时间
    - parameter completion: 关闭时回调
    */
    class func showNotificationWithMessage(_ message: String, colorStyle:  TSToastColorStyle = .error, duration: TimeInterval = 2.1, completionBlock completion: (() -> Void)? = nil) {
        let options: [AnyHashable: Any] = [
            kCRToastTextKey            : message,
            kCRToastTimeIntervalKey    : NSNumber(value: duration),
            kCRToastBackgroundColorKey : colorStyle.backgroundColor,
            kCRToastTextColorKey       : colorStyle.textColor,
        ]
        CRToastManager.dismissAllNotifications(false)
        CRToastManager.showNotification(options: options, completionBlock: completion)
    }
    
    /**
     显示文字通知
     - parameter message:    消息内容
     - parameter colorStyle: 颜色样式
     - parameter duration:   持续时间 nil值不会自动消失
     - parameter completion: 消失回调
     - parameter tap:        点击回调
     */
    class func showNotificationWithTitle(_ title: String, message: String? = nil, colorStyle:  TSToastColorStyle = .warning, duration: TimeInterval? = 2.0, completionBlock completion: (() -> Void)? = nil, tapBlock tap:((CRToastInteractionType) -> Void)? = nil) {
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
    @discardableResult
    class func hudTextLoad(view: UIView,text: String?, mode: MBProgressHUDMode,margin: CGFloat, duration: TimeInterval) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = mode
        hud.isUserInteractionEnabled = false
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.detailsLabel.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 15)
        hud.bezelView.color = UIColor.black
        hud.margin = margin
        hud.removeFromSuperViewOnHide = true
        if duration > 1 {
            hud.hide(animated: true, afterDelay: duration)
        }
        return hud
    }
    class func hudNormalLoad(view: UIView,text: String?)-> MBProgressHUD{
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.label.text = text
//        hud.backgroundView.style = .blur
        return hud
    }
}

/// 弹窗
class FBProgressHUD: NSObject {
    /// 显示提示信息
    class func showInfor(text: String) {
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.superview?.backgroundColor = UIColor(hex: 0x323232)
        hud.margin = 10
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: Double(text.count) * 0.05 + 1.0)
    }
    
    ///  显示成功信息
    class func showSuccessInfor(text: String) {
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = .customView
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.superview?.backgroundColor = UIColor(hex: 0x323232)
        hud.contentColor = UIColor.white
        hud.margin = 15
        let imageView = UIImageView(image: R.image.fbRecommend2.resultSuccess())
        hud.customView = imageView
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: Double(text.count) * 0.05 + 1.0)
    }
    
    /// 显示加载动画
    class func showProgress(to view: UIView = UIApplication.shared.keyWindow!, text: String? = nil) {
        //如果已经存在弹窗，关闭旧弹窗
        MBProgressHUD.hide(for: view, animated: true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = false
        hud.margin = 20
        // 当弹窗隐藏时，从父视图中移除
        hud.removeFromSuperViewOnHide = true
        if text != nil {
            hud.mode = .indeterminate
            hud.label.text = text
            hud.label.numberOfLines = 0
            hud.label.font = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// 隐藏弹窗
    class func isHidden(from view: UIView = UIApplication.shared.keyWindow!) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
