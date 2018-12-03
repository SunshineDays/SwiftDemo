//
//  FBLiveMatchSettingController.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 设置
class FBLiveMatchSettingController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.reloadData()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var settings = UserToken.shared.userNotifictionSetting


}

// MARK: - Init
extension FBLiveMatchSettingController {
    
    private func initView() {
        for i in 0 ..< settings.count {
            var row = i
            var section = 0
            if i >= 2 {
                row = i - 2
                section = 1
            }
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: section))
            for view in (cell?.contentView.subviews)! {
                if view is UISwitch {
                    (view as! UISwitch).isOn = settings[i]
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension FBLiveMatchSettingController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            tableView.deselectRow(at: indexPath, animated: true)
            if UserToken.shared.isLogin {
                let vc = R.storyboard.fbLive2.fbLiveMatchSettingNotificationController()!
                navigationController?.show(vc, sender: nil)
            } else {
                let vc = R.storyboard.userLogin().instantiateInitialViewController()
                present(vc!, animated: true, completion: nil)
            }
            
        }
    }
}

// MARK: - Action
extension FBLiveMatchSettingController {
    @IBAction func rowSwitchAction(_ sender: UISwitch) {
        settings[sender.tag - 1000] = sender.isOn
        UserToken.shared.update(setting: settings)
    }
}
