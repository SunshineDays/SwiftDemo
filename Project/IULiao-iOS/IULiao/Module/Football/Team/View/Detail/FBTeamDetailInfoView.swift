//
//  FBTeamDetailInfoView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队详情头部
class FBTeamDetailInfoView: UIView {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var websitLabel: UILabel!
    

    func configView(team: FBTeamModel) {
        
        if let logo = TSImageURLHelper(string: team.logo).size(w: 240, h: 240).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.image120x120(), completed: nil)
        }
        
        nameLabel.text = team.name
        if team.country.count > 0 {
            nameLabel.text = "\(team.name)(\(team.country))"
        }
        if team.englishName.count > 0 {
            englishNameLabel.text = team.englishName
        }
        if team.stadium.count > 0 {
            stadiumLabel.text = team.stadium
        }
        if team.website.count > 0 {
            websitLabel.text = team.website
        }
        
    }
}
