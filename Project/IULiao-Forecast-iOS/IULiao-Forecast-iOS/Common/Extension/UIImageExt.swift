//
//  UIImageExt.swift
//  HuaXia
//
//  Created by tianshui on 15/11/16.
// 
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    
    /// 缩放
    ///
    /// - Parameter size: 缩放尺寸
    /// - Returns: 缩放后的图片
    func resize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    /// 绘制圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - size: 图片大小
    /// - Returns: 绘制出来的图片
    func drawRectCorner(radius: CGFloat, size: CGSize? = nil) -> UIImage {
        let size = size ?? self.size
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        context.addPath(path)
        context.clip()
        draw(in: rect)
        context.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
}

