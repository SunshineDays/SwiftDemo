//
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 赛事分析 赛况
class FBMatchAnalyzeHandler: BaseHandler {

    /// 比赛事件
    func getEvent(matchId: Int, lottery: Lottery?, success: @escaping ((FBMatchModel, FBMatchAnalyzeEventModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchAnalyzeEvent(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
                router,
                expires: 10,
                success: {
                    (json) -> Void in

                    DispatchQueue.global().async {
                        let match = FBMatchModel(json: json["match"])
                        var data = FBMatchAnalyzeEventModel(json: json)
                        let events = data.eventList.reversed()
                        var list = [FBMatchAnalyzeEventModel.Event]()
                        if events.count > 0 {
                            // 添加中场
                            var lastEvent = events.first!
                            for event in events {
                                if lastEvent.timeInt > 45 && event.timeInt <= 45 {
                                    let half = FBMatchAnalyzeEventModel.Event(team: .none, time: "45", text: "中场", type: .stage)
                                    list.append(half)
                                }
                                list.append(event)
                                lastEvent = event
                            }
                        }
                        data.eventList = list
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
    
    /// 比赛阵容
    func getLineup(matchId: Int, lottery: Lottery?, success: @escaping ((FBMatchModel, FBMatchAnalyzeLineupModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.fbMatchAnalyzeLineup(matchId: matchId, lottery: lottery)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in
                
                DispatchQueue.global().async {
                    let match = FBMatchModel(json: json["match"])
                    let data = FBMatchAnalyzeLineupModel(json: json)
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
