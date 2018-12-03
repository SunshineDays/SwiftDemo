//
//  FBLiveGoalDialogTableCell.swift
//  IULiao
//
//  Created by tianshui on 16/8/8.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLiveGoalDialogTableCell: UITableViewCell {

    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    
    @IBOutlet weak var homeImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayImageViewWidthConstraint: NSLayoutConstraint!
    
    
    static let reuseTableCellIdentifier = "FBLiveGoalDialogTableCell"

    
    func configCell(match: FBLiveMatchModel2) {
        homeLabel.text = match.home
        awayLabel.text = match.away
        homeScoreLabel.text = "\(match.homeScore ?? 0)"
        awayScoreLabel.text = "\(match.awayScore ?? 0)"
        
        /// 球队进球方 球队名与比分标记红色
        if match.lastHomeScore != nil && match.lastHomeScore != match.homeScore {
            homeLabel.textColor = FBColorType.red.color
            homeScoreLabel.textColor = FBColorType.red.color
            homeImageView.isHidden = false
            homeImageViewWidthConstraint.constant = 20
        } else {
            homeLabel.textColor = UIColor.black
            homeScoreLabel.textColor = UIColor.black
            homeImageView.isHidden = true
            homeImageViewWidthConstraint.constant = 0
        }
        
        if match.lastAwayScore != nil && match.lastAwayScore != match.awayScore {
            awayLabel.textColor = FBColorType.red.color
            awayScoreLabel.textColor = FBColorType.red.color
            awayImageView.isHidden = false
            awayImageViewWidthConstraint.constant = 20
        } else {
            awayLabel.textColor = UIColor.black
            awayScoreLabel.textColor = UIColor.black
            awayImageView.isHidden = true
            awayImageViewWidthConstraint.constant = 0
        }
    }
    
}
