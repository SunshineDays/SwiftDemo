//
//  TSPublicTool.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class TSPublicTool: NSObject {
    /// 彩色字符串
    class func attributedString(texts: [String],
                                fonts: [UIFont]? = nil,
                                colors: [UIColor]) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        for (index, text) in texts.enumerated() {
            var attribute: [NSAttributedStringKey: Any] = [.foregroundColor: colors[index]]
            if let fonts = fonts {
                attribute[.font] = fonts[index]
            }
            let str = NSAttributedString(string: text, attributes: attribute)
            result.append(str)
        }
        return result
    }
}

extension TSPublicTool {
    /// 获取当前ctrl的导航栏
    class func rootViewController() -> AnyObject {
        var currentController = UIApplication.shared.keyWindow?.rootViewController
        if currentController is UINavigationController {
            currentController = (currentController as? UINavigationController)?.viewControllers.first
            
        }
        if currentController is UITabBarController{
            currentController = (currentController as? UITabBarController)?.selectedViewController
        }
        return currentController!
        
    }
}

extension TSPublicTool {
    /// 投注内容
    class func footballCodeString(betKeyTypes: [JczqBetKeyType], letBall: Double) -> String {
        var codeString = ""
        for (index, code) in betKeyTypes.enumerated() {
            var codeName = code.name

            switch code {
            case .rqspf_sp0(sp: code.sp):
                codeName = "主\(letBall.decimal(0))球负"
            case .rqspf_sp1(sp: code.sp):
                codeName = "主\(letBall.decimal(0))球平"
            case .rqspf_sp3(sp: code.sp):
                codeName = "主\(letBall.decimal(0))球胜"
            default: break
            }
            codeString = codeString + codeName + "(\(code.sp.decimal(2)))"

            if (index + 1) % 3 == 0 && index < betKeyTypes.count {
                codeString += "\n"
            } else {
                codeString += "、"
            }
        }
        codeString.removeLast()
        return codeString
    }
}

extension TSPublicTool {
    class func textHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let labelText: NSString = text as NSString
        let size = CGSize(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedStringKey : Any]), context:nil).size
        return strSize.height
    }
}



