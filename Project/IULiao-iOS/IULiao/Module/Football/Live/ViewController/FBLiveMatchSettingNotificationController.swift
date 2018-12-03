//
//  FBLiveMatchSettingNotificationController.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 系统推送设置
class FBLiveMatchSettingNotificationController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initListener()
        initView()
        initNetwork()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postSetingEditData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 通知开启状态label
    @IBOutlet weak var notificationTitleLabel: UILabel!
    
    private let settingHandler = FBLiveMatchSettingHandler()
    
    private var settingModel: FBLiveSettingModel! = nil {
        didSet {
            
        }
    }
    
    /// switch打开状态数组
    private var switchIsOns = [Int]()
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(URL(string: "App-Prefs:root=NOTIFICATIONS_ID")!, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(URL(string: "prefs:root=SETTING")!)
//            }
        }
    }

}

// MARK: - Init
extension FBLiveMatchSettingNotificationController {
    private func initListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpdateAction(_:)), name: TSNotification.userNotificationUpdate.notification, object: nil)
    }
    
    private func initView() {
        notificationTitleLabel.text = isOpenNotification() ? "已开启" : "已关闭"
    }
    
    private func initNetwork() {
        tableView.reloadData()
        getSettingData()
    }
}

// MARK: - Request
extension FBLiveMatchSettingNotificationController {
    
    private func getSettingData() {
        settingHandler.getSettingData(success: { [weak self] (model) in
            self?.settingModel = model
            self?.switchUpdate()
        }) { (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    private func postSetingEditData() {
        if switchIsOns.count > 0 {
            settingHandler.postSettingData(liveStart: switchIsOns[0], liveHalf: switchIsOns[1], liveOver: switchIsOns[2], liveGoal: switchIsOns[3], liveRed: switchIsOns[4], success: { (json) in
                
            }) { (error) in
                TSToast.showNotificationWithTitle(error.localizedDescription)
            }
        }
    }
}

// MARK: - Action
extension FBLiveMatchSettingNotificationController {
    @IBAction func rowSwitchAction(_ sender: UISwitch) {
        switchIsOns[sender.tag - 1000] = sender.isOn ? 1 : 0
    }
    
    @objc private func notificationUpdateAction(_ notification: Notification) {
        initView()
        switchUpdate()
    }
}

// MARK: - Method
extension FBLiveMatchSettingNotificationController {
    private func isOpenNotification() -> Bool {
        return UIApplication.shared.currentUserNotificationSettings?.types != UIUserNotificationType(rawValue: 0)
    }
    
    private func switchUpdate() {
        let isOns = [settingModel.liveStart, settingModel.liveHalf, settingModel.liveOver, settingModel.liveGoal, settingModel.liveRed]
        for i in 0 ..< isOns.count {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1))
            for view in (cell?.contentView.subviews)! {
                if view is UISwitch {
                    (view as! UISwitch).isOn = isOns[i] == 1
                    (view as! UISwitch).isEnabled = isOpenNotification()
                    switchIsOns.append(isOns[i])
                }
            }
        }
    }
}



