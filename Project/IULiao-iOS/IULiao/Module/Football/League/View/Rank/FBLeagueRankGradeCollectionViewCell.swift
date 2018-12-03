//
//  FBLeagueRankGradeCollectionViewCell.swift
//  IULiao
//
//  Created by tianshui on 2017/10/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLeagueRankGradeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configCell(grade: FBLeagueRankGradeModel) {
        colorView.backgroundColor = grade.color
        nameLabel.text = grade.text
    }
    
}
