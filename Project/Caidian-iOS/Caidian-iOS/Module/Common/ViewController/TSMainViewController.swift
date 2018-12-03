//
//  ViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/9/23.
// 
//

import UIKit

/// 主tabBar
class TSMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initListener()

#if DEBUG
        let displayMode = UserDefaults.standard.string(forKey: TSSettingKey.debugDisplayMode) ?? "develop"
        if displayMode == "production" {
            production()
        } else {
            development()
        }
#else
        production()
#endif

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension TSMainViewController {

    func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(TSMainViewController.showLoginViewController), name: TSNotification.userShouldLogin.notification, object: nil)
    }

    func production() {
        let homeNavCtrl = BaseNavigationController(rootViewController: R.storyboard.home.home3ViewController()!)
        let recommendNavCtrl = BaseNavigationController(rootViewController: R.storyboard.recommend.recommendMainController()!)
        let planOrderNavCtrl = BaseNavigationController(rootViewController: PlanOrderMainController())
        let liveNavCtrl = BaseNavigationController(rootViewController: LiveWebViewController())
        let userNavCtrl = R.storyboard.user.userNav()!
        
        homeNavCtrl.tabBarItem = UITabBarItem(title: "购彩大厅", image: R.image.tabBar.home(), selectedImage: R.image.tabBar.homeS())
        recommendNavCtrl.tabBarItem = UITabBarItem(title: "推荐", image: R.image.tabBar.copy(), selectedImage: R.image.tabBar.copyS())
        planOrderNavCtrl.tabBarItem = UITabBarItem(title: "计划跟单",
                                                   image: R.image.tabBar.plan()?.withRenderingMode(.alwaysOriginal),
                                                   selectedImage: R.image.tabBar.planS()?.withRenderingMode(.alwaysOriginal))
        planOrderNavCtrl.tabBarItem .setTitleTextAttributes([.foregroundColor : UIColor(rgba: "d99025")], for: .normal)
        planOrderNavCtrl.tabBarItem .setTitleTextAttributes([.foregroundColor :UIColor.logo], for: .selected)
        liveNavCtrl.tabBarItem = UITabBarItem(title: "比分", image: R.image.tabBar.live(), selectedImage: R.image.tabBar.liveS())
        userNavCtrl.tabBarItem = UITabBarItem(title: "我的", image: R.image.tabBar.user(), selectedImage: R.image.tabBar.userS())
        
        viewControllers = [homeNavCtrl, recommendNavCtrl, planOrderNavCtrl, liveNavCtrl, userNavCtrl]
        tabBar.tintColor = UIColor.logo
        selectedIndex = 0
    }

    func development() {
        let homeNavCtrl = BaseNavigationController(rootViewController: R.storyboard.home.home3ViewController()!)
        let recommendNavCtrl = BaseNavigationController(rootViewController: R.storyboard.recommend.recommendMainController()!)
        let planOrderNavCtrl = BaseNavigationController(rootViewController: PlanOrderMainController())
        let liveNavCtrl = BaseNavigationController(rootViewController: LiveWebViewController())
        let userNavCtrl = R.storyboard.user.userNav()!

        homeNavCtrl.tabBarItem = UITabBarItem(title: "购彩大厅", image: R.image.tabBar.home(), selectedImage: R.image.tabBar.homeS())
        recommendNavCtrl.tabBarItem = UITabBarItem(title: "推荐", image: R.image.tabBar.copy(), selectedImage: R.image.tabBar.copyS())
        planOrderNavCtrl.tabBarItem = UITabBarItem(title: "计划跟单",
                                                   image: R.image.tabBar.plan()?.withRenderingMode(.alwaysOriginal),
                                           selectedImage: R.image.tabBar.planS()?.withRenderingMode(.alwaysOriginal))
        planOrderNavCtrl.tabBarItem .setTitleTextAttributes([.foregroundColor : UIColor(rgba: "d99025")], for: .normal)
        planOrderNavCtrl.tabBarItem .setTitleTextAttributes([.foregroundColor :UIColor.logo], for: .selected)
        liveNavCtrl.tabBarItem = UITabBarItem(title: "比分", image: R.image.tabBar.live(), selectedImage: R.image.tabBar.liveS())
        userNavCtrl.tabBarItem = UITabBarItem(title: "我的", image: R.image.tabBar.user(), selectedImage: R.image.tabBar.userS())

        viewControllers = [homeNavCtrl, recommendNavCtrl, planOrderNavCtrl, liveNavCtrl, userNavCtrl]
        tabBar.tintColor = UIColor.logo
        selectedIndex = 0
    }

}

// MARK:- notification
extension TSMainViewController {

    /// 显示登录页
    @objc func showLoginViewController() {
        let ctrl = UIStoryboard(name: "UserLogin", bundle: nil).instantiateInitialViewController()
        self.selectedViewController?.present(ctrl!, animated: true, completion: nil)
    }
}

