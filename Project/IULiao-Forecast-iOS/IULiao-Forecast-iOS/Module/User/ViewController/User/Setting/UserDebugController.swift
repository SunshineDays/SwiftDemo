
//
//  UserDebugController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/23.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 切换环境
class UserDebugController: UITableViewController {

    @IBOutlet weak var lineSwitch: UISwitch!
    @IBOutlet weak var textSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlMode = UserDefaults.standard.string(forKey: InfoSettingKey.debugUrlMode) ?? "offline"
        if urlMode == "online" {
            lineSwitch.isOn = true
            textSwitch.isOn = false
        } else {
            lineSwitch.isOn = false
            textSwitch.isOn = true
        }
    }
    
    @IBAction func lineSwitchClick(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        isLine(sender.isOn)
    }
    
    @IBAction func textSwitchClick(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        isLine(!sender.isOn)
    }

    private func isLine(_ isLine: Bool) {
        lineSwitch.isOn = isLine
        textSwitch.isOn = !isLine
        UserDefaults.standard.set(isLine ? "online" : "offline", forKey: InfoSettingKey.debugUrlMode)
        UserDefaults.standard.synchronize()
    }
    
}
