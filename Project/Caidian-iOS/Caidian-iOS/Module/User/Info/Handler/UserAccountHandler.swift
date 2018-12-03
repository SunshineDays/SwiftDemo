//
// Created by tianshui on 2018/4/29.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 用户账户信息
class UserAccountHandler: BaseHandler {

    /// 账户信息
    func getAccountDetail(success: @escaping ((_ account: UserAccountModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userAccountDetail
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    let account = UserAccountModel(json: json)
                    UserToken.shared.update(userAccount: account)
                    success(account)
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return true
                })
    }


    /// 交易日志数据源
    private var payLogList = [UserPayLogCellModel]()

    /// 交易日志
    func getAccountPayLog(inOut: InOutType, moneyType: MoneyType, page: Int, pageSize: Int, sinceTime: TimeInterval? = nil, success: @escaping(([UserPayLogCellModel], PageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userAccountPayLog(inOut: inOut, moneyType: moneyType, page: page, pageSize: pageSize, sinceTime: sinceTime)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let userPayLogModel = UserPayLogModel(json: json)
                        if page == 1 {
                            self.payLogList.removeAll()
                        }
                        if page <= userPayLogModel.pageInfo.pageCount {
                            userPayLogModel.list.forEach {
                                it in
                                self.payLogList.append(it)
                            }
                        }

                        DispatchQueue.main.async {
                            success(self.payLogList,userPayLogModel.pageInfo)
                        }
                    }
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })

    }


}

