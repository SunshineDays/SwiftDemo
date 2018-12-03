//
//  UMSocialSwiftInterface.swift
//  UMSocialDemo
//
//  Created by 张军华 on 2017/1/20.
//  Copyright © 2017年 Umeng. All rights reserved.
//

import Foundation

typealias UMSocialShareCompletionHandler = (_ data: UMSocialShareResponse?, _ error: NSError?) -> Void

/// 友盟分享
class UMSocialSwiftInterface: NSObject {
    
    // swift的分享
    static func share(platformType: UMSocialPlatformType,
                      messageObject: UMSocialMessageObject,
                      viewController: UIViewController?,
                      completion: UMSocialShareCompletionHandler?) {
        
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: viewController) {
            shareResponse, error in
            completion?(shareResponse as? UMSocialShareResponse, error as NSError?)
        }
    }
    
    /// 分享网页
    static func shareWebpage(platformType: UMSocialPlatformType,
                             viewController: UIViewController?,
                             title: String,
                             webpageUrl: String,
                             description: String?,
                             thumbImageUrl: String?,
                             completion: UMSocialShareCompletionHandler?)
    {
        let webObj = UMShareWebpageObject()
        webObj.title = title
        webObj.webpageUrl = webpageUrl
        
        if let description = description {
            webObj.descr = description
        }
        if let thumbImageUrl = thumbImageUrl, let url = URL(string: thumbImageUrl) {
            webObj.thumbImage = NSData(contentsOf: url)
        } else {
            webObj.thumbImage = R.image.icon.appLogo()
        }
        
        let msgObj = UMSocialMessageObject()
        msgObj.shareObject = webObj
        
        UMSocialSwiftInterface.share(platformType: platformType, messageObject: msgObj, viewController: viewController, completion: completion)
        
    }
    
    // 获得用户资料
    static func getUserInfo(plattype:UMSocialPlatformType,
                            viewController:UIViewController?,
                            completion: @escaping (_ response: UMSocialUserInfoResponse?, _ error: NSError?) -> Void) {
        UMSocialManager.default().getUserInfo(with: plattype, currentViewController: viewController) {
            shareResponse, error in
            completion(shareResponse as? UMSocialUserInfoResponse, error as NSError?)
        }
    }
 
    // 弹出分享面板
    static func showShareMenuWindow(selection:@escaping(_ platformType: UMSocialPlatformType) -> Void) {
        UMSocialUIManager.setPreDefinePlatforms([
            NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.wechatTimeLine.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.qzone.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.sina.rawValue)
            ])
        UMSocialUIManager.showShareMenuViewInWindow {
            platformType, userinfo in
            selection(platformType)
        }
    }
}

