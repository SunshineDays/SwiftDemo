//
//  CommonCommentHandler.swift
//  IULiao
//
//  Created by levine on 2017/9/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

import SwiftyJSON

protocol CommonCommentHandlerDelegate: class {
    func recommendPostMatchDetial(_ handler: CommonCommentHandler, didFectchData data:  [CommonTopicModel], pageInfo: TSPageInfoModel)
    func recommendPostMatchDetial(_ handler: CommonCommentHandler, didFiald error: NSError)

}
class CommonCommentHandler: BaseHandler {

    
    //发起评论
    func sendPostComment(content: String, module: ModuleAttentionType, resourceId: Int, parentId: Int?, success: @escaping ((_ json: JSON) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.commonCommentPost(resourceId: resourceId, module: module, content: content, parentId: parentId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
    
    weak var delegate: CommonCommentHandlerDelegate?

    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    func executeFectchCommentListData(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int) {
        let router = TSRouter.commonCommentList(resourceId: resourceId, module: module, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router, expires: 600, success: nil, failed: nil)
    }
    
    
}
extension CommonCommentHandler:TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        let commonTopicModels = json["list"].arrayValue.map({CommonTopicModel(json:$0)})
        let paggInfo = TSPageInfoModel(json: json["pageinfo"])
        delegate?.recommendPostMatchDetial(self, didFectchData: commonTopicModels, pageInfo: paggInfo)
    }
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.recommendPostMatchDetial(self, didFiald: error)
        return false
    }
}
