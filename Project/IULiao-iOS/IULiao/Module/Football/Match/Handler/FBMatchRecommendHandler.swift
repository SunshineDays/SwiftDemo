//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 推荐
class FBMatchRecommendHandler: BaseHandler {

    /// 爆料
    func getRecommendList(matchId: Int, lottery: Lottery?, oddsType: RecommendDetailOddsType, success: @escaping ((FBMatchModel, [FBMatchRecommendModel], TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchRecommend(matchId: matchId, lottery: lottery, oddsType: oddsType)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
                        let recommendList = json["list"].arrayValue.map {
                            subJson -> FBMatchRecommendModel in
                            let recommend = FBRecommendModel2(json: subJson)
                            let user = FBRecommendProfessorModel2(json: subJson["user"])
                            return FBMatchRecommendModel(recommend: recommend, user: user)
                        }

                        DispatchQueue.main.async {
                            success(match, recommendList, pageInfo)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

    
    /// 爆料(竞彩推荐)
    func getRecommendJingCaiList(matchId: Int, lottery: Lottery?, oddsType: RecommendDetailOddsType, success: @escaping ((FBMatchModel, [FBRecommend2BunchUserModel], TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchRecommend(matchId: matchId, lottery: lottery, oddsType: oddsType)
        
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let match = FBMatchModel(json: json["match"])
                let pageInfo = TSPageInfoModel(json: json["pageinfo"])
                
                var modelList = [FBRecommend2BunchUserModel]()
                for listJson in json["list"].arrayValue {
                    modelList.append(FBRecommend2BunchUserModel(json: listJson))
                }
                
                DispatchQueue.main.async {
                    success(match, modelList, pageInfo)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}
