//
//  FloatExt.swift
//  
//
//  Created by tianshui on 15/8/7.
// 
//

import Foundation

extension Float {
    
    /// 小数位数
    func decimal(_ num: Int) -> String {
        return String(format: "%0.\(num)f", self)
    }
}

extension CGFloat {
    /// 对应的像素值
    var pixel: CGFloat {
        return self / UIScreen.main.scale
    }
}
