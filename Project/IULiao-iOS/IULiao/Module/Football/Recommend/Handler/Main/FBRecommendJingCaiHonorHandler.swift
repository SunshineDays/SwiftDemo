//
//  FBRecommendJingCaiHonorHandler.swift
//  IULiao
//
//  Created by levine on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol FBRecommendJingCaiHonorHandlerDelegate : class {
    
    func guessHonorLHandler(_ handler: FBRecommendJingCaiHonorHandler, didFecthedList list: [FBRecommendJingCaiHonorModel])
    
    func guessHonorLHandler(_ handler: FBRecommendJingCaiHonorHandler, didError error: NSError)
}
class FBRecommendJingCaiHonorHandler: BaseHandler {
    
    weak var delegate:FBRecommendJingCaiHonorHandlerDelegate?
  
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    //该 方法提供外部调用
    func executeGuessHonorListFetch() {
        defaultRequestManager.requestWithRouter(TSRouter.fbRecommendJingcaiSpecial, expires: 0, success: nil, failed: nil)
    }
}
extension FBRecommendJingCaiHonorHandler:TSRequestManagerDelegate {
    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        var guessHonorArr = [FBRecommendJingCaiHonorModel]()
        for subJson in json.arrayValue{
            guessHonorArr.append(FBRecommendJingCaiHonorModel(json: subJson))
        }
        delegate?.guessHonorLHandler(self, didFecthedList: guessHonorArr)
    }
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.guessHonorLHandler(self, didError: error)
        return false
    }
 
}
