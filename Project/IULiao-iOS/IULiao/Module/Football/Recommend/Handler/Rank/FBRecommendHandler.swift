//
//  FBRecommend2RankHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommend2RankHandler: BaseHandler {

    /// 单场推荐
    func getSingle(rankType: RecommendRankType, region: RecommendRegionType, oddsType: RecommendDetailOddsType, success: @escaping([FBRecommend2RankModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommendSingleList(rankType: rankType, region: region, oddsType: oddsType)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommend2RankModel]()
                for singleJson in json["list"].arrayValue {
                    list.append(FBRecommend2RankModel.init(json: singleJson))
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
