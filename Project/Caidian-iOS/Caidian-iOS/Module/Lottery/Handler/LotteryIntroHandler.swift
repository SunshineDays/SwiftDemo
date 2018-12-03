//
//  SLBuyHandler.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 彩种玩法介绍
class LotteryIntroHandler: BaseHandler {

    /// 介绍
    func intro(lottery: LotteryType, success: @escaping ((_ intro: String) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.appSettingLotteryIntro(lottery: lottery)
        defaultRequestManager.request(
                router: router,
                expires: 3600,
                success: {
                    json in
                    success(json["intro"].stringValue)
                },
                failed: {
                    error -> Bool in
                    failed(error)
                    return false
                })
    }
}
