//
//  BaseTableViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/11/20.
// 
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import SDWebImage
/// tableViewController基类
class BaseTableViewController: UITableViewController {

    /// 加载指示器
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = MBProgressHUD(view: view)
        view.addSubview(hud)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    deinit {
        log.info("deinit ---------- " + description)
    }

}
