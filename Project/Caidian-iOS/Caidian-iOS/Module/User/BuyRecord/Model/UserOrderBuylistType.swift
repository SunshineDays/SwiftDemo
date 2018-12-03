//
// Created by levine on 2018/5/3.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

enum UserOrderBuylistType: String {
    case all = "全部"
    case selfBuy = "自购"
    case postOrder = "发单"
    case followOrder = "跟单"

//    var orderStateType
    static let allTabs: [UserOrderBuylistType] = [.all, .selfBuy, .postOrder, .followOrder]
}
