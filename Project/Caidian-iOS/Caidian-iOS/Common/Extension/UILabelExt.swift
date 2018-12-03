//
//  UILabelExt.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

extension UILabel {

    /// 设置行间距
    ///
    /// - Parameter lineSpacing: 行间距
    public func lineSpacing(_ lineSpacing: CGFloat) {
        let text = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
        self.lineBreakMode = .byTruncatingTail
    }

}

extension UILabel {
    /// 文本高度
    public var textHeight: CGFloat {
        let labelText: NSString = (text ??  "") as NSString
        let size = CGSize(width: frame.width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedStringKey : Any]), context:nil).size
        return strSize.height
    }
    
    /// 文本宽度
    public var textWidth: CGFloat {
        let labelText: NSString = (text ??  "") as NSString
        let size = CGSize(width: 1000, height: frame.height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedStringKey : Any]), context:nil).size
        return strSize.width
    }
}
