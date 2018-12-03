//
//  UserNoticeListViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftyJSON
import CRToast


/// 消息
class UserNoticeListViewController: TSListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
