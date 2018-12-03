//
//  BaseNavigationController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD

/// navigationController基类
class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.setBackgroundImage(UIColor.navigationBarTintColor.colorToImage(), for: .default)
        navigationBar.tintColor = UIColor.white
        setNaviBarApperence()
    }

    deinit {
        log.info("deinit ---------- " + description)
    }
    
    private func setNaviBarApperence() {
        WRNavigationBar.wr_widely()
        // 设置导航栏默认的背景颜色
        WRNavigationBar.wr_setDefaultNavBarBarTintColor(UIColor.navigationBarTintColor)
        // 设置导航栏标题默认颜色
        WRNavigationBar.wr_setDefaultNavBarTitleColor(UIColor.white)
        // 设置导航栏左右按钮的默认颜色
        WRNavigationBar.wr_setDefaultNavBarTintColor(UIColor.white)
        // 是否隐藏底部分割线
        WRNavigationBar.wr_setDefaultNavBarShadowImageHidden(false)
        UIApplication.shared.statusBarStyle = .lightContent
    }

}

extension BaseNavigationController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.tabBarController?.tabBar.isHidden = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

