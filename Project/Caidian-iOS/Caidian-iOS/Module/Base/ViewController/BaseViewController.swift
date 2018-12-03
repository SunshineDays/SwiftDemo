//
//  BaseViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD

/// viewController基类
class BaseViewController: UIViewController {
    
    private var _hud: MBProgressHUD?
    /// 加载指示器
    var hud: MBProgressHUD {
        if _hud == nil {
            _hud = MBProgressHUD(view: view)
            view.addSubview(_hud!)
        }
        view.bringSubview(toFront: _hud!)
        return _hud!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        log.info("deinit ---------- " + description)
    }
}
