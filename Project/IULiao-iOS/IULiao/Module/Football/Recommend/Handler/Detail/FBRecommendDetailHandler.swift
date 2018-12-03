//
//  FBRecommendDetailHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/4.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommendDetailHandler: BaseHandler {
    
    /// 单场推荐
    func getDetail(recommendId: Int, success: @escaping(FBRecommendDetailModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2Detail(recommendId: recommendId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = FBRecommendDetailModel.init(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 用户浏览
    func getDetailLook(resourceId: Int, page: Int, pageSize: Int, module: ModuleAttentionType, success: @escaping ([FBRecommendDetailLookModel], FBRecommendDetailPageInforModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.commonVisitUser(resourceId: resourceId, module: module, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommendDetailLookModel]()
                for lookJson in json["list"].arrayValue {
                    list.append(FBRecommendDetailLookModel.init(json: lookJson))
                }
                let pageInfoModel = FBRecommendDetailPageInforModel.init(json: json["pageinfo"])
                DispatchQueue.main.async {
                    success(list, pageInfoModel)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 评论列表
    func getDetailComment(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int, success: @escaping ([CommonTopicModel], FBRecommendDetailPageInforModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.commonCommentList(resourceId: resourceId, module: module, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [CommonTopicModel]()
                for commonJson in json["list"].arrayValue {
                    list.append(CommonTopicModel.init(json: commonJson))
                }
                let pageInfoModel = FBRecommendDetailPageInforModel.init(json: json["pageinfo"])
                DispatchQueue.main.async {
                    success(list, pageInfoModel)
                }
            }
            
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    
}
