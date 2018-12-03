//
//  CollectionViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/18.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购彩大厅头部彩种cell
class HomeHeadCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleOneLabel: UILabel!
    @IBOutlet weak var titleTwoLabel: UILabel!
    @IBOutlet weak var stopImageView: UIImageView!
    

    func configCell(lotteryModel: HomeLotteryModel, index: Int) {
        img.image = getImgFromIndex(index: index)
        titleOneLabel.text = lotteryModel.lotteryName
        titleTwoLabel.text = lotteryModel.description
        stopImageView.isHidden = lotteryModel.isSale
    }

    func getImgFromIndex(index: Int) -> UIImage? {
        switch index {
        case 0: return R.image.home.lotteryJczq()
        case 1: return R.image.home.lotteryJclq()
        case 2: return R.image.home.lotterySfc()
        case 3: return R.image.home.lotteryBqc()
        case 4: return R.image.home.lotteryBf()
        default: return R.image.home.lotteryJqs()
        }
    }

}
