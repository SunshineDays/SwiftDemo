//
//  FBOddsCompanyCollectionCell.swift
//  IULiao
//
//  Created by tianshui on 16/8/17.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBOddsCompanyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var companyButton: UIButton!
    
    static let reuseCollectionViewCellIdentifier = "FBOddsCompanyCollectionCell"
    
    func configCell(company: CompanyModel) {
        companyButton.setTitle(company.name, for: UIControlState())
        if company.isSelected {
            companyButton.setTitleColor(UIColor.white, for: UIControlState())
            companyButton.setTitleColor(UIColor(hex: 0x666666), for: .highlighted)
            companyButton.setBackgroundColor(baseNavigationBarTintColor, forState: UIControlState())
            companyButton.setBackgroundColor(UIColor.white, forState: .highlighted)
        } else {
            companyButton.setTitleColor(UIColor(hex: 0x666666), for: UIControlState())
            companyButton.setTitleColor(UIColor.white, for: .highlighted)
            companyButton.setBackgroundColor(UIColor.white, forState: UIControlState())
            companyButton.setBackgroundColor(baseNavigationBarTintColor, forState: .highlighted)
        }
    }
    
}
