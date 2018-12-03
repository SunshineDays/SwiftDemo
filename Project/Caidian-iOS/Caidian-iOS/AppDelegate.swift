
//
//  AppDelegate.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/3/16.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var refreshDataNowTime: Double = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.initOptions(launchOptions)
        // Override point for customization after application launch.        
        
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        /// 响应浏览器打开APP的请求
        TSEntryViewControllerHelper().openControllerFromUrl(schemeUrlString: url.absoluteString)
    
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        refreshDataNowTime = Date().timeIntervalSince1970
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if refreshDataNowTime < Date().timeIntervalSince1970 - kRefreshDataTime {
            NotificationCenter.default.post(name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
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
            // 友盟 统计
            MobClick.setLogEnabled(true)
            UMAnalyticsConfig.sharedInstance().appKey = kUmengAppKey
            MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
         
//            if isDebug {
//                // {"oid":"cb9dd67c2bd8a41e086c1bdb8653910dcb04e287"}
//              
//            }
            
        }
        
       
    }


}

