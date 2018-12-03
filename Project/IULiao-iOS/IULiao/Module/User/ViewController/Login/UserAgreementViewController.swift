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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
