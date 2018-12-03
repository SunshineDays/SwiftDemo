//
//  UIViewExt.swift
//
//
//  Created by tianshui on 15/7/21.
//
//

import Foundation
import UIKit
import ObjectiveC

private var extraPropertyAssociationKey: Void?

extension UIView {
    
    /// 自定义属性
    var extraProperty: [String: Any]? {
        get {
            return objc_getAssociatedObject(self, &extraPropertyAssociationKey) as? [String: Any]
        }
        set {
            objc_setAssociatedObject(self, &extraPropertyAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    /// view当前所在的控制器
    var viewController: UIViewController? {
        var next: UIView? = self
        repeat {
            if let nextResponder = next?.next, nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            next = next?.superview
        } while next != nil
        return nil
    }
}

extension UIView {
    // MARK: - 可视化设置 添加圆角和边框(性能差) 性能高的:addCornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// 像素宽度
    @IBInspectable var borderWidthPixel: CGFloat {
        get {
            return layer.borderWidth * UIScreen.main.scale
        }
        set {
            layer.borderWidth = newValue / UIScreen.main.scale
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let c = layer.borderColor {
                return UIColor(cgColor: c)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}


extension UIView {
    
    
    /// 设置圆角和边框
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - borderWidth: 边框宽度
    ///   - backgroundColor: 背景颜色
    ///   - borderColor: 边框颜色
    func setCornerRadius(radius: CGFloat, borderWidth: CGFloat = 0, backgroundColor: UIColor = UIColor.clear, borderColor: UIColor = UIColor.clear) {
        let image = drawRectCorner(radius: radius, borderWidth: borderWidth, backgroundColor: backgroundColor, borderColor: borderColor);
        let imageView = UIImageView(image: image)
        insertSubview(imageView, at: 0)
    }
    
    
    /// 绘制圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角大小
    ///   - borderWidth: 边框宽度
    ///   - backgroundColor: 背景颜色
    ///   - borderColor: 边框颜色
    /// - Returns: 绘制出来的图片
    private func drawRectCorner(radius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor, borderColor: UIColor) -> UIImage {
        let size = bounds.size
        let width = size.width
        let height = size.height
        let halfWidth = borderWidth / 2
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(borderWidth)
        context.setStrokeColor(borderColor.cgColor)
        context.setFillColor(backgroundColor.cgColor)
        
        context.move(to: CGPoint(x: width - halfWidth, y: radius + halfWidth))
        // 右下角
        context.addArc(tangent1End: CGPoint(x: width - halfWidth, y: height - halfWidth), tangent2End: CGPoint(x: width - radius - halfWidth, y: height - halfWidth), radius: radius)
        // 左下角
        context.addArc(tangent1End: CGPoint(x: halfWidth, y: height - halfWidth), tangent2End: CGPoint(x: halfWidth, y: height - radius - halfWidth), radius: radius)
        // 左上角
        context.addArc(tangent1End: CGPoint(x: halfWidth, y: halfWidth), tangent2End: CGPoint(x: width - halfWidth, y: halfWidth), radius: radius)
        // 右上角
        context.addArc(tangent1End: CGPoint(x: width - halfWidth, y: halfWidth), tangent2End: CGPoint(x: width - halfWidth, y: radius + halfWidth), radius: radius)
        
        context.drawPath(using: .fillStroke)
        
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
}
