//
//  StringExt.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/6/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import Foundation

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
    
    /// 彩色字符串
    func attributed(font: UIFont, color: UIColor) -> NSAttributedString {
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = font
        attributes[.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// 字符串转时间
    func stringToTimestramp(with format: String = "yyyy-MM-dd HH:mm:ss") -> Foundation.Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    /// 拨打电话
    func call() {
        let tel = "tel:" + self
        if let url = URL(string: tel) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /// 打开指定QQ的聊天界面
    func chatToQQ() {
        let qq = "mqq://im/chat?chat_type=wpa&uin=" + self + "&version=1&src_type=web"
        if let url = URL(string: qq) {
            if UIApplication.shared.canOpenURL(url) {
                let webView = UIWebView(frame: CGRect.zero)
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                UIApplication.shared.keyWindow?.addSubview(webView)
            }
            else {
                MBProgressHUD.show(info: "您还没有安装QQ")
            }
        }
    }
}

extension String {
    ///  字符串高度（在label中的高度）
    ///
    /// - Parameters:
    ///   - textWidth: 文本宽度
    ///   - font: 文本字体大小
    /// - Returns: 文本高度
    func textHeight(textWidth: CGFloat, font: UIFont) -> CGFloat {
        let labelText: NSString = self as NSString
        let size = CGSize(width: textWidth, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.height
    }
    
    ///  字符串宽度（在label中的宽度）
    ///
    /// - Parameters:
    ///   - textHeight: 文本高度
    ///   - font: 文本字体大小
    /// - Returns: 文本宽度
    func textWidth(textHeight: CGFloat, font: UIFont) -> CGFloat {
        let labelText: NSString = self as NSString
        let size = CGSize(width: 1000, height: textHeight)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.width
    }
}


extension String {
    /// 判断一个字符串是否是邮箱
    func isEmail(showError: Bool = false) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isEmail = test.evaluate(with: self)
        if showError && !isEmail {
            MBProgressHUD.show(info: "邮箱格式错误")
        }
        return isEmail
    }
    
    /// 是否是手机号码
    func isPhone(showError: Bool = false) -> Bool {
        //手机号以13,15,17,18开头，八个 \d 数字字符
        let regex: String = "^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMobile = test.evaluate(with: self)
        if showError && !isMobile {
            MBProgressHUD.show(info: "请输入正确的手机号码")
        }
        return isMobile
    }
}

extension String {
    /// MD5 加密操作
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = data(using: .utf8) {
            data.withUnsafeBytes { (bytes) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
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
    
    subscript(_ range: ClosedRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound)
            else {
                return ""
        }
        return String(self[startIndex...endIndex])
    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        guard let startIndex = validStartIndex(original: range.lowerBound) else {
            return ""
        }
        return String(self[startIndex...])
    }
    
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


