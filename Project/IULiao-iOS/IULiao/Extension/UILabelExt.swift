//
//  UILabelExt.swift
//  IULiao
//
//  Created by levine on 2017/9/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UILabel {

    func getLabHeigh(labelStr: String, font: UIFont, width: CGFloat) -> CGFloat {

        let statusLabelText: NSString = labelStr as NSString

        let size = CGSize(width: width, height: 900)

        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)

        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedStringKey : Any]), context:nil).size

        return strSize.height

    }



    func getLabWidth(labelStr: String, font: UIFont, height: CGFloat) -> CGFloat {

        let statusLabelText: NSString = labelStr as NSString

        let size = CGSize(width: 900, height: height)

        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)

        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedStringKey : Any]), context:nil).size
        
        return strSize.width
        
    }
}
