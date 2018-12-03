//
//  Created by tianshui on 15/6/29.
// 
//

import Foundation
import UIKit

/// 屏幕尺寸
struct Screen {
    
    ///  iPhone屏幕宽度
    static let iPhoneWidth = (five:   CGFloat(320),
                              sex:    CGFloat(375),
                              plus:   CGFloat(414),
                              x:      CGFloat(375),
                              xsMax:  CGFloat(414),
                              xr:     CGFloat(414))
    
    /// iPhone屏幕高度
    static let iPhoneHeight = (five:  CGFloat(568),
                               sex:   CGFloat(667),
                               plus:  CGFloat(736),
                               x:     CGFloat(812),
                               xsMax: CGFloat(896),
                               xr:    CGFloat(414))
    
    /// 当前宽度
    static var currentWidth: CGFloat { return UIScreen.main.bounds.size.width }
    
    /// 当前高度
    static var currentHeight: CGFloat { return UIScreen.main.bounds.size.height }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    
    /// naviBar高度(加上状态栏)
    static var navigationHeight: CGFloat = statusBarHeight + 44
    
    /// tabBar高度(加上底部空白)
    static var tabBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height == 44 ? 83 : 49
    
    /// tabBar距离底部的距离
    static var tabBarBottomMargin: CGFloat = UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
    
    /// naviBar高度 不存在则为0
    static func navigationBarHeight(_ ctrl: UIViewController) -> CGFloat {
        if ctrl.navigationController?.navigationBar.isHidden == false {
            return ctrl.navigationController?.navigationBar.frame.height ?? 0
        }
        return 0
    }
    
    /// tabBar高度 不存在则为0
    static func tabBarHeight(_ ctrl: UIViewController) -> CGFloat {
        if ctrl.hidesBottomBarWhenPushed {
            return 0
        }
        return ctrl.tabBarController?.tabBar.frame.height ?? 0
    }
}
