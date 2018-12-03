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
    @IBOutlet weak var customSwitch: UISwitch!
    
    @IBOutlet weak var customField: UITextField!
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
            customSwitch.isOn = false
        } else if urlMode == "local" {
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = true
            urlLocalSwitch.isOn = false
            customSwitch.isOn = false
        }else if urlMode == "customUrl"{
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = false
            urlLocalSwitch.isOn = false
            customSwitch.isOn = true
            customField.text = UserToken.shared.router
        }else {
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = true
            urlLocalSwitch.isOn = false
            customSwitch.isOn = false
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
            customSwitch.isOn = !urlOnlineSwitch.isOn
        } else if sender == urlLocalSwitch {
            urlOnlineSwitch.isOn = !urlLocalSwitch.isOn
            urlOfflineSwitch.isOn = !urlLocalSwitch.isOn
            customSwitch.isOn = !urlLocalSwitch.isOn
        } else if sender == customSwitch{
            urlOnlineSwitch.isOn = !customSwitch.isOn
            urlOfflineSwitch.isOn = !customSwitch.isOn
            urlLocalSwitch.isOn = !customSwitch.isOn
        }else {
            urlOnlineSwitch.isOn = !urlOfflineSwitch.isOn
            urlLocalSwitch.isOn = !urlOfflineSwitch.isOn
            customSwitch.isOn = !urlOfflineSwitch.isOn
        }
        
        if urlOnlineSwitch.isOn {
            urlOfflineSwitch.isOn = false
            urlLocalSwitch.isOn = false
            customSwitch.isOn = false
            UserDefaults.standard.set("online", forKey: TSSettingKey.debugUrlMode)
        } else if urlOfflineSwitch.isOn {
            urlOnlineSwitch.isOn = false
            urlLocalSwitch.isOn = false
            customSwitch.isOn = false
            UserDefaults.standard.set("offline", forKey: TSSettingKey.debugUrlMode)
        } else if urlLocalSwitch.isOn {
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = false
            customSwitch.isOn = false
            UserDefaults.standard.set("local", forKey: TSSettingKey.debugUrlMode)
        }else if customSwitch.isOn{
            urlOnlineSwitch.isOn = false
            urlOfflineSwitch.isOn = false
            urlLocalSwitch.isOn = false
            UserDefaults.standard.set("customUrl", forKey: TSSettingKey.debugUrlMode)
            UserDefaults.standard.set(customField.placeholder ??  customField.placeholder, forKey: TSSettingKey.debugUpdateRouter)
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
