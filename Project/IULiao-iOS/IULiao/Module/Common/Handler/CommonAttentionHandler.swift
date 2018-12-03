//
//  CommonAttentionHandler.swift
//  IULiao
//
//  Created by levine on 2017/8/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol CommonAttentionHandlerDelegate: class {

//    func commendAttentionHandler(_ handler: CommendAttentionHandler, attentionType type: ModuleAttentionType,didAttentionExpertList expertList: [BaseModelProtocol]?, attentionRecommendList recommendList: [BaseModelProtocol]?, attentionNewsList newsList: [BaseModelProtocol]?, pageInfo: TSPageInfoModel )
       func commonAttentionHandler(_ handler: CommonAttentionHandler, attentionType type: ModuleAttentionType,didAttentionList List: [BaseModelProtocol]?, pageInfo: TSPageInfoModel )
       func commonAttentionHandler(_ handler: CommonAttentionHandler, didFaild error: NSError)
}

class CommonAttentionHandler: BaseHandler {
    //关注
    func sendAttention(module: ModuleAttentionType, resourceId: Int, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.commonAttentionFollow(resourceId: resourceId, module: module)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    //取消 关注
    func sendUnAttention(module: ModuleAttentionType, resourceId: Int, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.commonAttentionUnFollow(resourceId: resourceId, module: module)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }

    weak var delegate: CommonAttentionHandlerDelegate?

    var attentionType: ModuleAttentionType?
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }

    func executeAttentionList(module: ModuleAttentionType,page: Int, pageSize: Int) {
        let router = TSRouter.commonAttentionList(module: module,page: page,pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router)
    }

}
extension CommonAttentionHandler: TSRequestManagerDelegate {

    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        var list = [BaseModelProtocol]()
//        var recommendList = [FBRecommendExpertHistoryModel]()
//        var newsList = [NewsModel]()
        if attentionType == ModuleAttentionType.recommend_statistic {
            list = json["list"].arrayValue.map({FBRecommendRankModel(json: $0)})
        }else if attentionType == ModuleAttentionType.recommend {
           list = json["list"].arrayValue.map({FBRecommendExpertHistoryModel(json: $0)})
        }else {
            list = json["list"].arrayValue.map({NewsModel(json: $0)})
        }
        
        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
        delegate?.commonAttentionHandler(self, attentionType: attentionType!, didAttentionList: list, pageInfo: pageInfo)
    }
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.commonAttentionHandler(self, didFaild: error)
        return true
    }
}
