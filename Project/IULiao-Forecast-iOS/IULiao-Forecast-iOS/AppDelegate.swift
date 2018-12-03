//
//  AppDelegate.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 16/7/5.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window?.rootViewController = BaseTabBarController()
        
        // 去除 NavigationController返回时头部出现灰色阴影
        window?.backgroundColor = UIColor.white
        
        AppRegister().registerApp(application: application, launchOptions: launchOptions)
        
        // 键盘不需要标题
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        // 点击背景自动隐藏键盘
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 200
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
        } else {
            // Fallback on earlier versions
        }
        return true
    }
        
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    // 将要展示
    func applicationWillEnterForeground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.resetBadge()
        /// 系统设置跳转回来改变设置状态
        NotificationCenter.default.post(name: UserNotification.userNotificationUpdate.notification, object: nil)
        
        let didEnterBackgroundTime = UserDefaults.standard.double(forKey: InfoSettingKey.didEnterBackgroundTime)
        // 后台进来，超过30min，发送刷新的通知
        print(didEnterBackgroundTime)
        print(Foundation.Date().timeIntervalSince1970)
        if Foundation.Date().timeIntervalSince1970 > didEnterBackgroundTime + 30 * 60 {
            NotificationCenter.default.post(name: UserNotification.refreshCurrentCtrl.notification, object: nil)
        }
    }
    
    // 从前台退出
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.resetBadge()
        UserDefaults.standard.set(Foundation.Date().timeIntervalSince1970, forKey: InfoSettingKey.didEnterBackgroundTime)
        UserDefaults.standard.synchronize()
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        return result
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册极光推送
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        log.error("注册通知失败")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Required, iOS 7 Support
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        if #available(iOS 10.0, *) {
            
        } else {
            if UIApplication.shared.applicationState == .active { //app在前台
            } else { //app在后台
                UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - 系统推送
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 前台
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.sound.rawValue | UNNotificationPresentationOptions.alert.rawValue | UNNotificationPresentationOptions.badge.rawValue))
    }
    
    //后台
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
    }
    
}


