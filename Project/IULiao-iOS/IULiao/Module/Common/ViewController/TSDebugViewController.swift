//
//  TSDebugViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/8/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit


/// debug设置
class TSDebugViewController: UITableViewController {

    @IBOutlet weak var urlOnlineSwitch: UISwitch!
    @IBOutlet weak var urlOfflineSwitch: UISwitch!
    @IBOutlet weak var urlLocalSwitch: UISwitch!
    
    @IBOutlet weak var displayDevelopSwitch: UISwitch!
    @IBOutlet weak var displayProductionSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let urlMode = UserDefaults.standard.string(forKey: TSSettingKey.debugUrlMode) ?? "online"
        if urlMode == "online" {
            urlOnlineSwitch.isOn = true
            urlOfflineSwitch.isOn = false
            urlLocalSwitch.isOn = false
        } else if urlMode == "local" {
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = true
            urlLocalSwitch.isOn = false
        } else {
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = true
            urlLocalSwitch.isOn = false
        }
        
        let displayMode = UserDefaults.standard.string(forKey: TSSettingKey.debugDisplayMode) ?? "develop"
        if displayMode == "production" {
            displayDevelopSwitch.isOn = false
            displayProductionSwitch.isOn = true
        } else {
            displayDevelopSwitch.isOn = true
            displayProductionSwitch.isOn = false
        }
    }
    
    @IBAction func urlSwitchClick(_ sender: UISwitch) {
        if sender == urlOnlineSwitch {
            urlOfflineSwitch.isOn = !urlOnlineSwitch.isOn
            urlLocalSwitch.isOn = !urlOnlineSwitch.isOn
        } else if sender == urlLocalSwitch {
            urlOnlineSwitch.isOn = !urlLocalSwitch.isOn
            urlOfflineSwitch.isOn = !urlLocalSwitch.isOn
        } else {
            urlOnlineSwitch.isOn = !urlOfflineSwitch.isOn
            urlLocalSwitch.isOn = !urlOfflineSwitch.isOn
        }
        
        if urlOnlineSwitch.isOn {
            UserDefaults.standard.set("online", forKey: TSSettingKey.debugUrlMode)
        } else if urlOfflineSwitch.isOn {
            UserDefaults.standard.set("offline", forKey: TSSettingKey.debugUrlMode)
        } else if urlLocalSwitch.isOn {
            UserDefaults.standard.set("local", forKey: TSSettingKey.debugUrlMode)
        }
        UserDefaults.standard.synchronize()
    
    }
    
    @IBAction func displaySwitchClick(_ sender: UISwitch) {
        if sender == displayDevelopSwitch {
            displayProductionSwitch.isOn = !displayDevelopSwitch.isOn
        } else {
            displayDevelopSwitch.isOn = !displayProductionSwitch.isOn
        }
        
        if displayDevelopSwitch.isOn {
            UserDefaults.standard.set("develop", forKey: TSSettingKey.debugDisplayMode)
        } else if displayProductionSwitch.isOn {
            UserDefaults.standard.set("production", forKey: TSSettingKey.debugDisplayMode)
        }
        UserDefaults.standard.synchronize()

    }
}
