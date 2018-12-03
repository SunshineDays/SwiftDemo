//
//  UIButtonExt.swift
//  HuaXia
//
//  Created by tianshui on 15/10/27.
// 
//

import Foundation
import UIKit

extension UIButton {

    enum ImageViewPositionStyle: Int {
        case top
        case left
        case right
        case bottom
        case center
    }

    /// 设置图片的位置 offset偏移量(当使用contentHorizontalAlignment会导致偏移量超出button)
    /// title内容改变后需要重新调用 否则布局可能会错乱
    func layoutImageViewPosition(_ position: ImageViewPositionStyle, withOffset offset: CGFloat) {
        let imageWidth = imageView?.width ?? 0
        let imageHeight = imageView?.height ?? 0
        let labelWidth = titleLabel?.intrinsicContentSize.width ?? 0
        let labelHeight = titleLabel?.intrinsicContentSize.height ?? 0
        
        let halfOffset = offset / 2
        
        var titleEdgeInsets = UIEdgeInsets.zero
        var imageEdgeInsets = UIEdgeInsets.zero

        switch position {

        case .top:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - halfOffset, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - halfOffset, left: 0, bottom: 0, right: -labelWidth)
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: halfOffset, bottom: 0, right: -halfOffset)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -halfOffset, bottom: 0, right: halfOffset)
        case .bottom:
            titleEdgeInsets = UIEdgeInsets(top: -imageHeight - halfOffset, left: -imageWidth, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - halfOffset, right: -labelWidth)
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth  - halfOffset, bottom: 0, right: imageWidth + halfOffset)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + halfOffset, bottom: 0, right: -labelWidth - halfOffset)
        case .center:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -labelWidth)
        }
        self.titleEdgeInsets = titleEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }

    /// 设置背景颜色
    func setBackgroundColor(_ color: UIColor, forState state: UIControlState) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        setBackgroundImage(image, for: state)
    }

    /// 添加圆角
    func setCornerRadius(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

}

extension UIButton {

    /// 可视化设置正常状态背景色
    @IBInspectable var bgColorForNormalState: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .normal)
            }
        }
    }

    @IBInspectable var bgColorForHighlightedState: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .highlighted)
            }
        }
    }

    @IBInspectable var bgColorForDisabledState: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .disabled)
            }
        }
    }

    @IBInspectable var bgColorForSelectedState: UIColor? {
        get {
            return nil
        }
        set {
            if let newValue = newValue {
                setBackgroundColor(newValue, forState: .selected)
            }
        }
    }
}
