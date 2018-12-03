//
//  FBRecommendExpertHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommendExpertHandler: BaseHandler {

    /// 专家详情
    func getDetail(userId: Int, success: @escaping(FBRecommendExpertModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2ExpertDetail(userId: userId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = FBRecommendExpertModel.init(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 专家历史推荐
    func getHistoryList(userId: Int, oddsType: RecommendDetailOddsType, page: Int, pageSize: Int, success: @escaping([FBRecommendExpertHistoryListModel], TSPageInfoModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2ExpertHistoryList(userId: userId, oddsType: oddsType, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommendExpertHistoryListModel]()
                for listJson in json["list"].arrayValue {
                    list.append(FBRecommendExpertHistoryListModel.init(json: listJson))
                }
                let pageInfoModel = TSPageInfoModel.init(json: json["pageinfo"])
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
