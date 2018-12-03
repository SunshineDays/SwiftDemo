//
//  UIColorExt.swift
//  
//
//  UIColor 扩展
//
//  Created by tianshui on 15/5/8.
// 
//

import UIKit
import Foundation

extension UIColor {
    
    //---------------------------------------------------
    // MARK:- 通用颜色
    //---------------------------------------------------
    
    /// 导航栏颜色
    static let navigationBarTint = UIColor(hex: 0xFF4C4C)
    
    /// cell的高亮和选中颜色 与系统默认的相同 0xD9D9D9
    static let cellHighlightedBackground = UIColor(hex: 0xD9D9D9)
    
    /// cell的分割线颜色 与系统默认的相同 0xC8C7CC
    static let cellSeparatorBackground = UIColor(hex: 0xC8C7CC)

    
    //---------------------------------------------------
    // MARK:- 项目相关颜色
    //---------------------------------------------------
    
    /// logo的主色调 (红) 0xFF4C4C
    static let logo = UIColor(hex: 0xFF4C4C)

    /// 比赛结果 win: (红) draw: (绿) lost: (蓝) 0x2AA4DC
    static let matchResult = (
        win: UIColor(hex: 0xE84545),
        draw: UIColor(hex: 0x6CB601),
        lost: UIColor(hex: 0x2AA4DC)
    )
    
    /// 色阶(项目中常见的颜色)
    static let colour = (
        gamut4D4D4D: UIColor(hex: 0x4D4D4D),
        gamutF5F5F5: UIColor(hex: 0xF5F5F5),
        gamut333333: UIColor(hex: 0x333333),
        gamutB3B3B3: UIColor(hex: 0xB3B3B3),
        gamutCCCCCC: UIColor(hex: 0xCCCCCC),
        gamut040000: UIColor(hex: 0x040000)
    )

}

extension UIColor {
    /// 颜色转图片
    public func convertToImage(width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIColor {
    /// hex
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8)  / 255.0
        let blue  = CGFloat(hex & 0x0000FF)         / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// RGBA
    convenience init(rgba: String, alpha: CGFloat = 1.0) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        
        var index = rgba.startIndex
        if rgba.hasPrefix("#") {
            index   = rgba.index(rgba.startIndex, offsetBy: 1)
        }
        let hex     = String(rgba[index...])
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}
