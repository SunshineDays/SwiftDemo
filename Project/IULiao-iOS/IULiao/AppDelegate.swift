//
//  AppDelegate.swift
//  IULiao
//
//  Created by tianshui on 16/7/5.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import CRToast
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.initOptions(launchOptions)
        // 键盘不需要标题
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        // 点击背景自动隐藏键盘
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
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
        NotificationCenter.default.post(name: TSNotification.userNotificationUpdate.notification, object: nil)
    }
    
    // 已经展示
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.resetBadge()
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
                UIApplication.shared.keyWindow?.rootViewController = TSMainViewController()
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// 初始化一些全局配置
    func initOptions(_ launchOptions: [AnyHashable: Any]?) {
        
        do {
            // 去除 NavigationController返回时头部出现灰色阴影
            window?.backgroundColor = UIColor.white
        }
        
        do {
            // toast
            let options: [AnyHashable: Any] = [
                kCRToastTimeIntervalKey                 : 2.0,
                kCRToastUnderStatusBarKey               : true,
                kCRToastStatusBarStyleKey               : UIStatusBarStyle.lightContent.rawValue,
                kCRToastNotificationTypeKey             : CRToastType.navigationBar.rawValue,
                kCRToastNotificationPresentationTypeKey : CRToastPresentationType.cover.rawValue,
                kCRToastAnimationInTypeKey              : CRToastAnimationType.linear.rawValue,
                kCRToastAnimationOutTypeKey             : CRToastAnimationType.linear.rawValue,
                kCRToastAnimationInDirectionKey         : CRToastAnimationDirection.top.rawValue,
                kCRToastAnimationOutDirectionKey        : CRToastAnimationDirection.top.rawValue
            ]
            CRToastManager.setDefaultOptions(options)
        }
        
        do {
            // 友盟 统计
            UMAnalyticsConfig.sharedInstance().appKey = kUmengAppKey
            MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
            if isDebug {
                // {"oid":"cb9dd67c2bd8a41e086c1bdb8653910dcb04e287"}
                MobClick.setLogEnabled(true)
                UmengHelper.printOpenUDID()
            }
            
            // 友盟分享 第三方登陆
            if isDebug {
                UMSocialManager.default().openLog(true)
            }
            UMSocialManager.default().umSocialAppkey = kUmengAppKey
            
            UMSocialManager.default().setPlaform(.wechatSession, appKey: kWechatAppID, appSecret: kWechatAppSecret, redirectURL: "")
            UMSocialManager.default().setPlaform(.QQ, appKey: kQQAppID, appSecret: nil, redirectURL: "")
            UMSocialManager.default().setPlaform(.sina, appKey: kWeiboAppKey, appSecret: kWechatAppSecret, redirectURL: "https://api.weibo.com/oauth2/default.html")
        }
        
        do {
            // 极光推送
            let entity = JPUSHRegisterEntity()
            entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
            
            JPUSHService.setup(withOption: launchOptions, appKey: kJPushAppKey, channel: "App Store", apsForProduction: isDebug)
        }
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
        UIApplication.shared.keyWindow?.rootViewController = TSMainViewController()
    }
    
}

// MARK: - 极光推送
@available(iOS 10.0, *)
extension AppDelegate: JPUSHRegisterDelegate {
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
}

