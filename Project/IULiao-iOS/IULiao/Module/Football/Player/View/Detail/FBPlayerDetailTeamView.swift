//
//  FBPlayerDetailTeamView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员详情所在球队
class FBPlayerDetailTeamView: UIView {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var contractDeadlineLabel: UILabel!

    
    func configView(club: FBPlayerDetailModel.Club) {
        teamNameLabel.text = club.name
        contractDeadlineLabel.text = club.contractDeadline
        
        if let logo = TSImageURLHelper(string: club.logo, w: 80, h: 80).chop(mode: .alwayCrop).url {
            teamLogoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.image120x120())
        }
    }
}
