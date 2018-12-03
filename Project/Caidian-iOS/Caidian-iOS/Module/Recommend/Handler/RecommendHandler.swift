//
//  RecommendHandler.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/31.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 专家推荐
class RecommendHandler: BaseHandler {

    /// 推荐列表
    func recommendList(page: Int, pageSize: Int, success: @escaping (_ list: [RecommendOrderListModel], _ pageInfoModel: TSPageInfoModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.recommendList(page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [RecommendOrderListModel]()
                for j in json["list"].arrayValue {
                    list.append(RecommendOrderListModel(json: j))
                }
                let pageInfoModel = TSPageInfoModel(json: json["page_info"])
                DispatchQueue.main.async {
                    success(list, pageInfoModel)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 推荐详情
    func recommendDetail(recommendId: Int, success: @escaping (_ model: RecommendDetailModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.recommendDetail(recommendId: recommendId)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = RecommendDetailModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 专家历史推荐列表
    func recommendExpertInfo(professorId: Int, page: Int, pageSize: Int, success: @escaping (_ list: RecommendExpertModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.recommendExpertList(professorId: professorId, page: page, pageSize: pageSize)
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = RecommendExpertModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
}
