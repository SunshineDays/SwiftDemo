//
//  WYPopoverThemeDark.swift
//  ZS310
//
//  Created by tianshui on 15/7/2.
//  Copyright (c) 2015年 zs310. All rights reserved.
//

import UIKit

/// 黑色主题
class WYPopoverThemeDark: WYPopoverTheme {

    override init() {
        super.init()
        usesRoundedArrow = true
        dimsBackgroundViewsTintColor = false
        tintColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        outerStrokeColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        innerStrokeColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        fillTopColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        fillBottomColor = nil
        glossShadowColor = nil
        glossShadowOffset = CGSize.zero
        glossShadowBlurRadius = 0
        borderWidth = 4
        arrowBase = 12
        arrowHeight = 8
        outerShadowColor = UIColor.clear
        outerShadowBlurRadius = 0
        outerShadowOffset = CGSize.zero
        outerCornerRadius = 4
        minOuterCornerRadius = 0
        innerShadowColor = UIColor.clear
        innerShadowBlurRadius = 0
        innerShadowOffset = CGSize.zero
        innerCornerRadius = 0
        viewContentInsets = UIEdgeInsets.zero //UIEdgeInsetsMake(0, 8, 0, 8)
        overlayColor = UIColor.clear
        preferredAlpha = 1.0
    }
    
}
