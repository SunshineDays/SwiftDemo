//
//  FBRecommend2BunchHandler.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommend2BunchHandler: BaseHandler {

    /// 竞彩2串1方案
    public func getBunchList(success: @escaping ([FBRecommend2BunchModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2BunchWithJingCaiList
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommend2BunchModel]()
                for listJson in json["list"].arrayValue {
                    list.append(FBRecommend2BunchModel.init(json: listJson))
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
    
    /// 竞彩个人未开奖(展开列表)
    public func getBunchDetailList(userId: Int, success: @escaping ([FBRecommend2BunchUserModel]) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.fbRecommend2CloseWithJingCaiList(userId: userId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                var list = [FBRecommend2BunchUserModel]()
                for listJson in json["list"].arrayValue {
                    list.append(FBRecommend2BunchUserModel.init(json: listJson))
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
