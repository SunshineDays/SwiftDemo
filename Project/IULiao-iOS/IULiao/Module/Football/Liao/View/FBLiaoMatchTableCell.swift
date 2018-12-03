//
//  FBLiaoMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/7/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 料 表头
class FBLiaoMatchTableCell: UITableViewCell {

    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(match: FBMatchModel) {
        serialLabel.text = match.serial
        timeLabel.text = Date(match.matchTime).stringWithFormat("HH:mm")
        leagueLabel.text = match.league.name
        homeLabel.text = match.home
        awayLabel.text = match.away
        leagueLabel.textColor = match.league.color
        
        if let homeLogo = match.homeLogo {
            homeImageView.sd_setImage(with: TSImageURLHelper(string: homeLogo, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
        if let awayLogo = match.awayLogo {
            awayImageView.sd_setImage(with: TSImageURLHelper(string: awayLogo, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
    }

}
