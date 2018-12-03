//
//  LotteryHomeCell.swift
//  Caidian-iOS
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

class LotteryHomeCell : UICollectionViewCell{
    
    @IBOutlet weak var lotteryLogoImg: UIImageView!
    
    @IBOutlet weak var lotteryNameLabel: UILabel!
    
    func configCell(lotterySaleModel : HomeLotteryModel) {
        
        lotteryNameLabel.text = lotterySaleModel.lotteryName
        lotteryLogoImg.image = lotterySaleModel.lotteryType.logo


    }

    
}
