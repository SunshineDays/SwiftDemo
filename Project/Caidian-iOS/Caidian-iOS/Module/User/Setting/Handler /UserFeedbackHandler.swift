//
//  UserFeedbackHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/7/3.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 用户反馈
class UserFeedbackHandler: BaseHandler {
    
    /// 反馈
    func feedback(content: String, phone: String? = nil, success: @escaping ((_ id: Int) -> Void), failed: @escaping FailedBlock) {
        
        let router = TSRouter.userFeedbackApp(content: content, phone: phone)
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: {
                json in
                let id = json["id"].intValue
                success(id)
        },
            failed: {
                error in
                failed(error)
                return false
        })
    }

}
