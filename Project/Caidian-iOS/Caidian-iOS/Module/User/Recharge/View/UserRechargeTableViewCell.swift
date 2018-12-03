//
//  UserRechargeTableViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/27.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 充值 充值方式的cell
class UserRechargeTableViewCell: UITableViewCell {

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!


    func configCell(rechargeModel: UserRechargeModel) {
        logoImageView.sd_setImage(with: URL(string: rechargeModel.logo), placeholderImage: R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload], progress: nil, completed: nil)
        nameLabel.text = rechargeModel.name
        descriptionLabel.text = rechargeModel.description
        selectImageView.isHighlighted = rechargeModel.isRecommend

    }
}
