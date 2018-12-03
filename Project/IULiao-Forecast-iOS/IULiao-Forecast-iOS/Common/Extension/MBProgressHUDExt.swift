//
//  MBProgressHUDExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

///  提示框
extension MBProgressHUD {
    /// 显示提示信息
    class func show(info text: String) {
        let hud = self.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.superview?.backgroundColor = UIColor(hex: 0x000000, alpha: 0.9)
        hud.margin = 10
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: Double(text.count) * 0.05 + 1.0)
    }
    
    ///  显示成功信息
    class func show(success text: String) {
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.isUserInteractionEnabled = false
        hud.mode = .customView
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.superview?.backgroundColor = UIColor(hex: 0x000000, alpha: 0.9)
        hud.contentColor = UIColor.white
        hud.margin = 15
        let imageView = UIImageView(image: R.image.icon.success())
        hud.customView = imageView
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: Double(text.count) * 0.05 + 1.0)
    }
    
    /// 显示加载动画
    ///
    /// - Parameters:
    ///   - view: 动画的父视图
    ///   - text: 动画显示信息
    class func showProgress(toView view: UIView, text: String? = nil) {
        //如果已经存在弹窗，关闭旧弹窗
        MBProgressHUD.hide(for: view, animated: true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = true
        hud.margin = 20
        // 当弹窗隐藏时，从父视图中移除
        hud.removeFromSuperViewOnHide = true
        if text != nil {
            hud.mode = .indeterminate
            hud.label.text = text
            hud.label.numberOfLines = 0
            hud.label.font = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// 隐藏弹窗
    ///
    /// - Parameter view: 动画的父视图
    class func hide(from view: UIView?) {
        if let view = view {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
}
