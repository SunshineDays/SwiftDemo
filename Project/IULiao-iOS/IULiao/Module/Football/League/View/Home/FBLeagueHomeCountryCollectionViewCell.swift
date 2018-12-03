//
//  FBLeagueHomeCountryCollectionViewCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 国家
class FBLeagueHomeCountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                countryNameLabel.backgroundColor = UIColor(hex: 0xFCE3CA)
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.1,
                    options: .curveEaseInOut,
                    animations: {
                        self.countryNameLabel.backgroundColor = UIColor.clear
                },
                    completion: nil
                )
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                countryNameLabel.backgroundColor = UIColor(hex: 0xFCE3CA)
            } else {
                countryNameLabel.backgroundColor = UIColor.clear
            }
        }
    }
    
    func configCell(country: FBLeagueCountryModel, isSelected: Bool) {
        countryNameLabel.text = country.name
        countryNameLabel.borderWidthPixel = isSelected ? 0 : 1
        bgView.isHidden = !isSelected
    }
    
    func configCellEmpty() {
        countryNameLabel.text = ""
        countryNameLabel.borderWidthPixel = 0
        bgView.isHidden = true
    }
}

/// 国家下属联赛
class FBLeagueHomeCountryLeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var bgViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewRightConstraint: NSLayoutConstraint!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                leagueNameLabel.backgroundColor = UIColor(hex: 0xd9d9d9)
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.1,
                    options: .curveEaseInOut,
                    animations: {
                        self.leagueNameLabel.backgroundColor = UIColor.clear
                },
                    completion: nil
                )
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                leagueNameLabel.backgroundColor = UIColor(hex: 0xd9d9d9)
            } else {
                leagueNameLabel.backgroundColor = UIColor.clear
            }
        }
    }
    
    func configCell(league: FBLeagueModel?, showLeftSpace: Bool = true, showRightSpace: Bool = true) {
        leagueNameLabel.text = league?.name ?? ""
        bgViewLeftConstraint.constant = showLeftSpace ? 3 : 0
        bgViewRightConstraint.constant = showRightSpace ? 3 : 0
    }
}
