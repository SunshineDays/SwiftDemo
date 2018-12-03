//
//  UserRealNameHandler.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 实名认证信息
class UserRealNameHandler:BaseHandler {
    

    
    /// 实名认证详情
    func requestRealNameDetail(
        success: @escaping ((_ userRealAuthBeanModel: UserRealAuthBeanModel) -> Void
        ),
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.userAuthDetail
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: {
                it in
                success(UserRealAuthBeanModel(json: it["auth"]))
            },
            failed: {
                error in
                failed(error)
                return true
            }
        )
        
    }
    
    
    //实名认证
    
    func requestRealName(
        realName :String,
        cardCode :String,
        success: @escaping ((_ userRealAuthBeanModel: UserRealAuthBeanModel) -> Void),
        failed: @escaping FailedBlock)
    {
        
        print("-----realName= \(realName)")
        let router = TSRouter.userRealNameInfo(isCard: cardCode, realName: realName)
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: {
                json in
                success(UserRealAuthBeanModel(json: json["auth"]))
              },
            failed: {
               error in
               failed(error)
               return true
            }
        )
    }
}
