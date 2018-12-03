//
//  UILabelExt.swift
//  IULiao-Forecast-iOS
//
//  Created by levine on 2017/9/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UILabel {
    /// 文本高度
    public var textHeight: CGFloat {
        let labelText: NSString = (text ??  "") as NSString
        let size = CGSize(width: frame.width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.height
    }
    
    /// 文本高度(自定义文本行间距)
    public func textHeihgt(_ lineSpcaing: CGFloat) -> CGFloat {
        let attrString = NSMutableAttributedString(string: text ?? "")
        let paragrapStyle = NSMutableParagraphStyle()
        paragrapStyle.lineSpacing = lineSpcaing
        attrString.addAttribute(.paragraphStyle, value: paragrapStyle, range: NSRange(location: 0, length: text?.count ?? 0))
        attrString.addAttribute(.font, value: font, range: NSRange(location: 0, length: text?.count ?? 0))
        let attrStringSize = self.sizeThatFits(CGSize(width: frame.width, height: 1000))
        return attrStringSize.height
    }
    
    /// 文本宽度
    public var textWidth: CGFloat {
        let labelText: NSString = (text ??  "") as NSString
        let size = CGSize(width: 1000, height: frame.height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context:nil).size
        return strSize.width
    }
}

extension UILabel {
    /// 设置行间距
    ///
    /// - Parameter lineSpacing: 行间距
    public func lineSpacing(_ lineSpacing: CGFloat) {
        let text = self.text ?? ""
        /// 1行字符串宽度
        let textWidth = text.textWidth(textHeight: 15, font: font)
        /// 大于1行才设置行间距
        if textWidth > frame.width {
            let attributedString = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
            self.attributedText = attributedString
            self.lineBreakMode = .byTruncatingTail
        }
    }
}
