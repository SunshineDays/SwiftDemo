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
    
    /// 金额（每三位用，隔开）
    ///
    /// - Parameter num: 小数位数
    /// - Returns: String
    func moneyText(_ num: Int = 0) -> String {
        var result = ""
        let money = Int(self)
        let moneyStr = money.string.reversed()
        
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
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}

extension Double {
    
    /**
     时间戳转字符串
     - parameter timestramp:    时间戳
     - parameter format:        格式
     - parameter isIntelligent: 是否智能转换(true:时间小于24小时显示n秒前,n分钟前等, false:按照format格式转换)
     - returns: 按格式转换后的字符串
     */
    func timeString(with format: String = "MM-dd HH:mm", isIntelligent: Bool = false) -> String {
        
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
    
    
    func timeAfterString(with format: String = "yyyy-MM-dd HH:mm:ss", isIntelligent: Bool = true) -> String {
        if self < 0 {
            return ""
        }
        var format = format
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let timeTrapStr =  formatter.string(from: Foundation.Date(timeIntervalSince1970: self))
        let nowStr = formatter.string(from: Foundation.Date(timeIntervalSince1970: Foundation.Date().timeIntervalSince1970))
        let subTimeTrap = (timeTrapStr as NSString).substring(with: NSMakeRange(5, 5))
        let subNow = (nowStr as NSString).substring(with: NSMakeRange(5, 5))
        if subTimeTrap == subNow {
            let format = "HH:mm"
            formatter.dateFormat = format
            let timeStr = formatter.string(from: Foundation.Date(timeIntervalSince1970: self))
            return "今天 " + timeStr
        }else if self < Foundation.Date().timeIntervalSince1970 {
            let format = "MM-dd HH:mm"
            formatter.dateFormat = format
            let timeStr = formatter.string(from: Foundation.Date(timeIntervalSince1970: self))
            return timeStr
            
        }else {
            let now = Foundation.Date().timeIntervalSince1970
            let diff = self - now
            if diff < 60 * 60 * 24 * 2 {
                format = "明天 HH:mm"
            }else if diff < 60 * 60 * 24 * 3 {
                format = "后天 HH:mm"
            }
        }
        return ""
    }
    
}
