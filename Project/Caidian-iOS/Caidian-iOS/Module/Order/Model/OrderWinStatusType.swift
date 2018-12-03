//
// Created by tianshui on 2018/4/30.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 订单中奖状态
enum OrderWinStatusType: Int {

    /// 未开奖
    case notOpen = 0

    /// 未中奖
    case lost = 1

    /// 已中奖
    case win = 2

    var name: String {
        switch self {
        case .notOpen: return "暂未开奖"
        case .lost: return "未中奖"
        case .win: return "已中奖"
        }
    }
    
    var title: String {
        switch self {
        case .notOpen: return "暂未开奖"
        case .lost: return "未命中"
        case .win: return "命中"
        }
    }
    
    var color: UIColor {
        switch self {
        case .notOpen: return UIColor.grayGamut.gamut999999
        case .win: return UIColor.matchResult.win
        case .lost: return UIColor.grayGamut.gamut666666
        }
    }
    
    var image: UIImage? {
        switch self {
        case .notOpen: return nil
        case .win: return R.image.order.win_light()
        case .lost: return R.image.order.statue_lost1()
        }
    }
    
    /// 复制跟单
    var copyOrderImage: UIImage? {
        switch self {
        case .notOpen: return nil
        case .win: return R.image.order.copy_order_detail_win()
        case .lost: return R.image.order.copy_order_detail_lost()
        }
    }
}
