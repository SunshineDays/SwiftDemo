//
//  UserLiaoPaySuccessController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/21.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 料豆购买成功
class UserLiaoPaySuccessController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    @IBOutlet weak var payMoneyLabel: UILabel!
    
    @IBOutlet weak var liaoNumnerLabel: UILabel!
    
    @IBOutlet weak var payWayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.alwaysBounceVertical = true
    }
    
}


extension UserLiaoPaySuccessController {
    @IBAction func finishedItemClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
