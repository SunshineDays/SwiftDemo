//
//  FBTeamDetailGloryCollectionViewCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队荣誉
class FBTeamDetailGloryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func configCell(season: String, cup: FBTeamDetailModel.Glory.CupType) {
        
        seasonLabel.text = season
        cupImageView.image = cup.image
    }
}
