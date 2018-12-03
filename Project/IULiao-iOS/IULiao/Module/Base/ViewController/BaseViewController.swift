//
//  BaseViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD
import SwiftyJSON

/// viewcontroller基类
class BaseViewController: UIViewController {
    
    /// 加载指示器
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = MBProgressHUD(view: view)
        view.addSubview(hud)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        FBProgressHUD.isHidden()
    }
    
    deinit {
        log.info("deinit ---------- " + description)
        FBProgressHUD.isHidden()
    }
}
