//
//  BaseTabBarController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 自定义tabbar
class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        initListener()
        initTabBarControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseTabBarController {
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginViewController), name: UserNotification.userShouldLogin.notification, object: nil)
    }
    
    private func initTabBarControllers() {
        let ctrls = [BaseNavigationController(rootViewController: R.storyboard.forecast.forecastController()!),
                    BaseNavigationController(rootViewController: R.storyboard.user.userCenterViewController()!)]
        let titles = ["预测", "我的"]
        let defaultImages = [R.image.tabBar.forecast_default(), R.image.tabBar.personal_default()]
        let selectedImages = [R.image.tabBar.forecast_selected(), R.image.tabBar.personal_default()]
        for (index, ctrl) in ctrls.enumerated() {
            ctrl.tabBarItem = UITabBarItem(title: titles[index], image: defaultImages[index], selectedImage: selectedImages[index])
        }
        tabBar.tintColor = UIColor.navigationBarTint
        viewControllers = ctrls
        selectedIndex = 0
    }
    
}

// MARK:- notification
extension BaseTabBarController {
    
    /// 显示登录页
    @objc func showLoginViewController() {
        /// 删除极光别名
        let seq = random(min: 10_000_000, max: 99_999_999)
        JPUSHService.deleteAlias({
            (iResCode, iAlias, seq) in
            log.info("删除别名成功")
        }, seq: seq)
        
        let ctrl = UIStoryboard(name: "UserLogin", bundle: nil).instantiateInitialViewController()
        self.selectedViewController?.present(ctrl!, animated: true, completion: nil)
    }
    
    
    /// 推送
    func didReceiveRemoteNotification(_ notify: Notification) {
        guard let userInfo = (notify as NSNotification).userInfo else {
            return
        }
        let helper = NotificationHelper(apnsUserInfo: userInfo as [NSObject: AnyObject])
        
        func pushToViewController() {
            
        }
        
        if helper.applicationState == .inactive || helper.applicationState == .background || helper.isLaunched {
            pushToViewController()
        } else {
            CRToast.showNotification(with: "点击查看", message: helper.alertMessage, duration: nil, tapBlock: {
                type in
                pushToViewController()
            })
        }
    }
}
