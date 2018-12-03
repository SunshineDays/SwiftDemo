//
//  FBLiveFilterLeagueCollectionCell.swift
//  IULiao
//
//  Created by tianshui on 16/8/1.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLiveFilterLeagueCollectionView: UICollectionView {
    var indexPath: IndexPath!
}

class FBLiveFilterLeagueCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueButton: UIButton!
    
    static let reuseCollectionViewCellIdentifier = "FBLiveFilterLeagueCollectionCell"
    
    func configCell(league: FBLiveLeagueModel) {
        leagueButton.setTitle(league.name, for: UIControlState())
        if league.isSelected {
            leagueButton.setTitleColor(UIColor.white, for: UIControlState())
            leagueButton.setTitleColor(UIColor(hex: 0x666666), for: .highlighted)
            leagueButton.setBackgroundColor(league.color, forState: UIControlState())
            leagueButton.setBackgroundColor(UIColor.white, forState: .highlighted)
        } else {
            leagueButton.setTitleColor(UIColor(hex: 0x666666), for: UIControlState())
            leagueButton.setTitleColor(UIColor.white, for: .highlighted)
            leagueButton.setBackgroundColor(UIColor.white, forState: UIControlState())
            leagueButton.setBackgroundColor(league.color, forState: .highlighted)
        }
    }
}
