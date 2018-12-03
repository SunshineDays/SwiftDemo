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
    
    /// rgba的值
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = cgColor
        let num = color.numberOfComponents
        if num == 4 {
            let components = color.components
            return (components![0], components![1], components![2], components![3])
        } else if num == 2 {
            let components = color.components
            return (components![0], components![0], components![0], components![1])
        }
        print("无法获取颜色rgba分量值")
        return (0, 0, 0, 1)
    }
    
    /// 红色值 0~1
    var red: CGFloat {
        return rgba.red
    }
    
    /// 绿色值 0~1
    var green: CGFloat {
        return rgba.green
    }
    
    /// 蓝色值 0~1
    var blue: CGFloat {
        return rgba.blue
    }
    
    /// 透明度 0~1
    var alpha: CGFloat {
        return rgba.alpha
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    /**
    字符串 #rrggbbaa #rrggbb #rgba #rgb 或者不带#号的
    
    - parameter rgba: #rrggbbaa #rrggbb #rgba #rgb 可不带#
    */
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
    
    /// 16进制 0x112233
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    /// 16进制 0x112233
    convenience init(hex: Int, alpha: CGFloat) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8)  / 255.0
        let blue  = CGFloat(hex & 0x0000FF)         / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
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
    func colorToImage(_ size: CGSize) -> UIImage {
        return colorToImage(width: size.width, height: size.height)
    }
}
