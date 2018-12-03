//
//  DoubleExt.swift
//  
//
//  Created by tianshui on 15/8/7.
// 
//

import Foundation

extension Double {
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
    
    /// 小数位数
    func decimal(_ num: Int) -> String {
        return String(format: "%0.\(num)f", self)
    }
    
    /// 金额（每三位用，隔开）
    ///
    /// - Parameter num: 保留小数点位数
    /// - Returns: String
    func moneyText(_ num: Int = 0) -> String {
        var result = ""
        let money = Int(self)
        let moneyStr = money.string().reversed()
        
        for (index, m) in moneyStr.enumerated() {
            result = result + String(m)
            if (index + 1) % 3 == 0 && index + 1 != moneyStr.count {
                result = result + ","
            }
        }
        
        result = String(result.reversed())
        
        if num > 0 {
            var decimal = (self - Double(money)).decimal(num)
            decimal.removeFirst()
            result = result + decimal
        }
        
        return result
    }
    
    /**
     时间戳转字符串
     - parameter format:        格式
     - parameter isIntelligent: 是否智能转换(true:时间小于24小时显示n秒前,n分钟前等, false:按照format格式转换)
     - returns: 按格式转换后的字符串
     */
    func timestampToString(withFormat format: String = "yyyy-MM-dd HH:mm:ss", isIntelligent: Bool = false) -> String {
        
        if self < 0 {
            return ""
        }
        
        var format = format
        
        if isIntelligent {
            let now = Foundation.Date().timeIntervalSince1970
            let diff = now - self
            if diff < 1 {
                return "刚刚"
            } else if diff < 60 {
                let r = Int(diff)
                return "\(r)秒前"
            } else if diff < 60 * 60 {
                let r = Int(diff / 60)
                return "\(r)分前"
            } else if diff < 60 * 60 * 24 {
                let r = Int(diff / 60 / 60)
                return "\(r)小时前"
            } else if diff < 60 * 60 * 24 * 2 {
                format = "昨天 HH:mm"
            } else if diff < 60 * 60 * 24 * 3 {
                format = "前天 HH:mm"
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Foundation.Date(timeIntervalSince1970: self))
    }
}


extension Int {
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
    
    /// Int -> string
    func string() -> String {
        return String(format: "%d", self)
    }
    
    /// 金额（每三位用，隔开）
    func moneyText() -> String {
        var result = ""
        let moneyStr = self.string().reversed()
        for (index, m) in moneyStr.enumerated() {
            result = result + String(m)
            if (index + 1) % 3 == 0 && index + 1 != moneyStr.count {
                result = result + ","
            }
        }
        result = String(result.reversed())
        return result
    }
}

extension CGFloat {
    var pixel: CGFloat {
        return self / UIScreen.main.scale
    }
}
