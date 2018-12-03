//
//  FBMatchInfoHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/27.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 爆料
class FBMatchNewsHandler: BaseHandler {

    /// 爆料
    func getNews(matchId: Int, lottery: Lottery?, success: @escaping ((FBMatchModel, FBMatchNewsModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchNews(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 0,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        let briefList = json["brief_list"].arrayValue.map {
                            NewsBriefModel(json: $0)
                        }
                        let normalList = json["normal_list"].arrayValue.map {
                            NewsBriefModel(json: $0)
                        }
                        let data = FBMatchNewsModel(briefList: briefList, normalList: normalList)
                        DispatchQueue.main.async {
                            success(match, data)
                        }
                    }
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return false
                })
    }

}
