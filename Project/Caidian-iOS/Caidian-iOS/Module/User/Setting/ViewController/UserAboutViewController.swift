//
//  UserAboutViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/3.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 关于
class UserAboutViewController: BaseViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    
    let appVersion: String = {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "版本\(appVersion)"
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        introTextView.contentOffset = CGPoint.zero
    }
}
