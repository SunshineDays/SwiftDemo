//
//  FBMatchWarRecentToolbarView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 战绩 头部toolbar
class FBMatchWarRecentToolbarView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var matchNumberButton: UIButton!
    @IBOutlet weak var leagueFilterButton: UIButton!
    @IBOutlet weak var sameHomeAwayButton: UIButton!
    
    var numberButtonClickBlock: ((_ button: UIButton) -> Void)?
    var leagueFilterButtonClickBlock: ((_ button: UIButton) -> Void)?
    var sameHomeAwayButtonClickBlock: ((_ button: UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        matchNumberButton.layoutImageViewPosition(.right, withOffset: 5)
    }
    
    @IBAction func numberButtonClick(_ sender: UIButton) {
        numberButtonClickBlock?(sender)
    }
    
    @IBAction func leagueFilterButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        leagueFilterButtonClickBlock?(sender)
    }
    
    @IBAction func sameHomeAwayButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sameHomeAwayButtonClickBlock?(sender)
    }
    
}
