//
//  TopLeftLabel.swift
//  IULiao
//
//  Created by levine on 2017/8/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class TopLeftLabel: UILabel {

 
    func textRectForBounds(bouds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect{
        var textRect = super.textRect(forBounds: bouds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bouds.origin.y
        return textRect
    }
    override func drawText(in rect: CGRect) {
     let actualRect = textRectForBounds(bouds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }

}
