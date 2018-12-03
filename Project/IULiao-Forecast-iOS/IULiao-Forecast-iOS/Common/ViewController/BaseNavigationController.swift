//
//  BaseNavigationController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit

/// navigationcontroller基类
class BaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 左右侧按钮颜色
        navigationBar.tintColor = UIColor.white
        
        // title 属性
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // #0091FF
        navigationBar.barTintColor = UIColor.navigationBarTint
        navigationBar.isTranslucent = false
        
        navigationBar.shadowImage = UIImage()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        log.info("deinit")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.tabBarController?.tabBar.isHidden = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return children.count > 1
    }
}

