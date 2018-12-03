//
//  FBRecommendDetailLookCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/8.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 浏览记录 UICollectionViewCell
class FBRecommendDetailLookCell: UICollectionViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var model: FBRecommendDetailLookModel! = nil {
        didSet {
            if let url = TSImageURLHelper.init(string: model.avatar, w: 60, h: 60).chop(mode: .fillCrop).url {
                userImageView.sd_setImage(with: url, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
            }
            else {
                userImageView.image = R.image.fbRecommend2.avatar60x60()
            }
        }
    }
    
}
