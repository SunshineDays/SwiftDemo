//
//  FBPlayerDetailInfoView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员详情 信息
class FBPlayerDetailInfoView: UIView {

    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var preferredFootLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var estimatedValueLabel: UILabel!
    
    
    func configView(detail: FBPlayerDetailModel) {
        let player = detail.playerInfo
        
        if player.nationality.count > 0 {
            nationalityLabel.text = player.nationality
        }
        if let age = player.age {
            ageLabel.text = "\(age)岁"
        }
        if let height = player.height {
            heightLabel.text = "\(height)CM"
        }
        if let weight = player.weight {
            weightLabel.text = "\(weight)KG"
        }
        if let number = player.number {
            numberLabel.text = "\(number)号"
        }
        if let preferredFoot = player.preferredFoot {
            preferredFootLabel.text = preferredFoot
        }
        if detail.clubInfo.estimatedValue > 0 {
            estimatedValueLabel.text = "\(detail.clubInfo.estimatedValue)万英镑"
        }
        if detail.skill.positions.count > 0 {
            positionLabel.text = detail.skill.positions.first?.cn
        }
    }
}
