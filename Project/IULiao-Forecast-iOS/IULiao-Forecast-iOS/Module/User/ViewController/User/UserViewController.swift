//
//  UserViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户中心 入口
class UserViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initListener()
        selectRootViewController()
    }
   

}

// MARK:- method
extension UserViewController {
    
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: UserNotification.userShouldLogin.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: UserNotification.userLoginSuccessful.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: UserNotification.userLogoutSuccessful.notification, object: nil)
    }
    
    @objc func selectRootViewController() {
        var ctrl: UIViewController
        
        if UserToken.shared.isLogin {
            // 已登录
            ctrl = storyboard!.instantiateViewController(withIdentifier: "UserCenter")
        } else {
            // 未登录
            ctrl = storyboard!.instantiateViewController(withIdentifier: "UserIntro")
        }
        setViewControllers([ctrl], animated: false)
        
    }
}
