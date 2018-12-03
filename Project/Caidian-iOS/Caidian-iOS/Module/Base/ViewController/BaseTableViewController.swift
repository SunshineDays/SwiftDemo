//
//  BaseTableViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD

/// tableViewController基类
class BaseTableViewController: UITableViewController {

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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    deinit {
        log.info("deinit ---------- " + description)
    }

}
