//
//  UserAgreementViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/3.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 注册协议
class UserAgreementViewController: BaseViewController {

    @IBOutlet weak var contentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 解决TextView  显示不在第一行的问题
        self.contentTextView.scrollRangeToVisible(NSRange(location: 0, length: 1))

    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
