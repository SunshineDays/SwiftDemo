//
//  FBPlayerDetailTransferTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 转会历史 cell
class FBPlayerDetailTransferTableCell: UITableViewCell {

    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configCell(transfer: FBPlayerDetailModel.Transfer, isCurretTeam: Bool) {
        teamNameLabel.text = transfer.inTeam.name
        dateLabel.text = transfer.beginDateString
        if transfer.money > 0 {
            categoryLabel.text = "\(transfer.money)万英镑"
        } else {
            categoryLabel.text = transfer.category
        }
        if isCurretTeam {
            categoryLabel.textColor = TSColor.matchResult.draw
        } else {
            categoryLabel.textColor = TSColor.gray.gamut333333
        }
        
        if let logo = TSImageURLHelper(string: transfer.inTeam.logo, w: 80, h: 80).chop(mode: .fillCrop).url {
            teamLogoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.teamLogo50x50())
        }
    }
}
