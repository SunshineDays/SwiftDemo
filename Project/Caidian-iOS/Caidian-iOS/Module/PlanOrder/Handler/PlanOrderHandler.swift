//
// Created by mac on 2018/5/31.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

class PlanOrderHandler: BaseHandler {

    /// 跟单用户
    func planOrderDetailFollowAccount(
            planDetailId: Int,
            page: Int,
            pageSize: Int,
            success: @escaping (_ list: [PlanOrderFollowAccountModel], _ pageInfo: TSPageInfoModel) -> Void,
            failed: @escaping FailedBlock) {
        let router = TSRouter.planOrderAccount(planDetailId: planDetailId, page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: { json in
                    let list = json["list"].arrayValue.map {
                        return PlanOrderFollowAccountModel(json: $0)
                    }
                    let pageInfo = TSPageInfoModel(json: json["page_info"])
                    success(list, pageInfo)

                },
                failed: { error in
                    failed(error)
                    return false
                })

    }

    //计划单详情页

    func planOrderDetail(
            planDetailId: Int,
            success: @escaping(_ planModel: PlanModel, _ planOrderDetailModel: PlanOrderDetailModel,_ planOrderFollowAccountModelList:[PlanOrderFollowAccountModel]) -> Void,
            failed: @escaping FailedBlock
    )
    {
        let router = TSRouter.planOrderDetail(planDetailId: planDetailId)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: { json in

                    print(json)
                    let planModel = PlanModel(json: json["plan"])
                    let planOrderDetailModel = PlanOrderDetailModel(json: json["detail"])
                    
                    let list =  json["buy_list"].arrayValue.map{ return PlanOrderFollowAccountModel(json: $0)}

                    success(planModel, planOrderDetailModel,list)

                },
                failed: { error in
                    failed(error)
                    return false
                })

    }
    
    /// 计划跟单 购买
    func planOrderBuy(
        planDetailId: Int,
        money: Double,
        success: @escaping (_ accountModel:UserAccountModel, _ planOrderFollowAccountModel: PlanOrderFollowAccountModel) -> Void,
        failed: @escaping FailedBlock
        )
    {
        let router = TSRouter.planOrderBuy(planDetailId: planDetailId, money: money)
        
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: { json in
                let account = UserAccountModel(json: json["account"])
                let buy = PlanOrderFollowAccountModel(json: json["buy"])
                success(account, buy)
                
        },
            failed: { error in
                failed(error)
                return true
        })
        
    }
    
    /// 作者计划单列表
    func planOrderHomeList(
        planId: Int,
        page :Int,
        pageSize :Int,
        success: @escaping (_ planModel:PlanOrderHomeModel) -> Void,
        failed: @escaping FailedBlock
        )
    {
        let router = TSRouter.planOrderHomeList(planId: planId,page:page,pageSize:pageSize)
        
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: { json in
                success(PlanOrderHomeModel(json: json))
        },
            failed: { error in
                failed(error)
                return false
        })
        
    }
    
    /// 首页计划单（热门）
    func planOrderHomeData(success: @escaping (_ detailModel: PlanOrderDetailModel, _ planModel: PlanModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.planOrderHomeData
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            let detailModel = PlanOrderDetailModel(json: json["detail"])
            let planModel = PlanModel(json: json["plan"])
            success(detailModel, planModel)
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    
    /// 计划单作者近30天订单
    func planOrderAuthorOrderList(planId: Int,
                                  success: @escaping (_ list: [PlanOrderAuthorOrderModel], _ remark: String) -> Void,
                                  failed: @escaping FailedBlock)
    {
        let router = TSRouter.planOrderAuthorOrderList(planId: planId)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [PlanOrderAuthorOrderModel]()
                for j in json["list"].arrayValue {
                    list.append(PlanOrderAuthorOrderModel(json: j))
                }
                let remark = json["remark"].stringValue
                DispatchQueue.main.async {
                    success(list, remark)
                }
                
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }

    /// 大计划单列表
    func planOrderBigPlanList(page: Int,
                          pageSize: Int,
                           success: @escaping (_ list: [PlanOrderBigPlanModel], PageInfoModel) -> Void,
                            failed: @escaping FailedBlock)
    {
        let router = TSRouter.planOrderBigPlanList(page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async(execute: {
                var list = [PlanOrderBigPlanModel]()
                for j in json["list"].arrayValue {
                    list.append(PlanOrderBigPlanModel(json: j))
                }
                let pageInfo = PageInfoModel(json: json["page_info"])
                DispatchQueue.main.async {
                    success(list, pageInfo)
                }
            })
        }) { (error) -> Bool in
            failed(error)
            return false
        }
        
    }

}
