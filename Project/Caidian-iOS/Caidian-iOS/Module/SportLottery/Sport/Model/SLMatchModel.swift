//
// Created by tianshui on 2018/4/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import UIKit

/// 体育彩票赛事protocol
protocol SLMatchModelProtocol: BaseModelProtocol { //}, Equatable {

    /// 赛事id
    var id: Int { get set }

    /// 主队名
    var home: String { get set }

    /// 客队名
    var away: String { get set }

    /// 序号
    var xid: Int { get set }

    /// 期号
    var issue: String { get set }

    /// 开赛时间
    var matchTime: TimeInterval { get set }

    /// 联赛颜色
    var color: UIColor { get set }

    /// 联赛名
    var leagueName: String { get set }

    /// 比分
    var score: String? { get set }

    /// 让球
    var letBall: Double { get set }
    
    /// 销售状态
    var saleStatus: SLMatchSaleStatusType { get set }
    
    /// 半场比分
    var halfScore: String? { get set }
    
    /// 主队全场比分
    var homeScore: Int? { get }
    
    /// 客队全场比分
    var awayScore: Int? { get }
    
    /// 主队半场比分
    var homeHalfScore: Int? { get }
    
    /// 客队半场比分
    var awayHalfScore: Int? { get }
    
    /// 推荐Id
    var recommendId :Int {get set}
    
}

extension SLMatchModelProtocol {
    
    var homeScore: Int? {
        guard let str = score?.split(separator: ":").first else {
            return nil
        }
        return Int(str)
    }
    
    var awayScore: Int? {
        guard let str = score?.split(separator: ":").last else {
            return nil
        }
        return Int(str)
    }
    
    var homeHalfScore: Int? {
        guard let str = halfScore?.split(separator: ":").first else {
            return nil
        }
        return Int(str)
    }
    
    var awayHalfScore: Int? {
        guard let str = halfScore?.split(separator: ":").last else {
            return nil
        }
        return Int(str)
    }
}

extension SLMatchModelProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

/// 赛事销售状态
enum SLMatchSaleStatusType: Int {
    
    /// 正常销售
    case normal = 0
    
    /// 延期
    case delay = 1
    
    /// 取消
    case cancel = 2
    
    /// 已截止
    case end = 3
    
    var name: String {
        switch self {
        case .normal: return "正常"
        case .delay: return "延期"
        case .cancel: return "取消"
        case .end: return "已截止"
        }
    }
}
