//
//  FBRecommend2TodayNewsHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/19.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommend2TodayNewsHandler: BaseHandler {
    
    /// 今日推荐（按用户）
    public func getTodayNewsFromUser(success: @escaping ([FBRecommend2TodayNewsFromUserModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2TodayNewFromUser
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommend2TodayNewsFromUserModel]()
                for listJson in json["list"].arrayValue {
                    list.append(FBRecommend2TodayNewsFromUserModel.init(json: listJson))
                }
                DispatchQueue.main.async {
                    success(list)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 今日推荐（按比赛）
    public func getTodayNewsFromMatch(success: @escaping ([FBRecommendSponsorMatchModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2TodayNewFromMatch
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommendSponsorMatchModel]()
                for lookJson in json["list"].arrayValue {
                    list.append(FBRecommendSponsorMatchModel.init(json: lookJson))
                }
                DispatchQueue.main.async {
                    success(list)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}
