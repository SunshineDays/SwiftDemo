//
//  FBRecommendSponsorMatchHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommendSponsorMatchHandler: BaseHandler {

    /// 赛事列表(足球)
    func getMatchList(success: @escaping ([FBRecommendSponsorMatchModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2SponsorMatchList
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommendSponsorMatchModel]()
                for match in json["matchs"].arrayValue {
                    list.append(FBRecommendSponsorMatchModel.init(json: match))
                    
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
    
    /// 赛事列表(竞彩)
    func getMatchJingcaiList(success: @escaping ([FBRecommendSponsorMatchModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2SponsorMatchJingcaiList
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommendSponsorMatchModel]()
                for match in json["matchs"].arrayValue {
                    list.append(FBRecommendSponsorMatchModel.init(json: match))
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
    
    
    /// 投注选择
    func getMatchBet(mId: Int, success: @escaping (FBRecommendSponsorMatchBetModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2SponsorMatchBet(mId: mId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = FBRecommendSponsorMatchBetModel.init(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 投注推荐 发布
    func postMatchBetResult(json: String, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2SponsorMatchBetResult(json: json)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
}
