//
//  UserSettingViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/7/3.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 设置
class UserSettingViewController: BaseTableViewController {
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var cacheSizeLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    var cacheSize: String {
         return String(format: "%.2fM", CGFloat(SDImageCache.shared().getSize()) / 1024 / 1024)
      //  let size = FCFileManager.sizeOfDirectory(atPath: FCFileManager.pathForCachesDirectory())
       // return FCFileManager.sizeFormatted(size)
    }
    
    let appVersion: String = {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initDebugItem()
    }

    @IBAction func logoutClick(_ sender: UIButton) {
        
        // 退出登录
        let alert = UIAlertController(title: nil, message: "确定要退出登录？", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "退出登录", style: .destructive) {
            a in
            NotificationCenter.default.post(name: UserNotification.userLogoutSuccessful.notification, object: self)
            UserLoginHandler().logout(success: {
            }, failed: { (error) in
                
            })
            UserToken.shared.clear()
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cacheSizeLabel.text = cacheSize
    }
    
}

extension UserSettingViewController {
    
    private func initView() {
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        logoutBtn.isHidden = !UserToken.shared.isLogin
        cacheSizeLabel.text = cacheSize
        versionLabel.text = appVersion
    }
    
    private func initDebugItem() {
        if isDebug {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Debug", style: .plain, target: self, action: #selector(debugItemClick))
        }
    }
    
    @objc private func debugItemClick() {
        let vc = R.storyboard.userSetting.userDebugController()!
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserSettingViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0): // 清除缓存
            let alert = UIAlertController(title: "清除缓存", message: "确定要清除缓存内容？", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "清除", style: .destructive, handler: { (action) in
                SDImageCache.shared().clearDisk(onCompletion: {
                    [weak self] in
                    self?.cacheSizeLabel.text = self?.cacheSize
                })
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        case (0, 1): //跳转到App Store
            if let url = URL(string: kConstantsAppItunesURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = (cachePath)!+("/\(file)")
    
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        
        return mm
    }
    func clearCache() {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath!+("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
    }

}
