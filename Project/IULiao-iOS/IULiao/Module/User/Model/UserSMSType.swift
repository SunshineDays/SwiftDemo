//
//  UserSMSType.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 短信类型
enum UserSMSType: Int {
    
    /// 注册
    case register = 1
    

    /// 找回密码
    case getPassword = 2
    

    /// 更换手机
    case changePhone = 3
    
    
    /// 验证码登陆
    case login = 4
    
    
    /// 修改密码
    case changePassword = 5
    
    
    case none = 0
}
