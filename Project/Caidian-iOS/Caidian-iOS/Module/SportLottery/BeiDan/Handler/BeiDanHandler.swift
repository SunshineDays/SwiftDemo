//
//  BeiDanHandler.swift
//  Caidian-iOS
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

class BeiDanHandler: BaseHandler {
    
    func requestBeiDanMatchList(success: @escaping ((_ data: SLDataModel<JczqMatchModel>) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleBeiDanMatchList
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: {
                json in
                
                DispatchQueue.global().async {
                    let matchList = json["list"].arrayValue.map {
                        return JczqMatchModel(json: $0)
                    }
                    var data = SLDataModel<JczqMatchModel>()
                    data.groupSortType = .issue
                    data.originalMatchList = matchList
                    DispatchQueue.main.async {
                        success(data)
                    }
                }
                
        },
            failed: {
                error in
                failed(error)
                return false
        })
    }
}
