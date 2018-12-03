//
//  FBPlayerDetailSkillView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员技能
class FBPlayerDetailSkillView: UIView {

    @IBOutlet var positionLabels: [UILabel]!
    @IBOutlet var advantageLabels: [UILabel]!
    @IBOutlet var disadvantageLabels: [UILabel]!
    @IBOutlet weak var positionView: FBPlayerDetailPositionView!
    
    func configView(skill: FBPlayerDetailModel.Skill) {
        for (index, position) in skill.positions.enumerated() {
            guard let label = positionLabels[safe: index] else {
                break
            }
            label.text = position.cn
            label.isHidden = false
        }
        
        for (index, advantage) in skill.advantages.enumerated() {
            guard let label = advantageLabels[safe: index] else {
                break
            }
            label.text = advantage
            label.isHidden = false
        }
        
        for (index, disadvantage) in skill.disadvantages.enumerated() {
            guard let label = disadvantageLabels[safe: index] else {
                break
            }
            label.text = disadvantage
            label.isHidden = false
        }
        positionView.configView(skill: skill)
    }
}
