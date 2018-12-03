//
// Created by tianshui on 2017/11/6.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 球员
class FBPlayerHandler: BaseHandler {

    override init() {
        super.init()
    }

    /// 球员详情
    func getDetail(playerId: Int, success: @escaping((FBPlayerDetailModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbPlayerDetail(playerId: playerId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 3600,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let detail = FBPlayerDetailModel(json: json)
                        DispatchQueue.main.async {
                            success(detail)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 球员 技术统计
    func getStatistics(playerId: Int, success: @escaping((FBPlayerStatisticsModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbPlayerStatistics(playerId: playerId)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 3600,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let detail = FBPlayerStatisticsModel(json: json)
                        DispatchQueue.main.async {
                            success(detail)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }
    
    
    /// 球员表现比赛
    ///
    /// - Parameters:
    ///   - playerId: 球员id
    ///   - page: 分页
    ///   - pageSize: 分页大小
    ///   - success: 成功
    ///   - failed: 失败
    func getMatchList(
        playerId: Int,
        page: Int,
        pageSize: Int,
        success: @escaping(([FBPlayerMatchModel], TSPageInfoModel) -> Void),
        failed: @escaping FailedBlock)
    {
        let router = TSRouter.fbPlayerMatchList(playerId: playerId, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 3600,
            success: {
                json in
                
                DispatchQueue.global().async {
                    var list = [FBPlayerMatchModel]()
                    for subJson in json["list"].arrayValue {
                        let obj = FBPlayerMatchModel(json: subJson)
                        list.append(obj)
                    }
                    let pageInfo = TSPageInfoModel(json: json["pageinfo"])
                    DispatchQueue.main.async {
                        success(list, pageInfo)
                    }
                }
        },
            failed: {
                error -> Bool in
                failed(error)
                return false
        })
    }
}
