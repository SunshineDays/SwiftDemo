//
//  FBMatchWarSameHandicapToolbarView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 同盘 头部toolbar
class FBMatchWarSameHandicapToolbarView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var matchNumberButton: UIButton!
    
    var numberButtonClickBlock: ((_ button: UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        matchNumberButton.layoutImageViewPosition(.right, withOffset: 5)
    }
    
    @IBAction func numberButtonClick(_ sender: UIButton) {
        numberButtonClickBlock?(sender)
    }
    
}
