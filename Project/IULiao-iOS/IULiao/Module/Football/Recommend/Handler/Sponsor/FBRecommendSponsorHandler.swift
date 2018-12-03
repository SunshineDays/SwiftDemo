//
//  FBRecommendSponsorHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommendSponsorHandler: BaseHandler {

    /// 发起
    func getActivityData(success: @escaping(FBRecommendSponsorActivityModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2SponsorActivity
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = FBRecommendSponsorActivityModel.init(json: json)
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
