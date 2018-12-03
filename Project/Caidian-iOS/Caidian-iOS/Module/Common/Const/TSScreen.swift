//
//  Created by tianshui on 15/6/29.
// 
//

import Foundation
import UIKit

/// 屏幕尺寸
struct TSScreen {
    
    /// iPhone 5,5s 宽度 与 4,4s相同
    static let iPhone5Width: CGFloat = 320
    
    /// iPhone 5,5s 高度
    static let iPhone5Height: CGFloat = 568
    
    /// iPhone 6 宽度
    static let iPhone6Width: CGFloat = 375
    
    /// iPhone 6 高度
    static let iPhone6Height: CGFloat = 667
    
    /// iPhone 6p 宽度
    static let iPhone6PlusWidth: CGFloat = 414
    
    /// iPhone 6p 高度
    static let iPhone6PlusHeight: CGFloat = 736

    /// iPhone X 宽度
    static let iPhoneXWidth: CGFloat = 375
    
    /// iPhone X 高度
    static let iPhoneXHeight: CGFloat = 812
    
    /// 当前宽度
    static var currentWidth: CGFloat { return UIScreen.main.bounds.size.width }
    
    /// 当前高度
    static var currentHeight: CGFloat { return UIScreen.main.bounds.size.height }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    
    /// navBar高度 不存在则为0
    static func navigationBarHeight(ctrl: UIViewController) -> CGFloat {
        if ctrl.navigationController?.navigationBar.isHidden == false {
            return ctrl.navigationController?.navigationBar.frame.height ?? 0
        }
        return 0
    }
    
    /// tabBar高度 不存在则为0
    static func tabBarHeight(ctrl: UIViewController) -> CGFloat {
        if ctrl.hidesBottomBarWhenPushed {
            return 0
        }
        return ctrl.tabBarController?.tabBar.frame.height ?? 0
    }

    /// point 转 px
    static func pointToPX(point:CGFloat) -> CGFloat{
        return point / UIScreen.main.scale
    }
    
}
