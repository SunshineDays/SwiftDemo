//
//  BaseNavigationController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD
import SwiftyJSON

let baseNavigationBarTintColor = UIColor(hex: 0xff8b19)

/// navigationcontroller基类
class BaseNavigationController: UINavigationController {

    /// 加载指示器
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = MBProgressHUD(view: view)
        view.addSubview(hud)
        
        // 左右侧按钮颜色
        navigationBar.tintColor = UIColor.white
        
        // title 属性
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // #0091FF
        navigationBar.barTintColor = baseNavigationBarTintColor
        navigationBar.isTranslucent = true
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        log.info("deinit")
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

