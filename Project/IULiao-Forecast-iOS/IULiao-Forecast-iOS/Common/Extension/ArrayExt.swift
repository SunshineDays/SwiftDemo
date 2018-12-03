//
//  ArrayExt.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 16/8/25.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Array {
    
    /// 安全的索引 越界返回nil
    subscript(safe index: Int) -> Element? {
        return index < endIndex && index >= 0 ? self[index] : nil
    }
    
}
