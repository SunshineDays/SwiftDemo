//
//  AppRegister.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 注册第三方
class AppRegister: NSObject {

    func registerApp(application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
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

// MARK: - 极光推送
@available(iOS 10.0, *)
extension AppRegister: JPUSHRegisterDelegate {
    
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
