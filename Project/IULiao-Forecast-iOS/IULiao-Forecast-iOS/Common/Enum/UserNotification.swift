//
//  UserNotification.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 用户自定义通知 Notification
enum UserNotification: String {
    
    /// 用户需要登录
    case userShouldLogin
    
    /// 用户登录成功
    case userLoginSuccessful
    
    /// 用户退出成功
    case userLogoutSuccessful
    
    /// 用户关注通知
    case userIsAttention
    
    /// 用户修改系统通知状态
    case userNotificationUpdate
    
    /// 后台返回来超过30分钟，需要刷新当前展示界面
    case refreshCurrentCtrl

    var notification: Notification.Name  {
        return Notification.Name(rawValue: self.rawValue)
    }
}
