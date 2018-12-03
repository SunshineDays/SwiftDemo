//
// Created by tianshui on 2018/5/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 竞彩篮球
class JclqHandler: BaseHandler {

    func getMatchList(success: @escaping ((_ data: SLDataModel<JclqMatchModel>) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleJclqMatchList
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let matchList = json["list"].arrayValue.map {
                            return JclqMatchModel(json: $0)
                        }
                        var data = SLDataModel<JclqMatchModel>()
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
