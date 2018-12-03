//
// Created by tianshui on 2018/5/14.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 期号
class LotteryIssueHandler: BaseHandler {

    /// 可销售期号
    func getSaleIssueList(lottery: LotteryType, success: @escaping ((_ issueList: [LotteryIssueModel], _ serverTime: TimeInterval) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleIssueList(lottery: lottery)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in

                    DispatchQueue.global().async {
                        let issueList = json["issue_list"].arrayValue.map { LotteryIssueModel(json: $0) }
                        let serverTime = json["server_time"].doubleValue
                        DispatchQueue.main.async {
                            success(issueList, serverTime)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 历史记录
    func historyResultList(lottery: LotteryType, page: Int, pageSize: Int, success: @escaping ((_ issueList: [LotteryIssueModel], _ pageInfo: TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleIssueResult(lottery: lottery, page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let issueList = json["list"].arrayValue.map { LotteryIssueModel(json: $0) }
                        let pageInfo = TSPageInfoModel(json: json["page_info"])
                        DispatchQueue.main.async {
                            success(issueList, pageInfo)
                        }
                    }
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }

    /// 近期开奖 10场
    func recentResultList(lottery: LotteryType, success: @escaping ((_ issueList: [LotteryIssueModel]) -> Void), failed: @escaping FailedBlock) {
        historyResultList(
                lottery: lottery,
                page: 1,
                pageSize: 10,
                success: {
                    issueList, _ in
                    success(issueList)
                },
                failed: {
                    error in
                    failed(error)
                })
    }
}
