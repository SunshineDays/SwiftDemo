//
//  FBMatchAnalyzeLineupTeamSwitchView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 阵容 球队选择
class FBMatchAnalyzeLineupTeamSwitchView: UIView {

    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var awayBtn: UIButton!
    
    /// 按钮选中
    var buttonSelectedBlock: ((UIButton, TeamType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(homeName: String, awayName: String) {
        homeBtn.setTitle(homeName, for: .normal)
        awayBtn.setTitle(awayName, for: .normal)
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        if homeBtn == sender {
            homeBtn.isSelected = true
            awayBtn.isSelected = false
            buttonSelectedBlock?(sender, .home)
        } else {
            homeBtn.isSelected = false
            awayBtn.isSelected = true
            buttonSelectedBlock?(sender, .away)
        }
    }
}
