//
//  UserPlanOrderListHandler.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 我的计划单
class UserPlanOrderListHandler: BaseHandler {

    /// 我的计划单
    func userPlanOrderBigPlanList(page: Int, pageSize: Int, success: @escaping((_ totalModel: UserPlanOrderTotalMoneyModel, _ list: [UserPlanOrderBigPlanListModel], _ pageInfo: PageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.planOrderBigPlanBuyList(page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [UserPlanOrderBigPlanListModel]()
                for j in json["list"].arrayValue {
                    list.append(UserPlanOrderBigPlanListModel(json: j))
                }
                let totalModel = UserPlanOrderTotalMoneyModel(json: json["statistics"])
                let pageInfoModel = PageInfoModel(json: json["page_info"])
                DispatchQueue.main.async {
                    success(totalModel, list, pageInfoModel)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
        
    }
    
    
    /// 我的计划单(作者)
    func userplanOrderList(planId: Int, page: Int, pageSize: Int, success: @escaping((_ totalModel: UserPlanOrderTotalMoneyModel, _ models: [UserPlanOrderListModel], _ pageInfo: PageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.planOrderBuyList(planId: planId, page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [UserPlanOrderListModel]()
                for modelJson in json["list"].arrayValue {
                    list.append(UserPlanOrderListModel(json: modelJson))
                }
                DispatchQueue.main.async {
                    success(UserPlanOrderTotalMoneyModel(json: json["statistics"]), list, PageInfoModel(json: json["page_info"]))
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
        
    }
    
}
