//
//  PublicHelper.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/19.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 工具类
class PublicHelper: NSObject {
    /// 彩色字符串
    class func attributedString(texts: [String], fonts: [UIFont]? = nil, colors: [UIColor]) -> NSAttributedString {
        let result = NSMutableAttributedString()
        for (index, text) in texts.enumerated() {
            var attribute: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index]]
            if let fonts = fonts {
                attribute[.font] = fonts[index]
            }
            let str = NSAttributedString(string: text, attributes: attribute)
            result.append(str)
        }
        return result
    }
}

extension PublicHelper {
    ///  获取rootViewController
    class func rootViewController() -> (AnyObject) {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewController?.isKind(of: UINavigationController.self))! {
            rootViewController = (rootViewController as? UINavigationController)?.viewControllers.first
        }
        if (rootViewController?.isKind(of: UITabBarController.self))! {
            rootViewController = (rootViewController as? UITabBarController)?.selectedViewController
        }
        return rootViewController!
    }
    
    /// 返回到前面的控制器
    class func popToViewController(_ count: Int) {
        let navigationController: UINavigationController = rootViewController() as! UINavigationController
        let viewControllers = navigationController.viewControllers
        navigationController.popToViewController(viewControllers[viewControllers.count - 1 - count], animated: true)
    }
}
