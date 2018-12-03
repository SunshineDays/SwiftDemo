//
//  UserViewController.swift
//  IULiao
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: TSNotification.userShouldLogin.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: TSNotification.userLoginSuccessful.notification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectRootViewController), name: TSNotification.userLogoutSuccessful.notification, object: nil)
    }
    
    @objc func selectRootViewController() {
        var ctrl: UIViewController
        
        if UserToken.shared.isLogin {
            // 已登录
            print("已登录")
            ctrl = R.storyboard.user.userCenter()!
        } else {
            // 未登录
            ctrl = R.storyboard.user.userIntro()!
        }
        setViewControllers([ctrl], animated: false)
        
    }
}
