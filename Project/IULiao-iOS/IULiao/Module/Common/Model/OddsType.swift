//
//  OddsType.swift
//  IULiao
//
//  Created by tianshui on 16/7/25.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 赔率类型
enum OddsType: String {
    
    /// 亚盘
    case asia = "asia"
    
    /// 欧赔
    case europe = "europe"

    /// 大小
    case bigSmall = "big_small"

    case none = ""
    
    var name: String {
        switch self {
        case .asia:
            return "亚盘"
        case .europe:
            return "欧赔"
        case .bigSmall:
            return "大小"
        default:
            return ""
        }
    }
    
}
