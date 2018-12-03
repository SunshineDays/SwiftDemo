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
    
    static let navigationBarTintColor = UIColor(hex: 0xFF4422)
    
    /// cell的高亮和选中颜色 与系统默认的相同 0xD9D9D9
    static let cellHighlightedBackground = UIColor(hex: 0xD9D9D9)
    
    /// cell的分割线颜色 与系统默认的相同 0xC8C7CC
    static let cellSeparatorBackground = UIColor(hex: 0xC8C7CC)
    
    /// cell隔行变色 0xF2F2F2
    static let cellEachBackground = UIColor(hex: 0xF2F2F2)
    
    /// 灰色 色阶
    static let grayGamut = (
        gamut333333: UIColor(hex: 0x333333),
        gamut444444: UIColor(hex: 0x444444),
        gamut666666: UIColor(hex: 0x666666),
        gamut999999: UIColor(hex: 0x999999),
        gamutCCCCCC: UIColor(hex: 0xCCCCCC)
    )
    
    //---------------------------------------------------
    // MARK:- 项目相关颜色
    //---------------------------------------------------
    
    /// logo的主色调 (橘) 0xFF4422
    static let logo = UIColor(hex: 0xFF4422)
    /// 比赛结果 赛果
    ///
    /// win: (红) 0xE84545
    ///
    /// draw: (绿) 0x6CB601
    ///
    /// lost: (蓝) 0x2AA4DC
    static let matchResult = (
        win: UIColor(hex: 0xE84545),
        draw: UIColor(hex: 0x6CB601),
        lost: UIColor(hex: 0x2AA4DC)
    )
    
    /// 主队的颜色 (棕) 0x801717
    static let homeTeam = UIColor(hex: 0x801717)
    
    /// 让球背景色
    static let letBall = (
        zero: UIColor(hex: 0x666666),
        gt0: UIColor(hex: 0xFE6962),
        lt0: UIColor(hex: 0x62AFFE)
    )
    
    /// 数字彩 红球篮球
    static let ball = (
        red: UIColor(hex: 0xBB1E2B),
        blue: UIColor(hex: 0xBB1E2B)
    )
    
}

extension UIColor {
    /**
     颜色转图片
     - parameter width:  宽度
     - parameter height: 高度
     - returns: image
     */
    func colorToImage(width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /**
     颜色转图片
     - parameter size:  图片大小
     - returns: image
     */
    func colorToImage(size: CGSize) -> UIImage {
        return colorToImage(width: size.width, height: size.height)
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
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0

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
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
//            print("Scan hex error")
        }

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}



