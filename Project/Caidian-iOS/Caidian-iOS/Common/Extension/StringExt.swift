//
//  StringExt.swift
//  
//
//  Created by tianshui on 15/5/12.
//
//

import Foundation

extension String {
    
    /// md5
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = data(using: .utf8) {
            data.withUnsafeBytes { (bytes) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
    /// 判断一个字符串是否是手机号
    var isPhone: Bool {
        let pattern = "^1\\d{10}$"
        guard let regexp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        let range = NSMakeRange(0, self.count)
        let num = regexp.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: range)
        if num <= 0 {
            return false
        }
        return true
    }
    
    /// 判断一个字符串是否是邮箱
    var isEmail: Bool {
        if self.count < 6 {
            return false
        }
        let pattern = "^[\\w\\-\\.]+@[\\w\\-]+(\\.\\w+)+$"
        guard let regexp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        let range = NSMakeRange(0, self.count)
        let num = regexp.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: range)
        if num <= 0 {
            return false
        }
        return true
    }
    
    
    /// 使用正则表达式查找某些字符
    func pregReplace(pattern: String, with: String,options: NSRegularExpression.Options = []) -> String {
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex?.stringByReplacingMatches(in: self, options: [],range: NSMakeRange(0, self.count),withTemplate: with) ?? ""
    }
    
    
    //使用正则表达式替换 某些字符
    func pregFindChar(pattern: String,options: NSRegularExpression.Options = []) -> String {
        let regx = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        var contentString :String = ""
        if let results = regx?.matches(in: self, options: [], range: NSMakeRange(0, self.count)) {
            for item in results {
                let cur = (self as NSString).substring(with: item.range)
                contentString += cur
            }
        }
        return contentString
    }

}


extension String {
    /// 字符串截取
    func substring(to index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    /// 字符串截取
    func substring(from index: Int) -> String {
        return (self as NSString).substring(from: index)
    }
    
    /// 字符串截取
    func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
    
    /// 拨打电话
    func callToNum() {
        let telNumber = "tel:" + self
        let callWebView = UIWebView()
        callWebView.loadRequest(URLRequest.init(url: URL.init(string: telNumber)!))
        UIApplication.shared.keyWindow?.addSubview(callWebView)
    }
    
    /// 字符串转时间
    func timestamp(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Foundation.Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
}

/// subscript
private
extension String {
    
    func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    
    func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else {
            return nil
        }
        return validIndex(original:original)
    }
    
    func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else {
            return nil
        }
        return validIndex(original:original)
    }
}

/// subscript string下标截取类似切片
/// 与原生接口相比直接使用数字并且不会发生越界
extension String {
    
    subscript(_ range: Range<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex < endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    
//    subscript(_ range: CountableRange<Int>) -> String {
//        guard
//            let startIndex = validStartIndex(original: range.lowerBound),
//            let endIndex   = validEndIndex(original: range.upperBound),
//            startIndex < endIndex
//            else {
//                return ""
//        }
//
//        return String(self[startIndex..<endIndex])
//    }
    
    subscript(_ range: ClosedRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound)
            else {
                return ""
        }
        
        return String(self[startIndex...endIndex])
    }
    
//    subscript(_ range: CountableClosedRange<Int>) -> String {
//        guard
//            let startIndex = validStartIndex(original: range.lowerBound),
//            let endIndex   = validEndIndex(original: range.upperBound)
//            else {
//                return ""
//        }
//
//        return String(self[startIndex...endIndex])
//    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        guard let startIndex = validStartIndex(original: range.lowerBound) else {
            return ""
        }
        
        return String(self[startIndex...])
    }
    
//    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
//        guard let startIndex = validStartIndex(original: range.lowerBound) else {
//            return ""
//        }
//        
//        return String(self[startIndex...])
//    }
    
    subscript(_ range: PartialRangeThrough<Int>) -> String {
        guard let endIndex = validEndIndex(original: range.upperBound) else {
            return ""
        }
        
        return String(self[...endIndex])
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        guard
            let endIndex = validEndIndex(original: range.upperBound),
            endIndex > startIndex
            else {
                return ""
        }
        
        return String(self[..<endIndex])
    }
}

