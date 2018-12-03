//
//  CopyOrderUserDetailHandler.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/27.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class CopyOrderUserDetailHandler: BaseHandler {
    
    /// 复制跟单 发单人信息
    func copyUserInfor(userId: Int, success: @escaping ((_ model: UserCopyOrderUserInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.copyUserInfor(userId: userId)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            success(UserCopyOrderUserInfoModel(json: json))
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 复制跟单 发单人历史记录
    func copyUserHistory(userId: Int, page: Int, pageSize: Int, success: @escaping ((_ list: [UserCopyOrderUserHistoryModel], _ pageInfoModel: TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.copyUserHistory(userId: userId, page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [UserCopyOrderUserHistoryModel]()
                for listJson in json["list"].arrayValue {
                    list.append(UserCopyOrderUserHistoryModel(json: listJson))
                }
                DispatchQueue.main.async {
                    success(list, TSPageInfoModel(json: json["page_info"]))
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}
