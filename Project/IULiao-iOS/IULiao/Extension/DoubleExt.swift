//
//  DoubleExt.swift
//  
//
//  Created by tianshui on 15/8/7.
// 
//

import Foundation

extension Double {
    
    /// 小数位数
    func decimal(_ num: Int) -> String {
        return String(format: "%0.\(num)f", self)
    }
}
